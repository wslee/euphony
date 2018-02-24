#!/usr/bin/env python3
# exprs.py ---
#
# Filename: exprs.py
# Author: Abhishek Udupa
# Created: Wed Aug 19 15:47:31 2015 (-0400)
#
#
# Copyright (c) 2015, Abhishek Udupa, University of Pennsylvania
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#    This product includes software developed by The University of Pennsylvania
# 4. Neither the name of the University of Pennsylvania nor the
#    names of its contributors may be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# Code:

"""Implements an expression type, along with a manager to create
expressions as needed
"""

from utils import basetypes
import collections
from enum import IntEnum
from exprs import exprtypes
from semantics import semantics_types
from utils import utils

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class ExpressionKinds(IntEnum):
    """Expression Kinds
    variable_expression: An expression representing a typed variable.
    constant_expression: An expression representing a typed constant.
    function_expression: An expression representing a function application.
    """
    variable_expression = 1
    formal_parameter_expression = 2
    constant_expression = 3
    function_expression = 4


_VariableExpression = collections.namedtuple('VariableExpression',
                                             ['expr_kind', 'variable_info', 'expr_id'])

_FormalParameterExpression = collections.namedtuple('FormalParameterExpression',
                                                    ['expr_kind',
                                                     'unknown_function_info',
                                                     'parameter_type',
                                                     'parameter_position',
                                                     'expr_id'])

_ConstantExpression = collections.namedtuple('ConstantExpression',
                                             ['expr_kind', 'value_object', 'expr_id'])

_FunctionExpression = collections.namedtuple('FunctionExpression',
                                             ['expr_kind', 'function_info',
                                              'children', 'expr_id'])

Value = collections.namedtuple('Value', ['value_object', 'value_type'])

_variable_expression = ExpressionKinds.variable_expression
_constant_expression = ExpressionKinds.constant_expression
_function_expression = ExpressionKinds.function_expression
_formal_parameter_expression = ExpressionKinds.formal_parameter_expression

def get_expr_with_id(expr_object, expr_id):
    kind = expr_object.expr_kind
    if (kind == _variable_expression):
        (a, b, c) = expr_object
        return _VariableExpression(a, b, expr_id)
    elif (kind == _constant_expression):
        (a, b, c) = expr_object
        return _ConstantExpression(a, b, expr_id)
    elif (kind == _formal_parameter_expression):
        (a, b, c, d, e) = expr_object
        return _FormalParameterExpression(a, b, c, d, expr_id)
    elif (kind == _function_expression):
        (a, b, c, d) = expr_object
        return _FunctionExpression(a, b, c, expr_id)
    else:
        assert False


def VariableExpression(variable_info):
    return _VariableExpression(_variable_expression, variable_info, None)

def ConstantExpression(value_object):
    return _ConstantExpression(_constant_expression, value_object, None)

def FunctionExpression(function_info, children):
    assert function_info is not None
    assert type(children) is tuple
    return _FunctionExpression(_function_expression,
                               function_info, children, None)

def FormalParameterExpression(unknown_function_info, parameter_type, parameter_position):
    return _FormalParameterExpression(_formal_parameter_expression,
                                      unknown_function_info, parameter_type,
                                      parameter_position, None)

def value_to_string(the_value):
    if (the_value.value_type.type_code == exprtypes.TypeCodes.boolean_type):
        if (the_value.value_object == True):
            return 'true'
        else:
            return 'false'
    elif (the_value.value_type.type_code == exprtypes.TypeCodes.integer_type):
        return str(the_value.value_object)
    elif (the_value.value_type.type_code == exprtypes.TypeCodes.bit_vector_type):
        return utils.bitvector_to_string(the_value.value_object, the_value.value_type.size)


class VariableInfo(object):
    __slots__ = ['variable_type', 'variable_eval_offset',
                 'variable_name', 'synthesis_ctx']
    _undefined_offset = 1000000000

    def __init__(self, variable_type, variable_name,
                 variable_eval_offset = _undefined_offset,
                 synthesis_ctx = None):
        self.variable_name = variable_name
        self.variable_type = variable_type
        self.variable_eval_offset = variable_eval_offset
        self.synthesis_ctx = None

    def __str__(self):
        return ('VariableInfo(%s, %s, %s)' % (str(self.variable_type),
                                              self.variable_name,
                                              str(self.variable_eval_offset)))


def _constant_to_string(constant_type, constant_value):
    if constant_type == exprtypes.BoolType():
        return str(constant_value).lower()
    elif constant_type == exprtypes.IntType():
        return str(constant_value)
    elif constant_type == exprtypes.StringType():
        return '"%s"' % constant_value
    else:
        return utils.bitvector_to_string(constant_value, constant_type.size)

# non-recursive
# def expression_to_string(expr):
#     """Returns a string representation of an expression"""
#     stack = [expr]
#     retval = ''
#     while len(stack) > 0:
#         curr = stack.pop(0)
#         if curr == None:
#             # retval = retval[:-1] + ') '
#             retval += ') '
#             continue
#         kind = curr.expr_kind
#         if (kind == _variable_expression):
#             retval += curr.variable_info.variable_name
#         elif (kind == _formal_parameter_expression):
#             retval += '_arg_%d' % curr.parameter_position
#         elif (kind == _constant_expression):
#             retval += _constant_to_string(curr.value_object.value_type, curr.value_object.value_object)
#         else:
#             if curr.function_info.function_name != 'let' \
#                     and curr.function_info.function_name != 'ne':
#                 retval += '(' + curr.function_info.function_name
#                 stack[0:0] = curr.children + (None,)
#             else:
#                 retval += curr.function_info.to_string(curr)
#         retval += ' '
#
#     return retval[:-1]

# recursive
def expression_to_string(expr):
    """Returns a string representation of an expression"""
    kind = expr.expr_kind
    if (kind == _variable_expression):
        return expr.variable_info.variable_name
    elif (kind == _formal_parameter_expression):
        return '_arg_%d' % expr.parameter_position
    elif (kind == _constant_expression):
        return _constant_to_string(expr.value_object.value_type,
                                   expr.value_object.value_object)
    else:
        if expr.function_info.function_name != 'let' \
                and expr.function_info.function_name != 'ne':
            retval = '(' + expr.function_info.function_name
            for child in expr.children:
                retval += ' '
                retval += expression_to_string(child)
            retval += ')'
            return retval
        else:
            return expr.function_info.to_string(expr)


def get_expression_type(expr):
    """Returns the type of the expression."""
    kind = expr.expr_kind
    if (kind == _variable_expression):
        return expr.variable_info.variable_type
    elif (kind == _formal_parameter_expression):
        return expr.parameter_type
    elif (kind == _constant_expression):
        return expr.value_object.value_type
    elif (kind == _function_expression):
        return expr.function_info.range_type
    else:
        raise basetypes.UnhandledCaseError('Odd expression kind: %s' % expr.expr_kind)

def get_expression_size(expr):
    """Returns the (syntactic) size of the expression."""
    kind = expr.expr_kind
    if (kind == _variable_expression or
        kind == _constant_expression or
        kind == _formal_parameter_expression):
        return 1
    elif (expr.expr_kind == ExpressionKinds.function_expression):
        retval = 1
        for child in expr.children:
            retval += get_expression_size(child)
        return retval
    else:
        raise basetypes.UnhandledCaseError('Odd expression kind: %s' % expr.expr_kind)

def substitute(expr, old_term, new_term):
    ret = substitute_all(expr, [(old_term, new_term)])
    return ret

def substitute_all(expr, substitute_pairs):
    for old,new in substitute_pairs:
        if expr == old:
            ret = new
            break
    else:
        if (expr.expr_kind == _function_expression):
            subst_children = [substitute_all(x, substitute_pairs)
                    for x in expr.children]
            ret = FunctionExpression(expr.function_info, tuple(subst_children))
        else:
            ret = expr
    return ret

def find_all_applications(expr, function_name):
    ret = []
    if (isinstance(expr, _FunctionExpression)):
        if (expr.function_info.function_name == function_name):
            ret.append(expr)
        for child in expr.children:
            ret.extend(find_all_applications(child, function_name))
    return ret

# Returns only the first application of a function it finds
def find_application(expr, function_name):
    if isinstance(expr, _FunctionExpression):
        if expr.function_info.function_name == function_name:
            return expr
        else:
            for child in expr.children:
                ret = find_application(child, function_name)
                if ret is not None:
                    return ret
    return None

def find_all_synth_fun_apps(expr):
    if not is_function_expression(expr):
        return set()
    ret = set()
    for child in expr.children:
        ret = ret | find_all_synth_fun_apps(child)
    if expr.function_info.function_kind == semantics_types.FunctionKinds.synth_function:
        ret.add(expr)
    return ret

def parent_of(expr, sub_expr):
    if not is_function_expression(expr):
        return None
    for child in expr.children:
        if child == sub_expr:
            return expr
        sub = parent_of(child, sub_expr)
        if sub is not None:
            return sub
    return None

def get_all_constants(expr):
    if is_function_expression(expr):
        ret = set()
        for child in expr.children:
            ret = ret.union(get_all_constants(child))
        return ret
    elif is_constant_expression(expr):
        return set([expr])
    elif is_formal_parameter_expression(expr):
        return set()
    elif is_variable_expression(expr):
        return set()
    else:
        raise Exception


def get_all_variables(expr):
    if is_function_expression(expr):
        ret = set()
        for child in expr.children:
            ret = ret.union(get_all_variables(child))
        return ret
    elif is_constant_expression(expr):
        return set()
    elif is_formal_parameter_expression(expr):
        return set()
    elif is_variable_expression(expr):
        return set([expr])
    else:
        raise Exception

def get_all_formal_parameters(expr):
    if is_function_expression(expr):
        ret = set()
        for child in expr.children:
            ret = ret.union(get_all_formal_parameters(child))
        return ret
    elif is_constant_expression(expr):
        return set()
    elif is_formal_parameter_expression(expr):
        return set([expr])
    elif is_variable_expression(expr):
        return set()
    else:
        raise Exception

def is_expression(obj):
    return (isinstance(obj, _VariableExpression) or
            isinstance(obj, _ConstantExpression) or
            isinstance(obj, _FormalParameterExpression) or
            isinstance(obj, _FunctionExpression))

def is_function_expression(obj):
    return isinstance(obj, _FunctionExpression)

def is_constant_expression(obj):
    return isinstance(obj, _ConstantExpression)

def is_formal_parameter_expression(obj):
    return isinstance(obj, _FormalParameterExpression)

def is_variable_expression(obj):
    return isinstance(obj, _VariableExpression)

def is_application_of(obj, func_name_or_info):
    assert is_expression(obj)
    if not isinstance(obj, _FunctionExpression):
        return False
    if func_name_or_info == obj.function_info or func_name_or_info == obj.function_info.function_name:
        return True
    return False

def _check_equivalence_under_constraint(expr1, expr2, smt_ctx, arg_vars, constraint, random):
    import z3

    expr1_smt = semantics_types.expression_to_smt(expr1, smt_ctx, arg_vars)
    expr2_smt = semantics_types.expression_to_smt(expr2, smt_ctx, arg_vars)
    if constraint is not None:
        constraint_smt = semantics_types.expression_to_smt(constraint, smt_ctx, arg_vars)
    else:
        constraint_smt = z3.BoolVal(True, ctx=smt_ctx.ctx())
    condition = z3.And(constraint_smt, (expr1_smt != expr2_smt), smt_ctx.ctx())
    if random:
        return random_sample(condition, smt_ctx.ctx(), arg_vars)
    else:
        return _z3_solve(condition, arg_vars)

def check_equivalence_under_constraint(expr1, expr2, smt_ctx, arg_vars, constraint, random=False):
    return _check_equivalence_under_constraint(expr1, expr2, smt_ctx, arg_vars, constraint, random)

def check_equivalence(expr1, expr2, smt_ctx, arg_vars, random=False):
    return _check_equivalence_under_constraint(expr1, expr2, smt_ctx, arg_vars, None, random)

def _z3_solve(z3_expr, arg_vars):
    import z3
    smt_solver = z3.Solver(ctx=z3_expr.ctx)
    smt_solver.push()
    smt_solver.add(z3_expr)
    r = smt_solver.check()
    smt_solver.pop()

    if r == z3.sat:
        point = [ smt_solver.model().evaluate(arg_var, True) for arg_var in arg_vars ]
        return point
    else:
        return None


def sample(pred_or_pred_smt, smt_ctx, arg_vars):
    if is_expression(pred_or_pred_smt):
        pred_smt = semantics_types.expression_to_smt(pred_or_pred_smt, smt_ctx, arg_vars)
    else:
        pred_smt = pred_or_pred_smt
    return _z3_solve(pred_smt, arg_vars)

# Is not really uniform random
# The purpose is to make the pattern opaque to human eye
def random_sample(pred_or_pred_smt, smt_ctx, arg_vars):
    import z3
    import random

    if len(arg_vars) != 1 or type(arg_vars[0]) != z3.BitVecRef:
        raise NotImplementedError

    arg = arg_vars[0]
    bit_vec_size = arg.size()

    positions = list(range(bit_vec_size))
    random.shuffle(positions)

    if is_expression(pred_or_pred_smt):
        pred_smt = semantics_types.expression_to_smt(pred_or_pred_smt, smt_ctx, arg_vars)
    else:
        pred_smt = pred_or_pred_smt

    orig_sample = _z3_solve(pred_smt, arg_vars)
    if orig_sample is None:
        return None

    zero = z3.BitVecVal(0, bit_vec_size, pred_smt.ctx)
    for position in positions:
        mask = z3.BitVecVal((1 << position), bit_vec_size, pred_smt.ctx)

        with_one = z3.And(pred_smt, (arg & mask == mask), pred_smt.ctx)
        with_zero = z3.And(pred_smt, (arg & mask == zero), pred_smt.ctx)

        with_one_sat = _z3_solve(with_one, arg_vars)
        with_zero_sat = _z3_solve(with_zero, arg_vars)

        assert with_one_sat is not None or with_zero_sat is not None

        if with_one_sat == None:
            pred_smt = with_zero
        elif with_zero_sat == None:
            pred_smt = with_one
        else: # Choose randomly
            pred_smt = random.choice([with_one, with_zero])

    result = _z3_solve(pred_smt, arg_vars)
    assert result is not None

    return result

def match(expr_template, expr):
    if expr_template == expr:
        return {}
    elif is_variable_expression(expr_template):
        return { expr_template:expr }
    elif (not is_function_expression(expr_template) or \
            not is_function_expression(expr) or \
            expr_template.function_info != expr.function_info):
        return None

    d = {}
    for child1, child2 in zip(expr_template.children, expr.children):
        dd = match(child1, child2)
        if dd is None:
            return None
        for v, e in dd.items():
            if v in d:
                return None
            d[v] = e
    return d

def equals(e1, e2):
    # print("1:", expression_to_string(e1))
    # print("2:", expression_to_string(e2))
    if e1.expr_kind != e2.expr_kind:
        ret = False
    else:
        kind = e1.expr_kind
        if (kind == _variable_expression):
            ret = e1.variable_info == e2.variable_info
        elif (kind == _formal_parameter_expression):
            ret = ((e1.unknown_function_info == e2.unknown_function_info) and
                    (e1.parameter_position == e2.parameter_position))
        elif (kind == _constant_expression):
            ret = (e1.value_object == e2.value_object)
        elif (kind == _function_expression):
            if e1.function_info.function_name != e2.function_info.function_name:
                ret = False
            else:
                ret = all(map(lambda ec1, ec2: equals(ec1,ec2), e1.children, e2.children))
        else:
            assert False
    # print(ret)
    return ret


def get_all_exprs(expr):
    result = set([expr])
    if is_function_expression(expr):
        for child in expr.children:
            result.update(get_all_exprs(child))
    return result

def print_expr_as_solution(expr):
    params = list(get_all_formal_parameters(expr))
    params.sort(key = lambda x: expression_to_string(x))
    fp_string = ''
    for param in params:
        fp_string = fp_string + ' ('
        fp_string = fp_string + expression_to_string(param)
        fp_string = fp_string + ' ' + get_expression_type(param).print_string() + ') '

    print('(define-fun f (%s) %s %s)' %
                    (
                        fp_string,
                        get_expression_type(expr).print_string(),
                        expression_to_string(expr)
                    ),
                    flush=True)

#
# exprs.py ends here
