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
import shlex
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
from collections import defaultdict, Counter

'''
main() block is kind of copy-pasted from sphog_train.py since IDK what else to do
'''

def generate_n_grams(ngram_size, expr_strings):
    # have to rely on the cache, similar to get_data_expr()
    global exprs_info

    for expr_string in expr_strings:
        pass

'''
def get_data_expr(expr, prog):
    global exprs_info

    # print(expr)
    # token_list = expr.replace('(', '').replace(')', '').split(' ')
    # for i,token in enumerate(token_list):
    #     print(token)
    #     token_list[i] = fetchop_func_pbe({}, {}, token)
    # print(token_list)
    # exit(0)
        # if token[0] == '"':
        #     token_list[i] = 'C_5'
        # elif token == '_arg_0' or token == '_arg_1': 
        #     token_list[i] = 'Var'
    
    # res = []
    # for i in range(len(token_list) - 2):
    #     res.append((token_list[i]+','+token_list[i+1], token_list[i+2]))

    # return res

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
                    # print(expr) # (str.contains (str.replace _arg_0 "2" "1") "1")
                    # print(target_addr)
                    # print(symb_at_curr_addr,type_at_curr_addr)
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
    print(result)
    return result
'''



if __name__ == "__main__":
    import pickle
    import sys
    import argparse
    sys.setrecursionlimit(10000)

    argparser = argparse.ArgumentParser(description='Train n-gram model')
    argparser.add_argument('-n', type=int, default=3)
    argparser.add_argument('-lambda_penalize', type=float, default=1.0)
    argparser.add_argument('-out', type=str, default='ngrams')
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

    rettype2mle = {}

    # bechmark_file format : original benchmark_file + its solution
    exprs_per_category, all_vocabs = get_func_exprs_grammars(benchmark_files)
    # print(benchmark_files[0:1])

    print('# of vocabs : ', len(all_vocabs))
    print([vocab for vocab in all_vocabs])

    # cut out the weird get_mle.all_vocabs thing since I have no clue what it was doing for now

    # idk what this is used for either...
    # setting maximum number of writes
    # write_num_threshold = math.log2(backoff_threshold) / math.log2(len(all_vocabs)) - 1 if args.do_backoff else max_prog_size / 2
    # print('PHOG instrs with |Write| > %.2f will be ignored.' % write_num_threshold)
    
    for ret_type_eusolver, fun_exprs in exprs_per_category.items():
        (ret_type, eusolver, spec_kind) = ret_type_eusolver
        key = (str(ret_type), eusolver, spec_kind) # idk if we want eusolver in there but let's just leave it for now
        print('Specification kind : ', spec_kind)
        print('Training on exprs returning %s %s' % (str(ret_type), '(for eusolver)' if eusolver else ''))
        (term_exprs, pred_exprs) = get_all_atomic_exprs(fun_exprs) if eusolver else (fun_exprs, set([]))

        print('Collected term exprs for training : ', len(term_exprs))
        ngrams = []
        for expr, fetchop_func in term_exprs:
            #expr is pre string conversion with child info
            expr_string = exprs.expression_to_string(expr)
            # print(expr_string)
            # print(fetchop_func.cache)
            # print()

            token_string = expr_string.replace('(', '').replace(')', '');
            token_list = shlex.split(token_string, posix=False)
            # print('-')
            # mapped_tokens = []

            # while ' ' in token_string:
            #     space_index = token_string.index(' ')
            #     curr_token = token_string[:space_index]
                
            #     if curr_token[0] == '"':
            #         curr_token =  
                
            #     token_string = token_string[space_index+1:]

            #     print(curr_token)
            #     print(token_string)
            #     print('---')
            #     if curr_token in fetchop_func.cache:
            #         mapped_tokens.append(fetchop_func.cache[curr_token])
            #     else:
            #         mapped_tokens.append(curr_token)
            
            # if token_string in fetchop_func.cache:
            #     mapped_tokens.append(fetchop_func.cache[token_string])
            # else:
            #     mapped_tokens.append(token_string)
            # token_list = expr_string.replace('(', '').replace(')', '').split(' ')
            # # print(fetchop_func.cache[expr_string])
            mapped_tokens = []
            for token in token_list:
                if token in fetchop_func.cache:
                    mapped_tokens.append(fetchop_func.cache[token])
                else:
                    mapped_tokens.append(token)
            
            # print(token_list)
            # print("->")
            # print(mapped_tokens)
            # print()

            # mapped_tokens = ["_"] + ["_"] + mapped_tokens
            for i in range(len(mapped_tokens)):
                if i == 0:
                    ngrams.append(('_,_', mapped_tokens[i]))
                elif i == 1:
                    ngrams.append((mapped_tokens[i-1]+','+mapped_tokens[i-1], mapped_tokens[i]))
                else:
                    ngrams.append((mapped_tokens[i-1]+','+mapped_tokens[i-2], mapped_tokens[i]))

            # mapped_tokens = ["_"] + ["_"] + ["_"] + mapped_tokens
            # for i in range(len(mapped_tokens)-3):
            #     ngrams.append((mapped_tokens[i]+','+mapped_tokens[i+1]+','+mapped_tokens[i+2], mapped_tokens[i+3]))

            # for i in range(len(mapped_tokens) - 2):
            #     ngrams.append((mapped_tokens[i]+','+mapped_tokens[i+1], mapped_tokens[i+2]))
    
        term_prog = [Tcond.PREV_DFS, Tcond.WRITE_VALUE, Tcond.PREV_DFS, Tcond.WRITE_VALUE] # this is close to what we want, but it's inverted I think
        # 4 gram
        # term_prog = [Tcond.PREV_DFS, Tcond.WRITE_VALUE, Tcond.PREV_DFS, Tcond.WRITE_VALUE, Tcond.PREV_DFS, Tcond.WRITE_VALUE] # this is close to what we want, but it's inverted I think
        # ngram_freqs = defaultdict(list)
        # ngram_probs = defaultdict(dict)
        ngram_freqs = defaultdict(list)
        ngram_probs = defaultdict(dict)
        for context, token in ngrams:
            ngram_freqs[context].append(token)
        
        for context in ngram_freqs.keys():
            c = Counter(ngram_freqs[context])
            for token in ngram_freqs[context]:
                ngram_probs[context][token] = (c[token]/len(ngram_freqs[context]))

        remove_zero_probs(ngram_probs)


        # print(ngram_probs)

        rettype2mle[key] = ((term_prog, dict(ngram_probs)), (None, None))

    # print(ngrams)
    # want it to look like 
    '''
    [
        ('_,_', 'str.contains'), 
        ('_,str.contains', 'Var'), 
        ('Var,str.contains', 'Var'), 
        ('_,_', 'str.contains'), 
        ('_,str.contains', 'Var'), 
        ('Var,str.contains', 'C_5'),  
    '''   

    # from here, we need to get the actual probabilities
    # my understanding is that we just go through ngrams and build a frequency count
    
    # print(ngram_probs)

    # term_exprs = [exprs.expression_to_string(e) for e, f in term_exprs]
    # lambda_penalize = args.lambda_penalize
    # term_prog = train_model(term_exprs, lambda_penalize)

    # need to write to file, need to get term prog

    # rettype2mle[key] = ((term_prog, ngram_probs), (term_prog, ngram_probs))

    # if text_out:
    #     with open(output_file, 'w') as f:
    #         for (ret_type_str, eusolver, flag), ((term_prog, term_mle), (pred_prog, pred_mle)) in rettype2mle.items():
    #             # XXX : for stochastic solver
    #             if not eusolver:
    #                 # f.write('%s %s\n' % (ret_type_str, '(eusolver)' if eusolver else ''))
    #                 f.write('%s\n' % prog_to_str(term_prog))
    #                 print_mle(f, term_mle)
    # else:
    with open(output_file, 'wb') as f:
        pickle.dump(rettype2mle, f)