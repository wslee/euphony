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
from semantics import semantics_bv
from core import synthesis_context
from core import specifications
from utils.bitvectors import *
from exprs import evaluation
import itertools
import random
from utils.utils import static_var

dummy_pred_name = 'dummy_pred'

# the max width of constants in BV
bitwidth = 5

def lcs_length(a, b):
    table = [[0] * (len(b) + 1) for _ in range(len(a) + 1)]
    for i, ca in enumerate(a, 1):
        for j, cb in enumerate(b, 1):
            table[i][j] = (
                table[i - 1][j - 1] + 1 if ca == cb else
                max(table[i][j - 1], table[i - 1][j]))
    return table[-1][-1]



## Constant Abstraction
class ConstAbstr(IntEnum):
    BELONG_TO_ALL_INOUTPUT = 0
    BELONG_TO_ALL_OUTPUT = 1
    BELONG_TO_ALL_INPUT = 2
    BELONG_TO_A_INOUTPUT = 3
    BELONG_TO_A_OUTPUT = 4
    BELONG_TO_A_INPUT = 5
    NOT_BELONG = 6

## Parameter Abstraction
class ParamAbstr(IntEnum):
    PARAM_0 = 0
    PARAM_1 = 1
    PARAM_2 = 2
    PARAM_3 = 3
    PARAM_4 = 4

## Operator Abstraction
class OperatorAbstr(IntEnum):
    OPER_0 = 0
    OPER_1 = 1
    OPER_2 = 2
    OPER_3 = 3
    NOTAPPEAR = 4

def aconst_to_string(constabstr):
    return "C_" + str(int(constabstr))

def aparam_to_string(paramabstr):
    return 'Var'
    # return "P_" + str(int(paramabstr))

def aoper_to_string(opabstr):
    return "F_" + str(int(opabstr))


## formula specfication dichotomy
class FormulaSpecKind(IntEnum):
    BASIC = 0

## I/O specfication dichotomy
class PBESpecKind(IntEnum):
    SOME_INPUT_BELONG_TO_OUTPUT = 0
    SOME_OUTPUT_BELONG_TO_INPUT = 1
    # ALL_INPUT_BELONG_TO_OUTPUT = 2
    # ALL_OUTPUT_BELONG_TO_INPUT = 3
    SOME_INPUT_INTERSECT_OUTPUT = 4
    # ALL_INPUT_INTERSECT_OUTPUT = 5
    # SOME_INPUT_BELONG_TO_SOME_INPUT = 6
    NO_INTERSECTION = 7


# special treatment for PBE BV
def preprocess_operators(term_exprs, pred_exprs):
    eval_context = evaluation.EvaluationContext()
    bitsize = 64
    bvlshr = semantics_bv.BVLShR(bitsize)

    new_term_exprs = set([])
    new_pred_exprs = set([])
    for term_expr, f in term_exprs:
        subst_pairs = set([])
        all_exprs = exprs.get_all_exprs(term_expr)
        for e in all_exprs:
            if exprs.is_function_expression(e):
                if e.function_info.function_name == 'bvudiv':
                    if exprs.is_constant_expression(e.children[1]):
                        value = evaluation.evaluate_expression_raw(e.children[1], eval_context)
                        new_right_child = exprs.ConstantExpression(exprs.Value(BitVector(int(math.log2(value.value)),bitsize), exprtypes.BitVectorType(bitsize)))
                        subst_pairs.add((e, exprs.FunctionExpression(bvlshr, (e.children[0], new_right_child))))

        new_term_expr = term_expr
        for (old_term, new_term) in subst_pairs:
            new_term_expr = exprs.substitute(new_term_expr, old_term, new_term)
        new_term_exprs.add((new_term_expr, f))

    for pred_expr, f in pred_exprs:
        subst_pairs = set([])
        all_exprs = exprs.get_all_exprs(pred_expr)
        for e in all_exprs:
            if exprs.is_function_expression(e):
                if e.function_info.function_name == 'bvudiv':
                    if exprs.is_constant_expression(e.children[1]):
                        value = evaluation.evaluate_expression_raw(e.children[1], eval_context)
                        new_right_child = exprs.ConstantExpression(exprs.Value(BitVector(int(math.log2(value.value)),bitsize), exprtypes.BitVectorType(bitsize)))
                        subst_pairs.add((e, exprs.FunctionExpression(bvlshr, (e.children[0], new_right_child))))

        new_pred_expr = pred_expr
        for (old_term, new_term) in subst_pairs:
            new_pred_expr = exprs.substitute(new_pred_expr, old_term, new_term)
        new_pred_exprs.add((new_pred_expr, f))

    return(new_term_exprs, new_pred_exprs)


def get_pbespec_kind_str(specification):
    valuations = specification.valuations
    # value : str | int | utils.BitVector | bool
    # valuations: exprs.Value tuple -> str | int | utils.BitVector | bool
    # we make inputs be of primitive type
    flags = set([])
    for inputs, output in valuations.items():
        inputs = [input.value_object for input in inputs]
        if (any(is_sub(i, output) for i in inputs)):
            flags.add(PBESpecKind.SOME_INPUT_BELONG_TO_OUTPUT)
        if (any(is_sub(output, i) for i in inputs)):
            flags.add(PBESpecKind.SOME_OUTPUT_BELONG_TO_INPUT)
        if (any(is_intersection_nonempty(output, i) for i in inputs)):
            flags.add(PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT)
        # if (any(i1 != i2 and is_sub(i1, i2) for (i1, i2) in itertools.product(inputs, inputs))):
        #     flags.add(PBESpecKind.SOME_INPUT_BELONG_TO_SOME_INPUT)

    # if (all(all(is_sub(input, output) for input in inputs) for inputs, output in valuations.items())):
    #     flags.add(PBESpecKind.ALL_INPUT_BELONG_TO_OUTPUT)
    # if (all(all(is_sub(output, input) for input in inputs) for inputs, output in valuations.items())):
    #     flags.add(PBESpecKind.ALL_OUTPUT_BELONG_TO_INPUT)
    # if (all(all(is_intersection_nonempty(output, input) for input in inputs) for inputs, output in valuations.items())):
    #     flags.add(PBESpecKind.ALL_INPUT_INTERSECT_OUTPUT)

    if len(flags) == 0:
        flags.add(PBESpecKind.NO_INTERSECTION)
    return tuple(flags)


def get_pbespec_kind_bv(specification, grammar):
    generator_factory = enumerators.RecursiveGeneratorFactory()
    term_generator = grammar.to_generator(generator_factory)
    max_size = 3
    term_generator.set_size(max_size)
    smallexprs = [exp for exp in term_generator.generate()]
    inputs2values = {}

    valuations = specification.valuations
    # value : str | int | utils.BitVector | bool
    # valuations: exprs.Value tuple -> str | int | utils.BitVector | bool
    # we make inputs be of primitive type
    flags = set([])
    eval_context = evaluation.EvaluationContext()
    for inputs, output in valuations.items():
        eval_context.set_valuation_map(inputs)
        values = []
        for se in smallexprs:
            try:
                values.append(evaluation.evaluate_expression_raw(se, eval_context))
            except:
                continue
        inputs2values[inputs] = values
        if (any(is_sub(v, output) for v in values)):
            flags.add(PBESpecKind.SOME_INPUT_BELONG_TO_OUTPUT)
        if (any(is_sub(output, v) for v in values)):
            flags.add(PBESpecKind.SOME_OUTPUT_BELONG_TO_INPUT)
        if (any(is_intersection_nonempty(output, v) for v in values)):
            flags.add(PBESpecKind.SOME_INPUT_INTERSECT_OUTPUT)
        # if (any(i1 != i2 and is_sub(i1, i2) for (i1, i2) in itertools.product(inputs, inputs))):
        #     flags.add(PBESpecKind.SOME_INPUT_BELONG_TO_SOME_INPUT)

    if (all(any(is_sub(value, output) for value in inputs2values[inputs]) for inputs, output in valuations.items())):
        flags.add(PBESpecKind.ALL_INPUT_BELONG_TO_OUTPUT)
    if (all(any(is_sub(output, value) for value in inputs2values[inputs]) for inputs, output in valuations.items())):
        flags.add(PBESpecKind.ALL_OUTPUT_BELONG_TO_INPUT)
    if (all(any(is_intersection_nonempty(output, value) for value in inputs2values[inputs]) for inputs, output in valuations.items())):
        flags.add(PBESpecKind.ALL_INPUT_INTERSECT_OUTPUT)

    if len(flags) == 0:
        flags.add(PBESpecKind.NO_INTERSECTION)
    return tuple(flags)


## Specification flag
def get_spec_flag(specification, grammar):
    if isinstance(specification, specifications.PBESpec):
        if specification.theory == 'SLIA':
            return get_pbespec_kind_str(specification)
        # else:
        #     # return get_pbespec_kind_bv(specification, grammar)
        return (PBESpecKind.NO_INTERSECTION,)
    else:
        # TODO
        return (FormulaSpecKind.BASIC,)


def basic_vocabs_for_spec(specification):
    # collect vocab
    all_vocabs = set(['_'])
    n_paramabstr = 5
    # abstract constants
    if isinstance(specification, specifications.PBESpec) and specification.theory == 'SLIA':
        n_constabstr = 7
        for i in range(n_constabstr):
            all_vocabs.add(aconst_to_string(i))
    # abstract parameters (only 'Var' currently)
    for i in range(n_paramabstr):
        all_vocabs.add(aparam_to_string(i))
    return all_vocabs


def is_intersection_nonempty(v1, v2):
    if isinstance(v1, str) and isinstance(v2, str):
        return lcs_length(v1, v2) > 0
    elif isinstance(v1, BitVector) and isinstance(v2, BitVector):
        return (v1.value & v2.value) != 0
    elif type(v1) == type(v2):
        return v1 == v2
    else:
        return False

def is_sub(v1, v2):
    if isinstance(v1, str) and isinstance(v2, str):
        return v1 in v2
    elif isinstance(v1, BitVector) and isinstance(v2, BitVector):
        try:
            return (v1.value & v2.value) == v1.value
        except:
            return False
    # elif isinstance(v1, int) and isinstance(v2, int):
    #     return v1 <= v2
    elif type(v1) == type(v2):
        return v1 == v2
    else:
        return False


def get_constant_category(value, valuations):
    # value : str | int | utils.BitVector | bool
    # valuations: exprs.Value tuple -> str | int | utils.BitVector | bool
    # we make inputs be of primitive type

    hit_input = 0
    hit_output = 0
    total_num = len(valuations)
    for inputs, output in valuations.items():
        if is_sub(value, output):
            hit_output += 1
        if len([input for input in inputs if is_sub(value, input.value_object)]) > 0:
            hit_input += 1

    if hit_input == total_num and hit_output == total_num:
        return ConstAbstr.BELONG_TO_ALL_INOUTPUT
    elif hit_input == total_num:
        return ConstAbstr.BELONG_TO_ALL_INPUT
    elif hit_output == total_num:
        return ConstAbstr.BELONG_TO_ALL_OUTPUT
    elif hit_input > 0 and hit_output > 0:
        return ConstAbstr.BELONG_TO_A_INOUTPUT
    elif hit_input > 0:
        return ConstAbstr.BELONG_TO_A_INPUT
    elif hit_output > 0:
        return ConstAbstr.BELONG_TO_A_OUTPUT
    else:
        return ConstAbstr.NOT_BELONG

def get_parameter_category(nth, n_params):
    if n_params <= 5:
        return nth
    else:
        div = nth / n_params
        if div < 0.2:
            return ParamAbstr.PARAM_0
        elif div < 0.4:
            return ParamAbstr.PARAM_1
        elif div < 0.6:
            return ParamAbstr.PARAM_2
        elif div < 0.8:
            return ParamAbstr.PARAM_3
        else:
            return ParamAbstr.PARAM_4


def fetchop_func_pbe(specification, grammar, expr):
    if (exprs.is_constant_expression(expr)):
        if specification.theory == 'SLIA':
            eval_context = evaluation.EvaluationContext()
            value = evaluation.evaluate_expression_raw(expr, eval_context)
            if isinstance(value, int):
                result = fetchop(expr)
            else:
                const_category = get_constant_category(value, specification.valuations)
                result = aconst_to_string(const_category)
        else:
            result = fetchop(expr)
    elif (exprs.is_formal_parameter_expression(expr)):
        # if isinstance(specification, specifications.PBESpec):
        #     n_params = len(specification.synth_fun.domain_types)
        # else: # formula spec
        #     n_params = len(specification.synth_funs[0].domain_types)
        # param_category = get_parameter_category(expr.parameter_position, n_params)
        # # print(exprs.expression_to_string(expr), ' ', param_category)

        # only a single parameter
        result = aparam_to_string(0)
    else:
        result = fetchop(expr)
    # print(exprs.expression_to_string(expr), ' ', result)
    return result


# for CrCy
def fetchop_func_formula(specification, grammar, expr):
    if (exprs.is_function_expression(expr)):
        # assert (exprs.is_function_expression(specification.spec_expr))
        # origexpr = specification.spec_expr.children[0]
        result = fetchop(expr)
    elif (exprs.is_formal_parameter_expression(expr)):
        # only a single parameter
        result = aparam_to_string(0)
    else:
        result = fetchop(expr)
    return result



def get_fetchop_func(specification, grammar):
    @static_var("cache", {})
    # at most expr can be a rule expression. no memory explosion
    def fetchop_func(expr):
        key = exprs.expression_to_string(expr)
        if key in fetchop_func.cache:
            return fetchop_func.cache[key]

        if isinstance(specification, specifications.PBESpec):
            result = fetchop_func_pbe(specification, grammar, expr)
        else:
            result = fetchop_func_formula(specification, grammar, expr)

        fetchop_func.cache[key] = result
        return result
    return fetchop_func



# def get_fetchop_func(specification, grammar):
#     if isinstance(specification, specifications.PBESpec):
#         generator_factory = enumerators.RecursiveGeneratorFactory()
#         term_generator = grammar.to_generator(generator_factory)
#         max_size = 3
#         size2expr = {}
#         for size in range(max_size):
#             term_generator.set_size(size + 1)
#             size2expr[size + 1] = [exp for exp in term_generator.generate()]
#
#         @static_var("cache", {})
#         # at most expr can be a rule expression. no memory explosion
#         def fetchop_func(expr):
#             key = exprs.expression_to_string(expr)
#             if key in fetchop_func.cache:
#                 return fetchop_func.cache[key]
#
#             if (exprs.is_constant_expression(expr)):
#                 const_category = max_size + 1
#                 for size in range(max_size, 0, -1):
#                     for se in size2expr[size]:
#                         if expr in exprs.get_all_exprs(se):
#                             try:
#                                 eval_context = evaluation.EvaluationContext()
#                                 for inputs, output in specification.valuations.items():
#                                     eval_context.set_valuation_map(inputs)
#                                     value = evaluation.evaluate_expression_raw(se, eval_context)
#                                     if is_sub(value, output):
#                                         const_category = size
#                                         break
#                             except:
#                                 continue
#                                 # print(exprs.expression_to_string(se), ' ', const_category)
#                 result = aconst_to_string(const_category)
#                 print(exprs.expression_to_string(expr), ' ', const_category)
#             # elif (exprs.is_function_expression(expr)):
#             #     const_category = max_size + 1
#             #     for size in range(max_size, 0, -1):
#             #         for se in size2expr[size]:
#             #             if exprs.is_function_expression(se) and expr.function_info.function_name == se.function_info.function_name:
#             #                 try:
#             #                     eval_context = evaluation.EvaluationContext()
#             #                     for inputs, output in specification.valuations.items():
#             #                         eval_context.set_valuation_map(inputs)
#             #                         value = evaluation.evaluate_expression_raw(se, eval_context)
#             #                         # print('input : ', [i for i in inputs])
#             #                         # print('f : ', exprs.expression_to_string(se))
#             #                         # print('output : ', output)
#             #                         if is_sub(value, output):
#             #                             const_category = size
#             #                             break
#             #                 except:
#             #                     continue
#             #                     # print(exprs.expression_to_string(se), ' ', const_category)
#             #     result = aconst_to_string(const_category)
#             #     if const_category < max_size + 1: print(exprs.expression_to_string(expr), ' ', const_category)
#             else:
#                 result = fetchop(expr)
#             # print(exprs.expression_to_string(expr), ' ', result)
#             fetchop_func.cache[key] = result
#             return result
#
#         return fetchop_func
#     else:
#         return fetchop



## Tcond

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
    return get_history_new(expr, pick)

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


def get_history_new(expr, pick=None):

    def get_partial_ast(expr, addr):
        # print('get_partial_ast: ', exprs.expression_to_string(expr), ' ', addr)
        if len(addr) == 0:
            if not (exprs.is_function_expression(expr)):
                return expr
            else:
                return exprs.FunctionExpression(expr.function_info, ())
        else:
            hd, *tl = addr
            rest = get_partial_ast(expr.children[hd], tl)
            children = expr.children[0:hd] + (rest,)
            return exprs.FunctionExpression(expr.function_info, children)

    def remove_children(expr):
        if exprs.is_function_expression(expr):
            expr_wo_children = exprs.FunctionExpression(expr.function_info, ())
        else:
            expr_wo_children = expr
        return expr_wo_children

    # for online search
    if pick is not None:
        return [(get_partial_ast(expr, pick), ())]

    if not exprs.is_function_expression(expr):
        return [(expr, ())]

    stack = []
    for i, child in enumerate(expr.children):
        stack.append((child, [i]))

    history = [(remove_children(expr), ())]
    # print(exprs.expression_to_string(expr))
    while len(stack) > 0:
        e, addr = stack.pop(0)
        # add next step
        history.append((get_partial_ast(expr, addr), tuple(addr)))
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
def get_ctxt(fetchop_func, partial_ast, curr, instrs, banned={}, training=False):

    def get_children(node):
        if exprs.is_function_expression(node):
            return node.children
            # return [child for child in node.children if child is not None]
        else:
            return []

    def addr_append(curr_addr, idx):
        curr_addr.append(idx)

    def get_partial_ast(expr, addr):
        if not (exprs.is_function_expression(expr)) or len(addr) == 0:
            return expr
        else:
            hd, *tl = addr
            rest = get_partial_ast(expr.children[hd], tl)
            children = expr.children[0:hd] + (rest,)
            return exprs.FunctionExpression(expr.function_info, children)

    if not training:
        history = get_history(partial_ast, pick=tuple(curr))
        # history = get_history_new(partial_ast, pick=tuple(curr))
        assert (len(history) == 1)
        # assert (exprs.expression_to_string(history[0][0]) == exprs.expression_to_string(get_partial_ast(partial_ast, curr)))
        partial_ast = history[0][0]
        # if history[0][0] != get_partial_ast(partial_ast, curr):
        #     print('--------')
        #     print(history[0][0])
        #     print(get_partial_ast(partial_ast, curr))
        #     print('--------')
        # partial_ast = history


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
                ctxt.append(fetchop_func(curr_node))
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


