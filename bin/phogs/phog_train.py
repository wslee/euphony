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
from phogs.phog_utils import *
from benchmarks import *

max_score = 9999999.0
# write_instrs = [Tcond.WRITE_VALUE, Tcond.WRITE_TYPE]
# we do not use write_type for now
write_instrs = [Tcond.WRITE_VALUE]
begin_instrs = [Tcond.UP, Tcond.LEFT, Tcond.PREV_DFS]
move_instrs = [Tcond.UP, Tcond.DOWN_FIRST, Tcond.DOWN_LAST, Tcond.LEFT, Tcond.RIGHT, Tcond.PREV_DFS]

# parameter for penalizing too complicated tcond programs
# lambda_penalize = 0.05
# maximum #. of iteration for the total training
max_iter = 10
# maximum #. of iteration for program generator
max_iter_gen = 100
# maximum #. of iteration for data sampling
max_iter_sample = 100
# maximum size of candidate program/data list
pool_size = 10
# k-fold cross validation
k_fold = 2
# perform witten-bell interpolation?
do_wb = True
# perform data sampling?
do_sample = True
# learn PHOG on a decomposed grammar?
eu = False

# maximum program size when randomly generating programs.
max_prog_size = 30

# thresholds for penalizing long instructions
wb_threshold = 300000
write_num_threshold = 5

# lambda candidates
lambda_candidates = [1.0, 2.0, 3.0, 4.0, 5.0]
# lambda_candidates = [10.0, 20.0, 30.0, 40.0, 50.0]

# alpha value for stupid backoff
alpha = 0.1

# pre-compute information about exprs
exprs_info = None

n_cores = 4

exprstr2expr = {}


def get_func_exprs_grammars(benchmark_files):
    global eu

    # Grammars
    grammars = set([])
    rettype2fun_exprs = {}
    # for eusolver
    ite_related_macros = []
    for benchmark_file in benchmark_files:
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
            for eusolver in ([True] if eu else [False]):
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
                    i = random.randint(1,100000) if eu else i
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
                if (return_type, eusolver) not in rettype2fun_exprs:
                    rettype2fun_exprs[(return_type, eusolver)] = set([])
                rettype2fun_exprs[(return_type, eusolver)].add(expr)

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

        for synth_fun, arg_vars, grammar_data in synth_funs_grammar_data:
            if grammar_data != 'Default grammar':
                grammar = parser.sexp_to_grammar(arg_vars, grammar_data, synth_fun, syn_ctx)
                grammars.add(grammar)

    return rettype2fun_exprs, grammars


class Mode(IntEnum):
    DELETE = 0
    MODIFY = 1
    ADD = 2


def prog_to_str(prog):
    return ' '.join([str(int(i)) for i in prog])


# @static_var("cache", {})
# def get_data_expr(expr, prog):
#     key = (expr, tuple(prog))
#     if key in get_data_expr.cache:
#         return get_data_expr.cache[key]
#
#     result = []
#     banned = set()
#     stack = [(expr, [])]
#     while len(stack) > 0:
#         v, addr = stack.pop(0)
#         if exprs.is_function_expression(v):
#             for i,child in enumerate(v.children):
#                 new_addr = list(addr)
#                 new_addr.append(i)
#                 banned.add(tuple(new_addr))
#                 stack.append((child,new_addr))
#
#     stack = [(expr, [])]
#     while len(stack) > 0:
#         v, addr = stack.pop(0)
#         banned.discard(tuple(addr))
#         _,ctxt = get_ctxt(expr, addr, prog, banned)
#         term_symb = fetchop(v)
#         cond = ','.join(ctxt)
#         result.append((cond, term_symb))
#         if exprs.is_function_expression(v):
#             added = []
#             for i,child in enumerate(v.children):
#                 new_addr = list(addr)
#                 new_addr.append(i)
#                 added.append((child, new_addr))
#             stack[0:0] = added
#
#     get_data_expr.cache[key] = result
#     return result

def get_data_expr(expr, prog):
    global exprs_info

    (expr2history, expr2cache) = exprs_info
    assert (expr in expr2history and expr in expr2cache)
    result = []
    for (expr, target_addr) in expr2history[expr]:
        # move_cache : addr x instr -> addr'
        # write_cache : addr -> topsymb, toptype
        (move_cache, write_cache) = expr2cache[expr]
        curr_addr = target_addr
        ctxt = []
        # here, term_symb stands for a fired rule.
        term_symb, _ = write_cache[target_addr]
        for instr in prog:
            if instr in write_instrs:
                if curr_addr != target_addr:
                    symb_at_curr_addr, type_at_curr_addr = write_cache[curr_addr]
                    if instr == Tcond.WRITE_VALUE:
                        ctxt.append(symb_at_curr_addr)
                    else:
                        ctxt.append(type_at_curr_addr)
                else:
                    ctxt.append('_')
            else:
                curr_addr = move_cache[(curr_addr, instr)]
        cond = ','.join(ctxt)
        result.append((cond, term_symb))
    return result


def compute_score_with_cache(mle, instrs, expr):
    sum = 0.0
    h_e = get_data_expr(expr, instrs)
    for (cond, term_symb) in h_e:
        prob = mle.get(cond, {}).get(term_symb, 0.001)
        l_e = -1.0 * math.log2(prob) if prob > 0.0 else -1.0 * math.log2(0.001)
        sum += l_e
    return sum


def get_data_exprs(exprs, prog):
    result = []
    for expr in exprs:
        data = get_data_expr(expr, prog)
        result = result + data
    return result


def get_exprs_info(expr_str_set):
    global exprstr2expr
    expr_set = [exprstr2expr[exprstr] for exprstr in expr_str_set]
    def get_all_addrs(expr):
        addrs = set()
        addrs.add(())
        stack = [(expr, [])]
        while len(stack) > 0:
            v, addr = stack.pop(0)
            if exprs.is_function_expression(v):
                for i, child in enumerate(v.children):
                    new_addr = list(addr)
                    new_addr.append(i)
                    addrs.add(tuple(new_addr))
                    stack.append((child, new_addr))
        return addrs

    expr2history = {}
    for expr in expr_set:
        history = get_history(expr)
        expr2history[expr] = history

    # for expr,history in expr2history.items():
    #     print('expr : ', exprs.expression_to_string(expr))
    #     for e, addr in history:
    #         print('\t', exprs.expression_to_string(e), '\t', fetchop(fetch_prod(e, addr)))

    expr2cache = {}
    for _,history in expr2history.items():
        for (expr, target_addr) in history:
            addrs = get_all_addrs(expr)
            write_cache = {}
            move_cache = {}
            for addr in addrs:
                for instr in move_instrs:
                    new_addr, _ = get_ctxt(expr, addr, [instr], training=True)
                    move_cache[(addr,instr)] = new_addr

                _, ctxt = get_ctxt(expr, addr, [Tcond.WRITE_VALUE], training=True)
                value = ctxt[0]
                # we do not use types for now
                # _, ctxt = get_ctxt(expr, addr, [Tcond.WRITE_TYPE], training=True)
                type = ctxt[0]

                # store value, type at addr into write_cache
                write_cache[addr] = (value, type)
            expr2cache[exprs.expression_to_string(expr)] = (move_cache, write_cache)
            # print(move_cache)
            # print(write_cache)

    # transform history into expr_string -> history_only_with_exprstrings
    expr2history_ = {}
    for (expr, history) in expr2history.items():
        history_ = []
        for (expr, target_addr) in history:
            history_.append((exprs.expression_to_string(expr), target_addr))
        history = history_
        expr2history_[exprs.expression_to_string(expr)] = history

    expr2history = expr2history_
    return (expr2history, expr2cache)


# prog : Tcond.enum list
def mutate_prog(prog):
    flatten = lambda l: [item for sublist in l for item in sublist]
    def get_chunks(prog):
        result = []
        chunk = []
        for instr in prog:
            chunk.append(instr)
            if instr in write_instrs:
                result.append(list(chunk))
                chunk.clear()
        return result

    # select target chunk
    chunks = get_chunks(prog)
    target_chunk_index = random.randint(0, len(chunks) - 1)
    mode = random.randint(Mode.DELETE, Mode.ADD) if len(chunks) > 1 else random.randint(Mode.MODIFY, Mode.ADD)
    target_chunk = chunks[target_chunk_index]
    assert (len(target_chunk) >= 2)
    if mode == Mode.DELETE:
        # if target_chunk == [some move; write], remove the chunk
        if len(target_chunk) == 2:
            assert(len(chunks) > 1)
            return flatten([chunk for i,chunk in enumerate(chunks) if i != target_chunk_index])
        else:
            # target_chunk == [(up | left | prevdfs) ; ... ; write]. do not delete the first and the last.
            remove_index = random.randint(1, len(target_chunk) - 2)
            target_chunk = [instr for i,instr in enumerate(target_chunk) if i != remove_index]
            chunks[target_chunk_index] = target_chunk
            return flatten(chunks)
    elif mode == Mode.MODIFY:
        # if target_chunk == [some move; write], modify the first one. it should be (up | left | prevdfs)
        if len(target_chunk) == 2:
            target_chunk[0] = random.choice(begin_instrs)
            return flatten(chunks)
        else:
            # target_chunk == [(up | left | prevdfs) ; ... ; write]. do not modify the first and the last.
            modify_index = random.randint(1, len(target_chunk) - 2)
            target_chunk[modify_index] = random.choice(move_instrs)
            chunks[target_chunk_index] = target_chunk
            return flatten(chunks)
    else:  # ADD
        if random.randint(0,1) == 0:  # add instr
            target_chunk.insert(0, random.choice(begin_instrs))
            chunks[target_chunk_index] = target_chunk
            return flatten(chunks)
        else: # add chunk
            result = list(prog)
            result.append(random.choice(begin_instrs))
            result.append(random.choice(write_instrs))
            return result


# this function is called only during training phase.
def r_regent(data_set, prog, lambda_penalize):
    global write_num_threshold
    # compute sum of scores
    sum = 0.0
    mle = get_mle(prog, data_set, training=True)

    for expr in data_set:
        expr_score = compute_score_with_cache(mle, prog, expr)
        sum += expr_score
    write_num = len([instr for instr in prog if instr in write_instrs])
    regularize = lambda_penalize * write_num if write_num <= write_num_threshold else max_score

    result = sum / len(data_set) + regularize
    return result

    # computing cross entropy
    # k = min(k_fold, len(data_set))
    #
    # def chunks(l, n):
    #     """Yield successive n-sized chunks from l."""
    #     for i in range(0, len(l), n):
    #         yield l[i:i + n]
    #
    # l_ent_sum = 0.0
    # (part_size, rem) = divmod(len(data_set), k)
    # # print([exprs.expression_to_string(e) for e in data_set])
    # part_num = 0
    # for partition in chunks(list(data_set), part_size):
    #     test_set = set(partition)
    #     train_set = list(data_set - test_set)
    #     # print([exprs.expression_to_string(e) for e in train_set])
    #     mle = get_mle(prog, train_set, training=True)
    #     # h_e = get_data_exprs(test_set, prog)
    #
    #     for expr in test_set:
    #         l_ent_sum += compute_score_with_cache(mle, prog, expr)
    #         part_num += 1
    #
    #     # for (cond, term_symb) in h_e:
    #     #     prob = mle.get(cond, {}).get(term_symb, 0.001)
    #     #     l_e = -1.0 * math.log2(prob) if prob > 0.0 else 10.0
    #     #     l_ent_sum += l_e
    #
    # regularize = lambda_penalize * len(prog)
    #
    #
    # return l_ent_sum / part_num + regularize


def get_mle_reg(prog, exprs):
    data = get_data_exprs(exprs, prog)
    conds, rules = (set([]), set([]))
    mle = {}
    cond_num = {}
    condrule_num = {}
    for (cond, rule) in data:
        mle[cond] = {}
        conds.add(cond)
        rules.add(rule)
        cond_num[cond] = cond_num.get(cond, 0) + 1
        condrule_num[(cond,rule)] = condrule_num.get((cond,rule), 0) + 1

    for cond in conds:
        for rule in rules:
            denom = cond_num.get(cond, 0)
            nom = condrule_num.get((cond,rule), 0)
            mle[cond][rule] = nom / denom
    return mle


# cond : string list,   rule : string,   sentences : list of string list,  all_vocabs : string set
# https://dash.harvard.edu/bitstream/handle/1/25104739/tr-10-98.pdf?sequence=1
@static_var("memo", {})
def wb(cond, rule, all_vocabs, unigram, T, N):
    cond_str = ','.join(cond)
    sentence_str = cond_str + ',' + rule
    if sentence_str in wb.memo:
        return wb.memo[sentence_str]
    # unigram
    if len(cond) == 0:
        return unigram[rule]
    else:
        nom = N[sentence_str] + T[cond_str] * wb(cond[1:], rule, all_vocabs, unigram, T, N)
        denom = T[cond_str]
        for vocab in all_vocabs:
            sentence_str = cond_str + ',' + vocab
            denom = denom + N[sentence_str]

        if denom > 0.0:
            result = nom / denom
            wb.memo[sentence_str] = result
            return result
        else:
            return 0


def get_mle_wb(prog, exprs):
    all_vocabs = get_mle.all_vocabs
    # length of context
    cond_len = len([instr for instr in prog if instr in write_instrs])
    # give up if too many entries are expected.
    n_mle_entries = len(all_vocabs) ** (cond_len + 1)
    print('# mle entries : ', n_mle_entries)
    if (n_mle_entries > wb_threshold):
        print('gave up interpolation due to too many possibilities : ', n_mle_entries)
        return get_mle_reg(prog, exprs)

    data = get_data_exprs(exprs, prog)
    # sentences : list of string list
    sentences = []
    for (cond, rule) in data:
        cond = cond.split(',')
        cond.append(rule)
        sentences.append(cond)

    # compute unigram : vocab -> R
    def compute_unigram(sentences):
        unigram = {}
        used_vocabs = set([])
        T = len(all_vocabs)
        N = 0
        for sentence in sentences:
            N += len(sentence)
            for vocab in sentence:
                used_vocabs.add(vocab)

        never_used_vocabs = all_vocabs - used_vocabs
        Z = len(never_used_vocabs)
        for vocab in never_used_vocabs:
            unigram[vocab] = T / ((N + T) * Z)
        for vocab in used_vocabs:
            cnt = 0
            for sentence in sentences:
                cnt += len([v for v in sentence if v == vocab])
            unigram[vocab] = cnt / (N + T)
        return unigram

    unigram = compute_unigram(sentences)
    # pre-compute
    # T : prefix -> |{prefix . c | c \in all_vocabs}|
    # N : sentence -> # of appearance of the sentence
    T = {}
    N = {}
    # sentences : list of string
    # sentences_wo_dup : set of string
    sentences = [','.join(sentence) for sentence in sentences]
    sentences_wo_dup = set(sentences)
    # all possible contexts
    for cond in itertools.product(all_vocabs, repeat=cond_len):
        cond = list(cond)
        for i in range(0, len(cond)):
            # all sub contexts
            subcond = cond[i:]
            subcond_str = ','.join(subcond)
            T[subcond_str] = len([sentence for sentence in sentences_wo_dup if subcond_str in sentence])
            for vocab in all_vocabs:
                sen = subcond_str + ',' + vocab
                N[sen] = len([sentence for sentence in sentences if sen in sentence])

    # compute mle
    mle = {}
    for cond in itertools.product(all_vocabs, repeat=cond_len):
        cond = list(cond)
        cond_str = ','.join(cond)
        mle[cond_str] = {}
        for vocab in all_vocabs:
            mle[cond_str][vocab] = wb(cond, vocab, all_vocabs, unigram, T, N)

    return mle


def get_mle_backoff(prog, exprs):
    global alpha

    all_vocabs = get_mle.all_vocabs
    # length of context
    cond_len = len([instr for instr in prog if instr in write_instrs])
    # give up if too many entries are expected.
    n_mle_entries = len(all_vocabs) ** (cond_len + 1)
    print('# mle entries : ', n_mle_entries)
    if (n_mle_entries > wb_threshold):
        print('gave up interpolation due to too many possibilities : ', n_mle_entries)
        return get_mle_reg(prog, exprs)

    data = get_data_exprs(exprs, prog)
    # sentences : list of string list
    sentences = []
    for (cond, rule) in data:
        cond = cond.split(',')
        cond.append(rule)
        sentences.append(cond)
    print('# sentences : ', len(sentences))
    # compute unigram : vocab -> R
    def compute_unigram(sentences):
        unigram = {}
        used_vocabs = set([])
        T = len(all_vocabs)
        N = 0
        for sentence in sentences:
            N += len(sentence)
            for vocab in sentence:
                used_vocabs.add(vocab)

        never_used_vocabs = all_vocabs - used_vocabs
        Z = len(never_used_vocabs)
        for vocab in never_used_vocabs:
            unigram[vocab] = T / ((N + T) * Z)
        for vocab in used_vocabs:
            cnt = 0
            for sentence in sentences:
                cnt += len([v for v in sentence if v == vocab])
            unigram[vocab] = cnt / (N + T)
        return unigram

    unigram = compute_unigram(sentences)
    # pre-compute
    # N : sentence -> # of appearance of the sentence
    N = {}
    # sentences : list of string
    sentence_strs = [','.join(sentence) for sentence in sentences]
    # init
    for vocab in all_vocabs:
        sum = 0
        for sentence in sentence_strs:
            sum += sentence.count(vocab)
        N[vocab] = sum
    # all possible contexts
    for cond in itertools.product(all_vocabs, repeat=cond_len):
        for i in range(0, len(cond)):
            # all sub contexts
            subcond = cond[i:]
            subcond_str = ','.join(subcond)
            for vocab in all_vocabs:
                sen = subcond_str + ',' + vocab
                sum = 0
                for sentence in sentence_strs:
                    sum += sentence.count(sen)
                    # sum += len([m.start() for m in re.finditer('(?=%s)' % sen, sentence)])
                N[sen] = sum
                # N[sen] = len([sentence for sentence in sentences if sen in sentence])

    S = {}
    # cond : string list
    def get_S(cond, vocab):
        if len(cond) == 0: return unigram[vocab]

        cond_str = ','.join(cond)
        sen = cond_str + ',' + vocab
        if sen in S:
            return S[sen]
        elif sen in N and N[sen] > 0:
            result = N[sen] / N[cond_str]
            if result > 1 :
                print('weird : %d %d\n' % (N[sen], N[cond_str]))
                assert(False)
            S[sen] = result
            return result
        else:
            result = alpha * get_S(cond[1:], vocab)
            S[sen] = result
            return result


    mle = {}
    for cond in itertools.product(all_vocabs, repeat=cond_len):
        cond_str = ','.join(cond)
        mle[cond_str] = {}
        for vocab in all_vocabs:
            # print(cond_str, ' ', vocab)
            if vocab != '_':
                mle[cond_str][vocab] = get_S(cond, vocab)
    return mle


def remove_zero_probs(mle):
    if mle == None: return
    zero_entries = []
    for ctxt, topsymb_to_prob in mle.items():
        for topsymb, prob in topsymb_to_prob.items():
            if prob == 0.0: zero_entries.append((ctxt, topsymb))
    for (ctxt, topsymb) in zero_entries:
        del mle[ctxt][topsymb]


def get_mle(prog, exprs, training=True):
    mle = get_mle_backoff(prog, exprs) if do_wb and not training else get_mle_reg(prog, exprs)
    remove_zero_probs(mle)
    return mle


def data_sampling(progs, exprs, size, rDp, lambda_penalize):
    def get_repr(Q, d):
        max_repr = 0.0
        for p in Q:
            max_repr = max(max_repr, math.fabs(rDp[prog_to_str(p)] - r_regent(d, p, lambda_penalize)))
        return max_repr

    def mutate_data(data_set):
        new_data_set = set(data_set)
        mode = random.randint(0,2) if len(new_data_set) > size else random.randint(1,2)
        if mode == Mode.DELETE:
            new_data_set.remove(random.sample(new_data_set, 1)[0])
        elif mode == Mode.MODIFY:
            new_data_set.remove(random.sample(new_data_set, 1)[0])
            new_data_set.add(random.sample(exprs, 1)[0])
        else: # ADD
            new_data_set.add(random.sample(exprs, 1)[0])
        repr = get_repr(progs, new_data_set)
        return data_set, repr

    def pick_random_data(exprs, size):
        result = []
        for i in range(0, pool_size):
            data = set([])
            for i in range(0, size):
                data.add(random.sample(exprs, 1)[0])
            result.append((data,get_repr(progs, data)))
        return result

    # pool : (expr list * score) list
    # generating init_pool
    pool = pick_random_data(exprs, size)
    iter = 0
    while iter < max_iter_sample:
        iter += 1
        # mutate
        mutated_pool = [mutate_data(data) for (data, _) in pool]
        # sort
        new_pool = pool + mutated_pool
        new_pool.sort(key=lambda x: x[1])
        # drop
        pool.clear()
        for i in range(0, len(new_pool)):
            if i < pool_size: pool.append(new_pool[i])

    return pool[0][0]


def prog_gen(data_set, progs, lambda_penalize):

    def mutate_prog_sub(prog):
        new_prog = mutate_prog(prog)
        new_score = r_regent(data_set, new_prog, lambda_penalize)
        return new_prog, new_score

    def pick_random_prog(size):
        class State(IntEnum):
            MOVE = 1
            WRITE = 2

        result = []
        size -= 1
        result.append(random.choice([Tcond.UP, Tcond.LEFT, Tcond.PREV_DFS]))
        state = State.MOVE
        while size > 1:
            size -= 1
            if state == State.MOVE:
                instr = random.choice(move_instrs)
            else:
                instr = random.choice(write_instrs)
            result.append(instr)

            if state == State.WRITE or size == 2:
                state = State.MOVE
            else:
                state = random.choice([State.MOVE, State.WRITE])
        result.append(random.choice(write_instrs))
        return result


    def pick_random_progs():
        global max_prog_size
        result = []
        for i in range(0, pool_size):
            prog = pick_random_prog(random.randint(2,max_prog_size))
            result.append((prog, r_regent(data_set, prog, lambda_penalize)))
        return result


    # pool : (prog * score) list
    # generating init_pool
    pool = pick_random_progs() + progs
    iter = 0
    while iter < max_iter_gen:
        iter += 1
        # mutate
        mutated_pool = [mutate_prog_sub(prog) for (prog, _) in pool]
        # sort
        new_pool = pool + mutated_pool
        new_pool.sort(key=lambda x: x[1])
        # drop
        pool.clear()
        # for i in range(0, len(new_pool)):
        #     if i < pool_size: pool.append(new_pool[i])
        n_inserted = 0
        for i in range(0, len(new_pool)):
            if n_inserted < pool_size and random.random() < (len(new_pool) - i) / len(new_pool):
                n_inserted += 1
                pool.append(new_pool[i])

    return pool[0][0]


# exprs : expr set
def train_model(exprs, lambda_penalize, silent=False):
    global do_sample

    if not silent: print('Training with %d expressions...' % (len(exprs)))
    assert (k_fold > 1)
    # init
    random.seed()

    iter = 0
    # default prog
    p = [Tcond.UP, random.choice(write_instrs)]
    progs = []
    if do_sample:
        data_set = set(random.sample(exprs, min(len(exprs), k_fold)))
    else:
        data_set = exprs
    rDp = {}

    while iter < max_iter:
        if not silent: print(iter, '-th iteration')
        iter += 1
        if iter > 1:
            if len(data_set) < len(exprs) - 1 and do_sample:
                data_set = data_sampling(progs, exprs, len(data_set) + 1, rDp, lambda_penalize)
            else: data_set = exprs
            # print('generated data set : ', len(data_set))
        progs_so_far = []
        for p in progs:
            p_with_score = (p, r_regent(data_set, p, lambda_penalize) if do_sample else rDp[prog_to_str(p)])
            progs_so_far.append(p_with_score)
        p = prog_gen(data_set, progs_so_far, lambda_penalize)
        rDp[prog_to_str(p)] = r_regent(exprs, p, lambda_penalize)
        if not silent: print('generated prog : %s (%.2f)' % (prog_to_str(p), rDp[prog_to_str(p)]))

        if p not in progs:
            progs.append(p)

    # if data sampling was done, the last one is the best
    if do_sample:
        final_prog = p
    else:  # else, pick the best among the generated ones
        final_prog = min(progs + [p], key=(lambda p: rDp[prog_to_str(p)]))

    return final_prog


import re
def print_mle(f, mle):
    for (cond, rule_to_prob) in mle.items():
        for topsymb, prob in rule_to_prob.items():
            if prob > 0.0:
                f.write('%s %s %d\n' % (cond, topsymb, int(prob * 1000.0)))


def get_all_vocabs(grammars):
    # '_' : epsilon
    vocabs = set(['_'])
    for grammar in grammars:
        for nt,rule in grammar.rules.items():
            for prod in rule:
                vocabs.add(fetchop_rewrite(prod))
                # vocabs.add(fetchtype_rewrite(prod))
    return vocabs


def param_setting(args):
    # global lambda_penalize
    global alpha
    global max_iter
    global max_iter_gen
    global max_iter_sample
    global pool_size
    global k_fold
    global do_wb
    global do_sample
    global max_prog_size
    global eu

    # lambda_penalize = args.lambda_penalize
    alpha = args.alpha
    max_iter = args.max_iter
    max_iter_gen = args.max_iter_gen
    max_iter_sample = args.max_iter_sample
    pool_size = args.pool_size
    max_prog_size = args.max_size
    k_fold = args.k_fold
    do_wb = args.do_wb
    do_sample = args.do_sample
    eu = args.eu

    print('Settings : ')
    # print('\t lambda_penalize : ', lambda_penalize)
    print('\t max_iter : ', max_iter)
    print('\t max_iter_gen : ', max_iter_gen)
    print('\t max_iter_sample : ', max_iter_sample)
    print('\t pool_size : ', pool_size)
    print('\t k_fold : ', k_fold)
    print('\t do_wb : ', do_wb)
    print('\t do_sample : ', do_sample)
    print('\t eu : ', eu)


# collect term and pred exprs for eusolver
def get_all_atomic_exprs(fun_exprs):
    def is_bool_expr(expr):
        return isinstance(exprs.get_expression_type(expr), exprtypes._BoolType)

    def get_all_atomic_term_expr(expr):
        result = set([])
        # macro functions involving ite have been resolved.
        app = exprs.find_application(expr, 'ite')
        if app is not None:
            for child in expr.children:
                result.update(get_all_atomic_term_expr(child))
            return result
        else:
            if not is_bool_expr(expr): result.add(expr)
            return result

        # if exprs.is_function_expression(expr):
        #     include_bool = False
        #     for child in get_all_exprs(expr):
        #         include_bool = include_bool or is_bool_expr(child)
        #     if include_bool:
        #         for child in expr.children:
        #             result.update(get_all_atomic_term_expr(child))
        #         return result
        #     else:
        #         result.add(expr)
        #         return result
        # else:
        #     if not is_bool_expr(expr):
        #         result.add(expr)
        #     return result

    def get_all_atomic_pred_expr(expr):
        result = set([])
        app = exprs.find_application(expr, 'ite')
        if app is not None:
            result.add(expr.children[0])
            for child in expr.children:
                result.update(get_all_atomic_pred_expr(child))
            return result
        else:
            return result

        # if is_bool_expr(expr):
        #     result.add(expr)
        #     return result
        # else:
        #     if exprs.is_function_expression(expr):
        #         include_bool = False
        #         for child in get_all_exprs(expr):
        #             include_bool = include_bool or is_bool_expr(child)
        #         if include_bool:
        #             for child in expr.children:
        #                 result.update(get_all_atomic_pred_expr(child))
        #             return result
        #         else:
        #             return result
        #     else:
        #         return result

    def add_dummy_pred(expr):
        arg_var = exprs.VariableExpression(exprs.VariableInfo(exprtypes.BoolType(), 'd', 0))
        dummy_macro_func = semantics_types.MacroFunction(dummy_pred_name, 1, (exprtypes.BoolType(),),
            exprtypes.BoolType(), arg_var, [arg_var])
        expr = exprs.FunctionExpression(dummy_macro_func, (expr,))
        return expr

    result_termexprs = set([])
    result_predexprs = set([])
    for fun_expr in fun_exprs:
        result_termexprs.update(get_all_atomic_term_expr(fun_expr))
        result_predexprs.update(get_all_atomic_pred_expr(fun_expr))
    # transform pred exprs for EUSolver (encosing with 'dummy_pred_id')
    result_predexprs = set([add_dummy_pred(e) for e in result_predexprs])
    return (result_termexprs, result_predexprs)


def get_ngram_instr(ngram):
    prog = []
    for i in range(0, ngram):
        prog.append(Tcond.PREV_DFS)
        prog.append(Tcond.WRITE_VALUE)
    return prog


def lambda_selector(data):
    global n_cores
    global lambda_candidates
    import numpy as np
    import sklearn.cluster
    import distance

    print('lambda selection...')
    data = list(data)
    k = min(k_fold, len(data))
    lambda_vals = lambda_candidates
    lambda2scores = {}
    for lambda_val in lambda_vals:
        lambda2scores[lambda_val] = []

    def clustering(expr_strs, k):
        words = np.asarray(expr_strs)  # So that indexing with a list will work
        lev_similarity = -1 * np.array([[distance.levenshtein(w1, w2) for w1 in words] for w2 in words])
        affprop = sklearn.cluster.KMeans(n_clusters=k, n_jobs=n_cores, precompute_distances=True, max_iter=1000, n_init=100)
        affprop.fit(lev_similarity)
        ind2words = {}
        for i, ind in enumerate(affprop.labels_):
            if ind in ind2words:
                ind2words[ind].append(expr_strs[i])
            else:
                ind2words[ind] = [expr_strs[i]]
        return ind2words

    # cross-validation
    def get_partitions(progs, k_fold):
        subset_size = int(len(progs) / k_fold)
        result = []
        for i in range(k_fold):
            if i == k_fold - 1:
                testing_this_round = progs[i * subset_size:]
            else:
                testing_this_round = progs[i * subset_size:][:subset_size]
            training_this_round = list(set(progs) - set(testing_this_round))
            # training_this_round = solution_files[:i * subset_size] + solution_files[(i + 1) * subset_size:]
            print('testing : ', testing_this_round)
            print('training : ', training_this_round)
            result.append((testing_this_round, training_this_round))
        return result

    def get_stratified_partitions(progs, k):
        global k_fold
        clusters = clustering(progs, k)
        ordered_progs = []
        cycler = itertools.cycle(range(0, k_fold))
        while len(ordered_progs) != len(progs):
            i = next(cycler)
            if len(clusters[i]) > 0:
                prog = random.choice(clusters[i])
                clusters[i].remove(prog)
                ordered_progs.append(prog)

        return k, get_partitions(ordered_progs, k)


    # def get_stratified_partitions(sols, k):
    #     result = {}
    #     clusters = {}
    #     while k > 0:
    #         print('Computing clusters for stratified %d cross-validation...' % k)
    #         clusters = clustering(sols, k)
    #         cluster_sizes = [len(sols) for _, sols in clusters.items()]
    #         print('Cluster sizes : ', cluster_sizes)
    #         if len([n for n in cluster_sizes if n >= k]) == k: break
    #         print('Outliers : ', [sols for _, sols in clusters.items() if len(sols) <= k])
    #         k -= 1
    #     if k < 2:
    #         print('Data is so highly biased that stratified cross-validation is not feasible.')
    #         assert False
    #
    #     for _, sols in clusters.items():
    #         subset_size = int(len(sols) / k)
    #         for i in range(k):
    #             testing_this_round = sols[i * subset_size:][:subset_size]
    #             training_this_round = sols[:i * subset_size] + sols[(i + 1) * subset_size:]
    #             result_test, result_training = result.get(i, ([], []))
    #             result_test.extend(testing_this_round)
    #             result_training.extend(training_this_round)
    #             result[i] = (result_test, result_training)
    #     return k, result

    k, stratified_cv_result = get_stratified_partitions(data, k)

    for lambda_val in lambda_vals:
        print('lambda : %.2f' % lambda_val)
        for i in range(0, k):
            (test_set, train_set) = stratified_cv_result[i]
            # print([exprs.expression_to_string(e) for e in test_set])
            # print([exprs.expression_to_string(e) for e in train_set])
            prog = train_model(train_set, lambda_val, silent=True)
            mle = get_mle(prog, train_set, training=True)
            for expr in test_set:
                l_ent_sum = compute_score_with_cache(mle, prog, expr)
                lambda2scores[lambda_val].append(l_ent_sum)
            print('avg score : %.2f' % (sum(lambda2scores[lambda_val]) / len(lambda2scores[lambda_val])))

    best_lambda = min(lambda2scores.keys(), key=(lambda key: sum(lambda2scores[key]) / len(lambda2scores[key])))
    print('lambda chosen : ', best_lambda)
    return best_lambda


if __name__ == "__main__":
    import pickle
    import sys
    import argparse
    sys.setrecursionlimit(10000)

    argparser = argparse.ArgumentParser(description='Train PHOG model')
    argparser.add_argument('-lambda_penalize', type=float, default=0.0)
    argparser.add_argument('-alpha', type=float, default=0.4)
    argparser.add_argument('-max_iter', type=int, default=10)
    argparser.add_argument('-max_iter_gen', type=int, default=20)
    argparser.add_argument('-max_iter_sample', type=int, default=20)
    argparser.add_argument('-pool_size', type=int, default=10)
    argparser.add_argument('-max_size', type=int, default=30)
    argparser.add_argument('-k_fold', type=int, default=4)
    argparser.add_argument('-ngram', type=int, default=0)
    argparser.add_argument('-do_wb', action='store_true')
    argparser.add_argument('-do_sample', action='store_true')
    argparser.add_argument('-text', action='store_true')
    argparser.add_argument('-eu', action='store_true')
    argparser.add_argument('-out', type=str, default='mle')
    argparser.add_argument('bench', nargs=argparse.REMAINDER)

    if len(sys.argv) < 2:
        argparser.print_usage()
        exit(0)

    args = argparser.parse_args()
    param_setting(args)
    output_file = args.out
    benchmark_files = args.bench
    ngram = args.ngram
    text_out = args.text

    # bechmark_file format : original benchmark_file + its solution
    rettype2fun_exprs, grammars = get_func_exprs_grammars(benchmark_files)
    # print([exprs.expression_to_string(e) for e in fun_exprs])

    # collect vocab
    all_vocabs = set(['_'])
    for _, fun_exprs in rettype2fun_exprs.items():
        if len(grammars) == 0:
            for fun_expr in fun_exprs:
                sub_exprs = exprs.get_all_exprs(fun_expr)
                for expr in sub_exprs:
                    all_vocabs.add(fetchop(expr))
                    # all_vocabs.add(fetchtype(expr))
        else:
            all_vocabs.update(get_all_vocabs(grammars))

    print('# of vocabs : ', len(all_vocabs))
    # print([vocab for vocab in all_vocabs])
    get_mle.all_vocabs = all_vocabs

    # setting maximum number of writes
    all_vocabs = get_mle.all_vocabs
    write_num_threshold = math.log2(wb_threshold) / math.log2(len(all_vocabs)) - 1 if args.do_wb else max_prog_size / 2
    print('PHOG instrs with |Write| > %.2f will be ignored.' % write_num_threshold)

    # for eusolver
    rettype2mle = {}

    for ret_type_eusolver, fun_exprs in rettype2fun_exprs.items():
        (ret_type, eusolver) = ret_type_eusolver
        print('Training on exprs returning %s %s' % (str(ret_type), '(for eusolver)' if eusolver else ''))
        (term_exprs, pred_exprs) = get_all_atomic_exprs(fun_exprs) if eusolver else (fun_exprs, set([]))

        print('Collected term exprs for training : ', len(term_exprs))
        # for expr in term_exprs:
        #     print(exprs.expression_to_string(expr))
        print('Collected pred exprs for training : ', len(pred_exprs))
        # for expr in pred_exprs:
        #     print(exprs.expression_to_string(expr))

        # collecting pre-computed information to expedite learning
        total_exprs = list(term_exprs) + list(pred_exprs)
        for e in total_exprs:
            estr = exprs.expression_to_string(e)
            exprstr2expr[estr] = e
        exprs_info = get_exprs_info(list(exprstr2expr.keys()))
        # freeze exprs to strings
        term_exprs_ = [exprs.expression_to_string(e) for e in term_exprs]
        term_exprs = term_exprs_
        pred_exprs_ = [exprs.expression_to_string(e) for e in pred_exprs]
        pred_exprs = pred_exprs_

        print('learn PHOG for term exprs')
        if len(term_exprs) == 0:
            term_prog = None
            term_mle = None
        else:
            if ngram == 0:
                if args.lambda_penalize == 0.0:
                    lambda_penalize = lambda_selector(term_exprs)
                else:
                    lambda_penalize = args.lambda_penalize
                term_prog = train_model(term_exprs, lambda_penalize)
                # term_prog = [Tcond.LEFT, Tcond.WRITE, Tcond.UP, Tcond.WRITE]
                # term_prog = [Tcond.WRITE]
            else:  # n PrevDFS seq
                term_prog = get_ngram_instr(ngram)

            print(prog_to_str(term_prog))
            term_mle = get_mle(term_prog, term_exprs, training=False)
            # print probabilities of training data
            # for term_expr in term_exprs:
            #     print('%s : %.2f' % (term_expr, compute_score_with_cache(term_mle, term_prog, term_expr)))

                # print_mle(term_mle)

        print('learn PHOG for pred exprs')
        if len(pred_exprs) == 0:
            pred_prog = None
            pred_mle = None
        else:
            if ngram == 0:
                if args.lambda_penalize == 0.0:
                    lambda_penalize = lambda_selector(pred_exprs)
                else:
                    lambda_penalize = args.lambda_penalize
                pred_prog = train_model(pred_exprs, lambda_penalize)
            else:  # n PrevDFS seq
                pred_prog = get_ngram_instr(ngram)

            print(prog_to_str(pred_prog))
            pred_mle = get_mle(pred_prog, pred_exprs, training=False)
            # print_mle(pred_mle)

        # cleaning up mles
        remove_zero_probs(term_mle)
        remove_zero_probs(pred_mle)

        # store the mles for dumping
        rettype2mle[(str(ret_type), eusolver)] = ((term_prog, term_mle), (pred_prog, pred_mle))

    if text_out:
        with open(output_file, 'w') as f:
            for (ret_type_str, eusolver), ((term_prog, term_mle), (pred_prog, pred_mle)) in rettype2mle.items():
                # XXX : for stochastic solver
                if not eusolver:
                    # f.write('%s %s\n' % (ret_type_str, '(eusolver)' if eusolver else ''))
                    f.write('%s\n' % prog_to_str(term_prog))
                    print_mle(f, term_mle)
    else:
        with open(output_file, 'wb') as f:
            pickle.dump(rettype2mle, f)
