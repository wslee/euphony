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
from utils.utils import static_var

dummy_pred_name = 'dummy_pred'

class Tcond(IntEnum):
    UP = 0
    DOWN_FIRST = 1
    DOWN_LAST = 2
    LEFT = 3
    RIGHT = 4
    PREV_DFS = 5
    WRITE_VALUE = 6
    # WRITE_TYPE = 7

def fetchop(expr):
    if (exprs.is_function_expression(expr)):
        fkind = expr.function_info.function_name
        if dummy_pred_name in fkind: return dummy_pred_name
        else: return fkind
    elif (exprs.is_constant_expression(expr)):
        # return str(exprs.get_expression_type(expr))
        return exprs.expression_to_string(expr)
    elif (exprs.is_formal_parameter_expression(expr)):
        return exprs.expression_to_string(expr)
    else:
        return 'Var'

def fetchtype(expr):
    return str(exprs.get_expression_type(expr))

def fetchop_rewrite(rewrite):
    _, _, rule_expr = rewrite.to_template_expr()
    return fetchop(rule_expr)

def fetchtype_rewrite(rewrite):
    _, _, rule_expr = rewrite.to_template_expr()
    return fetchtype(rule_expr)

def fetch_prod(partial_ast, curr_addr):
    curr_node = partial_ast
    for idx in curr_addr:
        if exprs.is_function_expression(curr_node) and len(curr_node.children) > 0:
            if (len(curr_node.children) > idx):
                curr_node = curr_node.children[idx]
            else:
                print(exprs.expression_to_string(curr_node), ' ', idx, ' ', len(curr_node.children))
                assert False

    return curr_node


def get_history(expr, pick=None):
    def add_child(expr, parent_addr, child_expr):
        if not (exprs.is_function_expression(expr)):
            return expr

        if len(parent_addr) == 0:
            children = expr.children + (child_expr,)
        else:
            hd, *tl = parent_addr
            children = list(expr.children)
            children[hd] = add_child(expr.children[hd], tl, child_expr)
            children = tuple(children)
        return exprs.FunctionExpression(expr.function_info, children)

    def remove_children(expr):
        if exprs.is_function_expression(expr):
            expr_wo_children = exprs.FunctionExpression(expr.function_info, ())
        else:
            expr_wo_children = expr
        return expr_wo_children

    if not exprs.is_function_expression(expr):
        return [(expr, ())]

    stack = []
    for i, child in enumerate(expr.children):
        stack.append((child, [i]))

    history = [(remove_children(expr), ())]
    # print(exprs.expression_to_string(expr))
    while len(stack) > 0:
        e, addr = stack.pop(0)
        # print(addr)
        # print(exprs.expression_to_string(history[-1]))
        # add next step
        if exprs.is_function_expression(e):
            next_step = add_child(history[-1][0], addr[:-1], exprs.FunctionExpression(e.function_info, ()))
            history.append((next_step, tuple(addr)))
        else:
            next_step = add_child(history[-1][0], addr[:-1], e)
            history.append((next_step, tuple(addr)))

        # for online search
        if pick is not None and pick == tuple(addr):
            return [history[-1]]
        # DFS visit
        if exprs.is_function_expression(e):
            added = []
            for i, child in enumerate(e.children):
                new_addr = list(addr)
                new_addr.append(i)
                added.append((child, new_addr))
            stack[0:0] = added
            # print(exprs.expression_to_string(history[-1][0]), ' ', history[-1][1])
    return history


# # banned : banned addrs
def get_ctxt(partial_ast, curr, instrs, banned={}, training=False):

    def get_children(node):
        if exprs.is_function_expression(node):
            return node.children
            # return [child for child in node.children if child is not None]
        else:
            return []

    def addr_append(curr_addr, idx):
    # currently, ocaml part is learning under assumption of absence of placeholders other than target
        curr_addr.append(idx)

    # def remove_addr(expr, addr):
    #     hd, *tl = addr
    #     assert (exprs.is_function_expression(expr))
    #     assert (hd < len(expr.children))
    #     if len(tl) == 0:
    #         new_children = list(expr.children)
    #         new_children[hd] = None
    #         return exprs.FunctionExpression(expr.function_info, tuple(new_children))
    #     else:
    #         new_children = list(expr.children)
    #         new_children[hd] = remove_addr(expr.children[hd], tl)
    #         return exprs.FunctionExpression(expr.function_info, tuple(new_children))
    #
    # # remove banned
    # if len(banned) > 0:
    #     for addr in banned:
    #         partial_ast = remove_addr(partial_ast, addr)

    def get_partial_ast(expr, addr):
        if not (exprs.is_function_expression(expr)) or len(addr) == 0:
            return expr
        else:
            hd, *tl = addr
            rest = get_partial_ast(expr.children[hd], tl)
            children = expr.children[0:hd] + (rest,)
            return exprs.FunctionExpression(expr.function_info, children)

    if not training:
        # history = get_history(partial_ast, pick=tuple(curr))
        # assert (len(history) == 1)
        # assert (exprs.expression_to_string(history[0][0]) == exprs.expression_to_string(get_partial_ast(partial_ast, curr)))
        # partial_ast = history[0][0]
        partial_ast = get_partial_ast(partial_ast, curr)

    ctxt = []
    curr_addr = list(curr)
    for hd in instrs:
        if hd == Tcond.UP:
            if len(curr_addr) > 0:
                curr_addr.pop()
        elif hd == Tcond.DOWN_FIRST:
            curr_node = fetch_prod(partial_ast, curr_addr)
            children = get_children(curr_node)
            if len(children) > 0: addr_append(curr_addr, 0)
        elif hd == Tcond.DOWN_LAST:
            curr_node = fetch_prod(partial_ast, curr_addr)
            children = get_children(curr_node)
            if len(children) > 0:
                addr_append(curr_addr, len(children) - 1)
        elif hd == Tcond.LEFT:
            if len(curr_addr) > 0:
                last = curr_addr.pop()
                if last > 0: addr_append(curr_addr, last - 1)
                else: addr_append(curr_addr, 0)
        elif hd == Tcond.RIGHT:
            if len(curr_addr) > 0:
                last = curr_addr.pop()
                parent = fetch_prod(partial_ast, curr_addr)
                sibling = get_children(parent)
                if last + 1 < len(sibling): addr_append(curr_addr, last + 1)
                else: addr_append(curr_addr, last)
        elif hd == Tcond.PREV_DFS:
            if len(curr_addr) > 0:
                last = curr_addr.pop()
                if last > 0:
                    addr_append(curr_addr, last - 1)
                    while True:
                        curr_node = fetch_prod(partial_ast, curr_addr)
                        children = get_children(curr_node)
                        if len(children) > 0:
                            addr_append(curr_addr, len(children) - 1)
                        else: break
        elif hd == Tcond.WRITE_VALUE:
            if curr == curr_addr and not training:
                ctxt.append('_')
            else:
                curr_node = fetch_prod(partial_ast, curr_addr)
                ctxt.append(fetchop(curr_node))
        # elif hd == Tcond.WRITE_TYPE:
        #     if curr == curr_addr and not training:
        #         ctxt.append('_')
        #     else:
        #         curr_node = fetch_prod(partial_ast, curr_addr)
        #         ctxt.append(fetchtype(curr_node))
        else:
            print(hd)
            assert False

    return (tuple(curr_addr), ctxt)


# return all the subexpressions of expr (inclusive)
def get_all_exprs(expr):
    result = set([expr])
    if exprs.is_function_expression(expr):
        for child in expr.children:
            result.update(get_all_exprs(child))
    return result

def get_addr(partial_ast, target):
    addr = []
    curr_node = partial_ast
    while curr_node != target:
        assert (exprs.is_function_expression(curr_node))
        children = curr_node.children
        for (i, child) in enumerate(children):
            if target in get_all_exprs(child):
                addr.append(i)
                curr_node = child
                break
    return addr



def rewrite_expr_to_string(expr):
    kind = expr.expr_kind
    if (kind == exprs._function_expression):
        # child_strs = []
        str = '(' + expr.function_info.function_name
        for child in expr.children:
            str += ' '
            child_str = rewrite_expr_to_string(child)
            # child_strs.append(child_str)
            str += child_str
        str += ')'
        return str
    else:
        str = exprs.expression_to_string(expr)
        # non-terminal symbol
        if kind == exprs._variable_expression:
            tokens = str.split('_ph_')
            str = tokens[0]
            return str
        else:
            return str


# rewrite -> replace synthfun type expression to string of signature
# e.g.,   (- (+ x 0) S)  ->  (- [0,1] S)
#         (ite (< x 0) (+ x 1) S) -> (ite [False, False] [1,2] S)
# it will be used to find eq class of rewrites (sentential forms)
def normalize_rewritestr(expr, strrewrite_to_normstrrewrite, compute_term_signature, non_terminals):
    def get_term_str(rewrite_str, expr):
        try:
            sig_str = str(compute_term_signature(expr))
            strrewrite_to_normstrrewrite[rewrite_str] = sig_str
            return strrewrite_to_normstrrewrite[rewrite_str]
        except basetypes.PartialFunctionError:
            # print('skip : ', exprs.expression_to_string(expr))
            return rewrite_str
        except basetypes.UnboundLetVariableError:
            return rewrite_str

    # non-terminals are also handled here
    rewrite_str = rewrite_expr_to_string(expr)
    if rewrite_str in strrewrite_to_normstrrewrite:
        return strrewrite_to_normstrrewrite[rewrite_str]
    else:
        kind = expr.expr_kind
        if (kind == exprs._function_expression):
            retval = '(' + expr.function_info.function_name
            for child in expr.children:
                retval += ' '
                child_str = normalize_rewritestr(child, strrewrite_to_normstrrewrite, compute_term_signature, non_terminals)
                retval += child_str
            retval += ')'

            include_nt = False
            for nt in non_terminals:
                include_nt = include_nt or (retval.find(nt) > -1)

            if include_nt:
                strrewrite_to_normstrrewrite[rewrite_str] = retval
                return retval
            else:
                return get_term_str(rewrite_str, expr)
        else:
            return get_term_str(rewrite_str, expr)


# def normalize_rewritestr(expr, nts_addrs, strrewrite_to_normstrrewrite, compute_term_signature):
#
#     def get_term_str(rewrite_str, expr):
#         try:
#             sig_str = str(compute_term_signature(expr))
#             strrewrite_to_normstrrewrite[rewrite_str] = sig_str
#             return strrewrite_to_normstrrewrite[rewrite_str]
#         # e.g., division by zero
#         except basetypes.PartialFunctionError:
#             # print('skipping invalid expr: ', exprs.expression_to_string(expr))
#             return rewrite_str
#
#     rewrite_str = rewrite_expr_to_string(expr)
#     if rewrite_str in strrewrite_to_normstrrewrite:
#         return strrewrite_to_normstrrewrite[rewrite_str]
#     else:
#         # complete expression without non-terminals
#         if len(nts_addrs) == 0:
#             return get_term_str(rewrite_str, expr)
#         else:
#             kind = expr.expr_kind
#             assert (kind == exprs._function_expression)
#             retval = '(' + expr.function_info.function_name
#             for i,child in enumerate(expr.children):
#                 retval += ' '
#                 child_nts_addrs = [nts_addr for nts_addr in nts_addrs if nts_addr[0] == i]
#                 if child_nts_addrs == [[i]]:
#                     child_str = rewrite_expr_to_string(expr.children[i])
#                 else:
#                     child_nts_addrs = [nts_addr[1:] for nts_addr in child_nts_addrs]
#                     child_str = normalize_rewritestr(child, child_nts_addrs, strrewrite_to_normstrrewrite, compute_term_signature)
#                 retval += child_str
#             retval += ')'
#             return retval
#
#
#
#
# def lcs_length(a, b):
#     table = [[0] * (len(b) + 1) for _ in range(len(a) + 1)]
#     for i, ca in enumerate(a, 1):
#         for j, cb in enumerate(b, 1):
#             table[i][j] = (
#                 table[i - 1][j - 1] + 1 if ca == cb else
#                 max(table[i][j - 1], table[i - 1][j]))
#     return table[-1][-1]
#
# import sys
# def printf(format, *args):
#     sys.stdout.write(format % args)
#
# def edit_distance(word1, word2):
#     len_1 = len(word1)
#     len_2 = len(word2)
#     x = [[0] * (len_2 + 1) for _ in range(len_1 + 1)]  # the matrix whose last element ->edit distance
#     for i in range(0, len_1 + 1):  # initialization of base case values
#         x[i][0] = i
#     for j in range(0, len_2 + 1):
#         x[0][j] = j
#     for i in range(1, len_1 + 1):
#         for j in range(1, len_2 + 1):
#             if word1[i - 1] == word2[j - 1] or (word1[i - 1] == '#'):
#                 x[i][j] = x[i - 1][j - 1]
#             else:
#                 x[i][j] = min(x[i][j - 1], x[i - 1][j], x[i - 1][j - 1]) + 1
#         if (word1[i - 1] == '#'):
#             before = x[i][0]
#             start = False
#             for j in range(1, len_2 + 1):
#                 if x[i][j] > before:
#                     start = True
#                 if start:
#                     x[i][j] = x[i][j-1]
#                 before = x[i][j]
#
#
#     # print(word1, ' ', word2)
#     # for i in range(1, len_1 + 1):
#     #     for j in range(1, len_2 + 1):
#     #         printf('%5d ' % x[i][j])
#     #     printf('\n')
#
#     # exit(0)
#     return x[i][j]
#
# def edit_distance(word1, word2):
#     len_1 = len(word1)
#     len_2 = len(word2)
#     x = [[0] * (len_2 + 1) for _ in range(len_1 + 1)]  # the matrix whose last element ->edit distance
#     for i in range(0, len_1 + 1):  # initialization of base case values
#         x[i][0] = i
#     for j in range(0, len_2 + 1):
#         x[0][j] = j
#     for i in range(1, len_1 + 1):
#         for j in range(1, len_2 + 1):
#             if word1[i - 1] == word2[j - 1]:
#                 x[i][j] = x[i - 1][j - 1]
#             else:
#                 x[i][j] = min(x[i][j - 1], x[i - 1][j], x[i - 1][j - 1]) + 1
#
#     # print(word1, ' ', word2)
#     # for i in range(0, len_1 + 1):
#     #     for j in range(0, len_2 + 1):
#     #         printf('%5d ' % x[i][j])
#     #     printf('\n')
#
#     if '#' in word1:
#         i = word1.index('#')
#         if i - 2 < 0:
#             return min(x[0])
#         else:
#             # print(i, ' ', x[i - 2])
#             return min(x[i - 2])
#     else:
#         return x[i][j]


