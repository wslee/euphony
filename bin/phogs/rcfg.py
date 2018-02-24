import re
import options
from utils import basetypes
import sys
import collections
from enum import IntEnum
from exprs import exprs
from exprs import exprtypes
import math
import heapq
import functools
from core import grammars
from enumerators import enumerators
from parsers import parser
from semantics import semantics_core
from semantics import semantics_types
from core import synthesis_context
import random
import pickle
import itertools
import sklearn
import numpy as np
from phogs.phog_utils import *
import pdb


eu = False

def get_func_exprs_grammars(benchmark_files):
    global eu

    # Grammars
    results = []
    # for eusolver
    ite_related_macros = []
    for benchmark_file in benchmark_files:
        fun_exprs = []
        print('Loading : ', benchmark_file)

        file_sexp = parser.sexpFromFile(benchmark_file)
        if file_sexp is None:
            continue

        core_instantiator = semantics_core.CoreInstantiator()
        theory_instantiators = [parser.get_theory_instantiator(theory) for theory in parser._known_theories]

        macro_instantiator = semantics_core.MacroInstantiator()
        uf_instantiator = semantics_core.UninterpretedFunctionInstantiator()
        synth_instantiator = semantics_core.SynthFunctionInstantiator()

        syn_ctx = synthesis_context.SynthesisContext(
            core_instantiator,
            *theory_instantiators,
            macro_instantiator,
            uf_instantiator,
            synth_instantiator)
        syn_ctx.set_macro_instantiator(macro_instantiator)

        defs, _ = parser.filter_sexp_for('define-fun', file_sexp)
        if defs is None: defs = []

        for [name, args_data, ret_type_data, interpretation] in defs:
            for eusolver in ([True, False] if eu else [False]):
                ((arg_vars, arg_types, arg_var_map), return_type) = parser._process_function_defintion(args_data, ret_type_data)
                expr = parser.sexp_to_expr(interpretation, syn_ctx, arg_var_map)
                macro_func = semantics_types.MacroFunction(name, len(arg_vars), tuple(arg_types), return_type, expr,
                                                           arg_vars)
                # for eusolver  (recording macro functions of which definition include ite)
                if eusolver:
                    app = exprs.find_application(expr, 'ite')
                    if app is not None: ite_related_macros.append(name)

                macro_instantiator.add_function(name, macro_func)
                i = 0
                subs_pairs = []
                for (var_expr, ty) in zip(arg_vars, arg_types):
                    param_expr = exprs.FormalParameterExpression(None,ty,i)
                    subs_pairs.append((var_expr, param_expr))
                    i += 1
                expr = exprs.substitute_all(expr, subs_pairs)
                # resolve macro functions involving ite (for enumeration of pred exprs (eusolver))
                if eusolver:
                    for fname in ite_related_macros:
                        app = exprs.find_application(expr, fname)
                        if app is None: continue
                        expr = macro_instantiator.instantiate_macro(expr, fname)
                fun_exprs.append(expr)

        @static_var("cnt", 0)
        def rename(synth_funs_data):
            for synth_fun_data in synth_funs_data:
                # to avoid duplicated names
                synth_fun_data[0] = "__aux_name__" + benchmark_file + str(rename.cnt)
                rename.cnt += 1


        # collect grammars
        synth_funs_data, _ = parser.filter_sexp_for('synth-fun', file_sexp)
        if len(synth_funs_data) == 0:
            synth_funs_data, _ = parser.filter_sexp_for('synth-inv', file_sexp)
            rename(synth_funs_data)
            synth_funs_grammar_data = parser.process_synth_invs(synth_funs_data, synth_instantiator, syn_ctx)
        else:
            rename(synth_funs_data)
            synth_funs_grammar_data = parser.process_synth_funcs(synth_funs_data, synth_instantiator, syn_ctx)

        grammar = None
        for synth_fun, arg_vars, grammar_data in synth_funs_grammar_data:
            if grammar_data != 'Default grammar':
                # we only consider a single function synthesis for now
                grammar = parser.sexp_to_grammar(arg_vars, grammar_data, synth_fun, syn_ctx)
                break

        results.append((fun_exprs, grammar))

    return results


def count_subsequence(sequence, sub_sequence):
    l=len(sub_sequence)
    count=0
    for i in range(len(sequence)-len(sub_sequence)+1):
        if(sequence[i:i+len(sub_sequence)] == sub_sequence ):
            count+=1
    return count

def get_all_subsequences(sequence):
    length = len(sequence)
    return [sequence[i:j+1] for i in range(length) for j in range(i,length)]


def get_derivation_sequences(expr, grammar):
    result = []
    # print(exprs.expression_to_string(expr))
    # print(str(grammar))

    nts = grammar.non_terminals
    for nt in nts:
        seq = []
        start = grammars.NTRewrite(nt, grammar.nt_type[nt])
        seq.append(start)

        current = start
        nts_addrs = [[]]

        changed = True
        while changed:
            if (len(nts_addrs) == 0):
                break
            changed = False
            expanded_result = [(rule, next_rewrite, generated_nts_addrs) for rule, next_rewrite, generated_nts_addrs in grammar.one_step_expand(current, nts_addrs[0])]
            for (rule, next_rewrite, generated_nts_addrs) in expanded_result:
                rule_topsymb = fetchop_rewrite(rule)
                topsymb = fetchop(fetch_prod(expr, nts_addrs[0]))
                if rule_topsymb == topsymb or isinstance(rule, grammars.NTRewrite):
                    # print('current_rewrite : ', str(current))
                    # print('next_rewrite : ', str(next_rewrite))
                    # pdb.set_trace()
                    if not isinstance(rule, grammars.NTRewrite):
                        seq.append(next_rewrite)
                    nts_addrs = nts_addrs[1:] if len(generated_nts_addrs) == 0 else generated_nts_addrs + nts_addrs[1:]
                    current = next_rewrite
                    changed = True
                    break
        if (len(seq) > 1):
            result.append(seq)

    return result


# Print iterations progress
def printProgressBar (iteration, total, prefix = '', suffix = '', decimals = 1, length = 100, fill = '█'):
    """
    Call in a loop to create terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        length      - Optional  : character length of bar (Int)
        fill        - Optional  : bar fill character (Str)
    """
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix), end = '\r')
    # Print New Line on Complete
    if iteration == total:
        print()


if __name__ == "__main__":
    import pickle
    import sys
    import argparse

    sys.setrecursionlimit(10000)

    argparser = argparse.ArgumentParser(description='Train RCFG model')
    argparser.add_argument('-text', action='store_true')
    argparser.add_argument('-out', type=str, default='rcfg_out')
    argparser.add_argument('-threshold', type=int, default='3')
    argparser.add_argument('bench', nargs=argparse.REMAINDER)

    if len(sys.argv) < 2:
        argparser.print_usage()
        exit(0)

    args = argparser.parse_args()
    occurrence_threshold = args.threshold
    output_file = args.out
    benchmark_files = args.bench

    # bechmark_file format : original benchmark_file + its solution
    fun_exprs_grammars = get_func_exprs_grammars(benchmark_files)
    assert (len(fun_exprs_grammars) > 0)

    rewrite2cnt = {}
    rewrite2loc = {}
    all_seqs = []

    for nth, (fun_exprs, grammar) in enumerate(fun_exprs_grammars):
        printProgressBar(nth, len(fun_exprs_grammars), prefix='Progress:', suffix='Complete', length=100)
        target_exprs = []
        for fun_expr in fun_exprs:
            for e in exprs.get_all_exprs(fun_expr):
                if exprs.get_expression_size(e) > 2 and exprs.get_expression_type(e) == exprs.get_expression_type(fun_expr):
                    target_exprs.append(e)
        for expr in target_exprs:
            deriv_seqs = get_derivation_sequences(expr, grammar)
            for i, deriv_seq in enumerate(deriv_seqs):
                if len(deriv_seq) <= 2: continue
                for j, deriv in enumerate(deriv_seq[2:]):
                    if not str(deriv) in rewrite2cnt:
                        rewrite2cnt[str(deriv)] = 0
                    rewrite2cnt[str(deriv)] += 1
                    rewrite2loc[str(deriv)] = (len(all_seqs) + i, j + 2)
            all_seqs = all_seqs + deriv_seqs

    items = [(deriv_str, cnt) for deriv_str, cnt in rewrite2cnt.items() if cnt >= occurrence_threshold]
    items.sort(key=lambda x: x[1], reverse=True)

    rewrite2seq = {}
    for n, pair in enumerate(items):
        (deriv_str, cnt) = pair
        (i, j) = rewrite2loc[deriv_str]
        rewrite2seq[deriv_str] = (cnt, [str(rewrite) for rewrite in all_seqs[i][0:j+1]])
            # print(deriv_str, rewrite2seq[deriv_str])

    if args.text:
        with open(output_file, 'w') as f:
            for sentential, (cnt, deriv_seq) in rewrite2seq.items():
                f.write('--- %s : %d --- \n' % (sentential, cnt))
                f.write(' => '.join(deriv_seq))
                f.write('\n')
    else:
        with open(output_file, 'wb') as f:
            pickle.dump(rewrite2seq, f)
    exit(0)
