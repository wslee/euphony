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
from core import synthesis_context
from semantics import semantics_core
from semantics import semantics_types
from core import synthesis_context
import random
import pickle
import itertools
# import numpy as np
# import matplotlib.pyplot as plt
# import networkx as nx
from sphogs.sphog_utils import *
from utils import z3smt

max_score = 9999999.0
original_expr_to_compare = exprs.ConstantExpression(exprs.Value(True, exprtypes.BoolType()))

class PriorityQueue:
    def __init__(self):
        self.heap = []
        self.elements = set([])
        self.nelem = 0

    def empty(self):
        return (self.nelem == 0)

    def get(self):
        pri, d = heapq.heappop(self.heap)
        self.nelem -= 1
        self.elements.remove(d)
        return pri, d

    def put(self, item, priority, replace=None):
        if item in self.elements:
            index = 0
            for (pri, d) in self.heap:
                if d == item: break
                index += 1
            assert (index < self.nelem)
            if replace != None:
                self.elements.remove(item)
                self.elements.add(replace)
                item = replace

            self.heap[index] = (priority, item)
            heapq._siftdown(self.heap, 0, index)
        else:
            heapq.heappush(self.heap, (priority, item))
            self.nelem += 1
            self.elements.add(item)

    def mem(self, elem):
        return elem in self.elements

    def __len__(self):
        return len(self.elements)

    def clear(self):
        self.elements.clear()
        self.heap.clear()
        self.nelem = 0
        return

# m : non-terminal -> score (-log prob)
def compute_m(stat_map, grammar, fetchop_func):
    if stat_map is None: return None
    # rules : non-terminal -> rewrite list
    rules = grammar.rules
    m = {}

    for nt, prods in rules.items():
        new_value = max_score
        for prod in prods:
            ph_vars, nts, expr = prod.to_template_expr()
            if len(nts) > 0:
                continue
            else:
                topsymb = fetchop_func(expr)
                prob = max([topsymb_to_prob.get(topsymb, 0.001) for ctx, topsymb_to_prob in stat_map.items()], default=0.001)
                m_ns = map(lambda n: m.get(n, max_score), nts)
                prod_value = functools.reduce(lambda x, y: x + y, m_ns, -1 * math.log2(prob))
                new_value = min(new_value, prod_value)
        m[nt] = math.fabs(new_value)

    def F():
        # prods : rewrite list
        updated = False
        for nt, prods in rules.items():
            old_value = m.get(nt, max_score)
            new_value = old_value
            for prod in prods:
                ph_vars, nts, expr = prod.to_template_expr()
                topsymb = fetchop_func(expr)
                prob = max([topsymb_to_prob.get(topsymb, 0.001) for ctx, topsymb_to_prob in stat_map.items()], default=0.001)
                m_ns = map(lambda n: m.get(n, max_score), nts)
                prod_value = functools.reduce(lambda x, y: x + y, m_ns, -1 * math.log2(prob))
                new_value = min(new_value, prod_value)

            updated = updated or (math.fabs(old_value - new_value) > 0.01)
            m[nt] = math.fabs(new_value)

        return updated

    updated = True
    while updated:
        updated = F()
    return m

# m is a map of nonterminal -> (-log probability)
# nts is a list of nonterminals i guess
def heuristic(m, nts):
    score = 0.0
    for nt in nts:
        score = score + m[nt]
    return score

# wtf is "sens"
# m_sens[nt][ctx] = min_logprob
# 2d dictionary, first key is a nonterminal, second key is a context
def compute_m_sens(m, stat_map, grammar, fetchop_func):
    if stat_map is None: return None
    rules = grammar.rules
    m_sens = {}
    prod2info = {}
    for nt, prods in rules.items():
        prod2info[nt] = []
        for prod in prods:
            _, _, rule_expr = prod.to_template_expr()
            topsymb = fetchop_func(rule_expr)
            prod_ph_vars, prod_nts, prod_expr = prod.to_template_expr()
            m_ns = map(lambda n: m.get(n, -1 * math.log2(0.001)), prod_nts)
            prod2info[nt].append((topsymb, m_ns))

    for nt, tuples in prod2info.items():
        if nt not in m_sens.keys(): m_sens[nt] = {}
        for ctx, topsymb_to_prob in stat_map.items():
            min_logprob = 9999999.0
            for (topsymb, m_ns) in tuples:
                prod_prob = topsymb_to_prob.get(topsymb, 0.001)
                prob = functools.reduce(lambda x, y: x + y, m_ns, -1 * math.log2(prod_prob))
                if prob < min_logprob: min_logprob = prob
            m_sens[nt][ctx] = min_logprob

    return m_sens


def heuristic_sens(fetchop_func, m, m_sens, instrs, next_nts_addrs, next_nts, next_expr):
    if len(next_nts_addrs) == 0:
        return 0.0
    else:
        addr = next_nts_addrs[0]
        banned_addrs = {tuple(addr) for addr in next_nts_addrs[1:]}
        _,ctxt = get_ctxt(fetchop_func, next_expr, addr, instrs, banned_addrs)
        cond = ','.join(ctxt)
        result = m_sens.get(next_nts[0], {}).get(cond, -1 * math.log2(0.001))
        if len(next_nts) > 1:
            m_ns = map(lambda n: m.get(n, -1 * math.log2(0.001)), next_nts[1:])
            result = functools.reduce(lambda x, y: x + y, m_ns, result)
        return result

# g : graph of current_expr
def expansion_cost(fetchop_func, stat_map, instrs, topsymb, expr, placeholders, addr=None):
    if addr == None:
        addr = get_addr(expr, placeholders[0])
    # banned list : all ther place holders other than one being expanded
    banned = set(placeholders)
    banned.discard(placeholders[0])
    banned_addrs = {tuple(get_addr(expr, e)) for e in banned}
    _,ctxt = get_ctxt(fetchop_func, expr, addr, instrs, banned_addrs)
    cond = ','.join(ctxt)
    prob = stat_map.get(cond, {}).get(topsymb, 0.001)
    l_e = -1.0 * math.log2(prob)
    # print(exprs.expression_to_string(expr), " ", cond, " ", topsymb, " ", l_e)
    return l_e


# load stat_map and instrs from file
def phogFromFile(statFileName, for_eusolver, for_pred_exprs, ret_type, specification, grammar, ref_grammar=None):
    default_value = ((None, None), (None, None))
    try:
        statFile = open(statFileName, 'rb')
    except:
        # print('Phog file not found: %s... We use the basic solver.' % statFileName)
        return default_value[0]
    rettype2mle = pickle.load(statFile)
    # if there is no mle, fall back to the original e(u)solver
    if ref_grammar is not None:
        spec_flag = get_spec_flag(specification, ref_grammar)
    else:
        spec_flag = get_spec_flag(specification, grammar)
    # if the flag is not there, pick the most similar one.
    if not (str(ret_type), for_eusolver, spec_flag) in rettype2mle:
        flags = [(flag, len(set(flag).intersection(set(spec_flag)))) for (_, _, flag) in rettype2mle]
        if len(flags) > 0:
            flags.sort(key=lambda x: x[1], reverse=True)
            spec_flag = flags[0][0]

    ((term_instrs, term_stat_map), (pred_instrs, pred_stat_map)) = rettype2mle.get((str(ret_type), for_eusolver, spec_flag), default_value)
    statFile.close()
    if for_pred_exprs:
        return (pred_instrs, pred_stat_map)
    else:
        return (term_instrs, term_stat_map)
    # From text
    # lines = [line.strip() for line in statFile]
    # instrs = [int(token) for token in lines[0].split()]
    # stat_map['_'] = {}
    # for line in lines[1:]:
    #     tokens = line.split()
    #     assert (len(tokens) == 3)
    #     ctxt = tokens[0]
    #     term_symbol = tokens[1]
    #     prob = float(tokens[2]) / 1000.0
    #     if not ctxt in stat_map.keys(): stat_map[ctxt] = {}
    #     stat_map[ctxt][term_symbol] = prob
    # statFile.close()


# def collect_constants_from_phog(phog_file, rettype):
#     def string_to_constant_rewrite(topsymb):
#         if topsymb.isdigit() or (topsymb.startswith('-') and len(topsymb) >= 2 and topsymb[1:].isdigit):
#             num = -1 * int(topsymb[1:]) if topsymb.startswith('-') else int(topsymb)
#             return grammars.ExpressionRewrite(exprs.ConstantExpression(exprs.Value(num, exprtypes.IntType())))
#         elif topsymb.startswith('#x'):  # bitvector
#             num = int('0' + topsymb[1:], 16)
#             bitsize = (len(topsymb) - 2) * 4
#             return grammars.ExpressionRewrite(exprs.ConstantExpression(exprs.Value(num, exprtypes.BitVectorType(bitsize))))
#         else:  # boolean
#             return grammars.ExpressionRewrite(exprs.ConstantExpression(exprs.Value(bool(topsymb), exprtypes.BoolType())))
#
#     (_, term_mle) = phogFromFile(phog_file, False, False, rettype)
#     (_, eu_term_mle) = phogFromFile(phog_file, True, False, rettype)
#     (_, eu_pred_mle) = phogFromFile(phog_file, True, True, rettype)
#     vocabs = set([])
#     constant_rewrites = set([])
#     # only consider integer and bitvector types
#     for mle in [term_mle, eu_term_mle, eu_pred_mle]:
#         if mle is not None:
#             for _, termsymb in mle.items():
#                 for topsymb in termsymb:
#                     vocabs.add(topsymb)
#
#     for vocab in vocabs:
#         rewrite = string_to_constant_rewrite(vocab)
#         constant_rewrites.add(rewrite)
#     # print([str(rewrite) for rewrite in constant_rewrites])
#     return constant_rewrites


class SPhog:

    def __init__(self, grammar, file, ret_type, specification, for_eusolver=False, for_pred_exprs=False, ref_grammar=None):
        instrs, stat_map = phogFromFile(file, for_eusolver, for_pred_exprs, ret_type, specification, grammar, ref_grammar)
        self.stat_map = stat_map
        self.instrs = instrs
        self.grammar = grammar
        self.enumerated_exps = []
        self.frontier = PriorityQueue()
        # pre processing for heuristic score function
        self.fetchop_func = get_fetchop_func(specification, grammar)
        self.m = compute_m(self.stat_map, grammar, self.fetchop_func)
        self.m_sens = compute_m_sens(self.m, self.stat_map, grammar, self.fetchop_func)
        self.print_phog()

    def print_phog(self):
        print('Instr : ', self.instrs) # instrs is basically a dummy value for the ngrams model
        for cond, topsymb2prob in self.stat_map.items():
            for topsymb, prob in topsymb2prob.items():
                if prob > 0.001:
                    print('%s [%s] -> %.3f' % (str(cond), topsymb, prob))

    def add_for_statistics(self, expr):
        self.enumerated_exps.append(expr)

    def clear_data(self):
        self.enumerated_exps.clear()

    # print scores of enumerated exps
    def print_statistics(self):
        if len(self.enumerated_exps) == 0: return
        #print('# enumerated : ', len(self.enumerated_exps), flush=True)


    def get_score(self, expr):
        if self.stat_map is None:
            return 200.0
        grammar = self.grammar
        # start symbol
        start = grammars.NTRewrite(grammar.start, grammar.nt_type[grammar.start])
        score = 0.0
        current = start
        nts_addrs = [[]]

        changed = True
        while changed:
            if (len(nts_addrs) == 0): break
            changed = False
            _, _, current_expr = current.to_template_expr()
            _, ctxt = get_ctxt(self.fetchop_func, current_expr, nts_addrs[0], self.instrs, {tuple(addr) for addr in nts_addrs[1:]})
            cond = ','.join(ctxt)
            for (rule, next_rewrite, generated_nts_addrs) in grammar.one_step_expand(current, nts_addrs[0]):
                _, _, rule_expr = rule.to_template_expr()
                rule_topsymb = self.fetchop_func(rule_expr)
                topsymb = self.fetchop_func(fetch_prod(expr, nts_addrs[0]))
                if rule_topsymb == topsymb or isinstance(rule, grammars.NTRewrite):
                    if isinstance(rule, grammars.NTRewrite):
                        expand_cost = 0.0
                    else:
                        expand_cost = -1.0 * math.log2(self.stat_map.get(cond, {}).get(topsymb, 0.001))

                    score += expand_cost
                    nts_addrs = nts_addrs[1:] if len(generated_nts_addrs) == 0 else generated_nts_addrs + nts_addrs[1:]
                    # print(' -> ', str(next_rewrite), ' ', expand_cost)
                    current = next_rewrite
                    changed = True
                    break
        return score



    def generate(self, compute_term_signature, points):
        # print("generating")
        grammar = self.grammar
        m = self.m
        m_sens = self.m_sens
        instrs = self.instrs
        stat_map = self.stat_map

    # ********************************************** Data structures ***************************************************
        # priority queue : list of str(rewrite)
        frontier = PriorityQueue()

        # str(rewrite)-> rewrite * addr of leftmost non-terminal symbol * (placeholder variables * non-terminals * expr)
        # roles:
        #   1. rewrite cannot be added to the priority queue as it is unhashable.
        #      We add str(rewrite) to the queue and this map stores its corresponding rewrite object.
        #   2. to avoid repeating calling to_template_expr
        strrewrite_to_rewrite = {}

        # directed graph of str(rewrite)
        # expansion_history = nx.DiGraph()

        # str(rewrite) -> normalized str(rewrite)
        strrewrite_to_normstrrewrite = {}
        # normalized str(rewrite) -> str(rewrite)   (representative of equivalence class)
        normstrrewrite_to_strrewrite = {}

        # sum of log probabilities of expansions so far
        # strrewrite -> R
        cost_so_far = {}

        # str(rewrite) -> priority
        strrewrite_to_priority = {}

        # set of ignored str(rewrite)
        ignored = []

    # ******************************************************************************************************************

        # start symbol
        start = grammars.NTRewrite(grammar.start, grammar.nt_type[grammar.start])
        # print(start)

        # init for start symbol
        start_str = str(start)
        (start_ph_vars, start_nts, start_expr) = start.to_template_expr()
        strrewrite_to_rewrite[start_str] = (start, [[]], (start_ph_vars, start_nts, start_expr))
        strrewrite_to_normstrrewrite[start_str] = start_str
        normstrrewrite_to_strrewrite[start_str] = start_str
        frontier.put(start_str, 0)
        cost_so_far[start_str] = 0

        # init for non-terminals
        for nt in grammar.non_terminals:
            strrewrite_to_normstrrewrite[nt] = nt

        def incremental_update(ignored, frontier):
            strrewrite_to_normstrrewrite.clear()
            normstrrewrite_to_strrewrite.clear()

            for nt in grammar.non_terminals:
                strrewrite_to_normstrrewrite[nt] = nt

            for rewrite_str in ignored:
                frontier.put(rewrite_str, strrewrite_to_priority[rewrite_str])
            ignored.clear()

        num_points = len(points)
        while not frontier.empty():
            # incremental search with indistinguishability
            if len(points) > num_points and options.inc:
                incremental_update(ignored, frontier)

            num_points = len(points)
            _,current_str = frontier.get()
            (current, nts_addrs, (ph_vars, nts, current_expr)) = strrewrite_to_rewrite[current_str]
            # strrewrite_to_rewrite: rewrite * addr of leftmost non-terminal symbol * (placeholder variables * non-terminals * expr)
            # why is "addr of leftmost non-terminal symbol" a list? e.g. (ite (str.prefixof "." ntString) ntString ntString) [[0, 1], [1], [2]]
            # --> there should be 3 nonterminals here (the 3 ntStrings)
            if len(nts) == 0:
                #print('%50s :\t %.2f' % (exprs.expression_to_string(current_expr), cost_so_far[current_str]), flush=True)
                yield [current_expr]
            else:
                assert (len(nts_addrs) > 0)
                # print("---")
                _, ctxt = get_ctxt(self.fetchop_func, current_expr, nts_addrs[0], instrs, {tuple(addr) for addr in nts_addrs[1:]})
                # print(current_str, exprs.expression_to_string(current_expr), nts_addrs, nts, ctxt)
                # get_ctxt(fetchop_func, partial_ast, curr, instrs, banned={}, training=False)
                # what if i wrote my own get_ctxt for ngrams? like, given current_expr
                '''
                e.g. for ngram_str2:
                Start_ph_192 []
                ntString_ph_193 []
                (int.to.str ntInt_ph_209) [0]
                (ite ntBool_ph_211 ntString_ph_212 ntString_ph_213) [0]
                (str.++ ntString_ph_195 ntString_ph_196) [0]
                (str.at ntString_ph_205 ntInt_ph_206) [0]
                (str.replace ntString_ph_199 ntString_ph_200 ntString_ph_201) [0]
                (str.substr ntString_ph_217 ntInt_ph_218 ntInt_ph_219) [0]
                (int.to.str (+ ntInt_ph_223 ntInt_ph_224)) [0, 0]
                etc.

                for phog_str:
                Start_ph_192 []
                ntString_ph_193 []
                (str.substr ntString_ph_217 ntInt_ph_218 ntInt_ph_219) [0]
                (str.substr _arg_0 ntInt_ph_223 ntInt_ph_224) [1]
                (str.substr _arg_0 0 ntInt_ph_273) [2]
                (str.substr _arg_0 0 (str.indexof ntString_ph_314 ntString_ph_315 ntInt_ph_316)) [2, 0]
                (str.substr _arg_0 0 (str.indexof _arg_0 ntString_ph_320 ntInt_ph_321)) [2, 1]
                (str.substr _arg_0 (+ ntInt_ph_279 ntInt_ph_280) ntInt_ph_281) [1, 0]
                (str.substr _arg_0 (+ (str.indexof ntString_ph_441 ntString_ph_442 ntInt_ph_443) ntInt_ph_444) ntInt_ph_445) [1, 0, 0]
                etc.

                I clearly have no clue how nts_addrs is working... if i can figure that out, then maybe we stand a chance
                because in order to get the context even for ngrams, we need to identify the nonterminal and then look 2 tokens to the left in the flattened string expr I think
                '''
                ctxt.reverse() # todo: make this only happen for ngram case or something lmao
                cond = ','.join(ctxt)
                # print("reversed ctxt", ctxt, stat_map.get(cond, {}))
                # print("context:", cond, "partial AST:", exprs.expression_to_string(current_expr), "curr:", nts_addrs[0], "instrs:", instrs, "banned:", {tuple(addr) for addr in nts_addrs[1:]})
                # observation: get_ctxt is broken for our ngrams
                # for ngrams and pcfg, the context is always null (or "_")
                
                # one step left-most expansion
                for rule, next_rewrite, generated_nts_addrs in grammar.one_step_expand(current, nts_addrs[0]):
                    next_nts_addrs = nts_addrs[1:] if len(generated_nts_addrs) == 0 else generated_nts_addrs + nts_addrs[1:]
                    next_ph_vars, next_nts, next_expr = next_rewrite.to_template_expr()
                    # update rewrite_forest and get a string of next_rewrite
                    next_str = str(next_rewrite)
                    strrewrite_to_rewrite[next_str] = (next_rewrite, next_nts_addrs, (next_ph_vars, next_nts, next_expr))
                    # if it is non-terminal rewriting, it causes no cost.
                    _, _, rule_expr = rule.to_template_expr()
                    topsymb = self.fetchop_func(rule_expr)
                    # print("topsymb", topsymb, stat_map.get(cond, {}).get(topsymb, 0.001))
                    if isinstance(rule, grammars.NTRewrite):
                        expand_cost = 0.0
                    else:
                        expand_cost = -1.0 * math.log2(stat_map.get(cond, {}).get(topsymb, 0.001))
                    new_cost = cost_so_far[current_str] + expand_cost
                    # print(current_str, ' -> ', next_str, ' ', expand_cost)

                    if next_str not in cost_so_far or new_cost < cost_so_far[next_str]:
                        cost_so_far[next_str] = new_cost
                        future_cost = 0.0 if options.noheuristic else heuristic_sens(self.fetchop_func, m, m_sens, instrs, next_nts_addrs, next_nts, next_expr)
                        priority = new_cost + future_cost
                        strrewrite_to_priority[next_str] = priority

                        # get representative of eq class which current rewrite belongs to
                        if not options.noindis:
                            normalized_next_str = normalize_rewritestr(next_expr, strrewrite_to_normstrrewrite,
                                                                       compute_term_signature,
                                                                       grammar.non_terminals)
                        # no normalization
                        else:
                            normalized_next_str = next_str

                        rep = normstrrewrite_to_strrewrite[normalized_next_str] \
                            if normalized_next_str in normstrrewrite_to_strrewrite else next_str

                        # switch representative
                        if rep == next_str or priority < strrewrite_to_priority.get(rep, max_score):
                            normstrrewrite_to_strrewrite[normalized_next_str] = next_str
                            frontier.put(rep, priority, replace=next_str)
                            # rep is ignored and replaced by new one.
                            if rep != next_str and options.inc: ignored.append(rep)
                        else:
                            # next_str is ignored because it is worse than the current representative.
                            if options.inc:
                                ignored.append(next_str)

        return
