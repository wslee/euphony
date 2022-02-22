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
from core import specifications
from benchmarks import *
from sphogs.sphog_utils import *
from sphog_train import *

'''
main() block is kind of copy-pasted from sphog_train.py since IDK what else to do
'''


if __name__ == "__main__":
    import pickle
    import sys
    import argparse
    sys.setrecursionlimit(10000)

    argparser = argparse.ArgumentParser(description='Train n-gram model')
    argparser.add_argument('-n', type=int, default=3)
    # argparser.add_argument('-lambda_penalize', type=float, default=1.0)
    # argparser.add_argument('-alpha', type=float, default=0.2)
    # argparser.add_argument('-max_iter', type=int, default=20)
    # argparser.add_argument('-max_iter_gen', type=int, default=50)
    # argparser.add_argument('-max_iter_sample', type=int, default=50)
    # argparser.add_argument('-pool_size', type=int, default=20)
    # argparser.add_argument('-max_size', type=int, default=30)
    # # argparser.add_argument('-k_fold', type=int, default=4)
    # argparser.add_argument('-do_backoff', action='store_true')
    # argparser.add_argument('-do_sample', action='store_true')
    # # argparser.add_argument('-text', action='store_true')
    # argparser.add_argument('-eu', action='store_true')
    # argparser.add_argument('-pcfg', action='store_true')
    argparser.add_argument('-out', type=str, default='mle')
    argparser.add_argument('bench', nargs=argparse.REMAINDER)

    if len(sys.argv) < 2:
        argparser.print_usage()
        exit(0)

    args = argparser.parse_args()
    # param_setting(args)
    ngram_size = args.n
    output_file = args.out
    benchmark_files = args.bench
    # pcfg = args.pcfg
    # text_out = args.text


    # bechmark_file format : original benchmark_file + its solution
    exprs_per_category, all_vocabs = get_func_exprs_grammars(benchmark_files)
    # print([exprs.expression_to_string(e) for e in fun_exprs])

    # for _, fun_exprs in rettype2fun_exprs.items():
    #     for (fun_expr, fetchop_func) in fun_exprs:
    #         sub_exprs = exprs.get_all_exprs(fun_expr)
    #         for expr in sub_exprs:
    #             all_vocabs.add(fetchop_func(expr))
    #     if len(grammars) > 0:
    #         all_vocabs.update(get_all_vocabs(grammars))

    print('# of vocabs : ', len(all_vocabs))
    print([vocab for vocab in all_vocabs])

    # cut out the weird get_mle.all_vocabs thing since I have no clue what it was doing

    # idk what this is used for either...
    # setting maximum number of writes
    # write_num_threshold = math.log2(backoff_threshold) / math.log2(len(all_vocabs)) - 1 if args.do_backoff else max_prog_size / 2
    # print('PHOG instrs with |Write| > %.2f will be ignored.' % write_num_threshold)

    # for eusolver
    # rettype2mle = {}

    # for ret_type_eusolver, fun_exprs in exprs_per_category.items():
    #         (ret_type, eusolver, spec_kind) = ret_type_eusolver
    #         key = (str(ret_type), eusolver, spec_kind)
    #         print('Specification kind : ', spec_kind)
    '''
    e.g.
    Specification kind :  (<PBESpecKind.NO_INTERSECTION: 7>,)
    Specification kind :  (<PBESpecKind.SOME_INPUT_BELONG_TO_OUTPUT: 0>, <PBESpecKind.SOME_OUTPUT_BELONG_TO_INPUT: 1>, <PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT: 4>)
    Specification kind :  (<PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT: 4>,)
    Specification kind :  (<PBESpecKind.NO_INTERSECTION: 7>,)
    Specification kind :  (<PBESpecKind.SOME_OUTPUT_BELONG_TO_INPUT: 1>, <PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT: 4>)
    Specification kind :  (<PBESpecKind.SOME_INPUT_BELONG_TO_OUTPUT: 0>, <PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT: 4>)
    Specification kind :  (<PBESpecKind.NO_INTERSECTION: 7>,)
    '''

    for ret_type_eusolver, fun_exprs in exprs_per_category.items():
        (ret_type, eusolver, spec_kind) = ret_type_eusolver
        key = (str(ret_type), eusolver, spec_kind) # idk if we want eusolver in there...
        print('Specification kind : ', spec_kind)
        print('Training on exprs returning %s %s' % (str(ret_type), '(for eusolver)' if eusolver else ''))
        (term_exprs, pred_exprs) = get_all_atomic_exprs(fun_exprs) if eusolver else (fun_exprs, set([]))

        print('Collected term exprs for training : ', len(term_exprs))
        # for expr, f in term_exprs:
        #     print(exprs.expression_to_string(expr))
        print('Collected pred exprs for training : ', len(pred_exprs))
        # for expr, f in pred_exprs:
        #     print(exprs.expression_to_string(expr))

        # collecting pre-computed information to expedite learning
        total_exprs = list(term_exprs) + list(pred_exprs)
        for e, f in total_exprs:
            estr = exprs.expression_to_string(e)
            exprstr2expr[estr] = e, f
        exprs_info = get_exprs_info(list(exprstr2expr.keys()))
        # freeze exprs to strings
        term_exprs = [exprs.expression_to_string(e) for e, f in term_exprs]
        pred_exprs = [exprs.expression_to_string(e) for e, f in pred_exprs]

        term_exprs_wo_dup = sorted(list(set(term_exprs)))
        pred_exprs_wo_dup = sorted(list(set(pred_exprs)))
        print('Collected term exprs for training (w/o duplication) : ', len(term_exprs_wo_dup))
        # print("--")
        # for expr in term_exprs_wo_dup:
        #     print(expr)
        # print("--")

        print('Collected pred exprs for training (w/o duplication) : ', len(pred_exprs_wo_dup))
        # for expr in pred_exprs_wo_dup:
        #     print(expr)

        print('\n---\nn-gram time woohoo\n---\n')
        # this is probably where we should add n-gram stuff
        # how do you do n-gram probabilities though? is it purely based off of frequency counts -> distribution?

        print(term_exprs)

        # ngrams = generate_n_grams(ngram_size, term_exprs)

        # print('learn PHOG for term exprs')
        # if len(term_exprs) == 0:
        #     term_prog = None
        #     term_mle = None
        # else:
        #     # if args.lambda_penalize == 0.0:
        #     #     lambda_penalize = lambda_selector(term_exprs)
        #     # else:
        #     lambda_penalize = args.lambda_penalize
        #     if pcfg:
        #         term_prog = [Tcond.WRITE_VALUE]
        #     else:
        #         term_prog = train_model(term_exprs, lambda_penalize)

        #     print(prog_to_str(term_prog))
        #     term_mle = get_mle(term_prog, term_exprs, training=False)
            # print probabilities of training data
            # for term_expr in term_exprs:
            #     print('%s : %.2f' % (term_expr, compute_score_with_cache(term_mle, term_prog, term_expr)))

                # print_mle(term_mle)

        # print('learn PHOG for pred exprs')
        # if len(pred_exprs) == 0:
        #     pred_prog = None
        #     pred_mle = None
        # else:
        #     # if args.lambda_penalize == 0.0:
        #     #     lambda_penalize = lambda_selector(pred_exprs)
        #     # else:
        #     lambda_penalize = args.lambda_penalize

        #     if pcfg:
        #         pred_prog = [Tcond.WRITE_VALUE]
        #     else:
        #         pred_prog = train_model(pred_exprs, lambda_penalize)

        #     print(prog_to_str(pred_prog))
        #     pred_mle = get_mle(pred_prog, pred_exprs, training=False)
        #     # print_mle(pred_mle)

        # cleaning up mles
        # remove_zero_probs(term_mle)
        # remove_zero_probs(pred_mle)

        # store the mles for dumping
        # rettype2mle[key] = ((term_prog, term_mle), (pred_prog, pred_mle))

    # if text_out:
    #     with open(output_file, 'w') as f:
    #         for (ret_type_str, eusolver, flag), ((term_prog, term_mle), (pred_prog, pred_mle)) in rettype2mle.items():
    #             # XXX : for stochastic solver
    #             if not eusolver:
    #                 # f.write('%s %s\n' % (ret_type_str, '(eusolver)' if eusolver else ''))
    #                 f.write('%s\n' % prog_to_str(term_prog))
    #                 print_mle(f, term_mle)
    # else:
    # with open(output_file, 'wb') as f:
    #     pickle.dump(rettype2mle, f)
