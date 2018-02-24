#!/usr/bin/env python3
# lia_massager.py ---
#
# Filename: lia_utils.py
# Author: Arjun Radhakrishna
# Created: Tue May 09 2017 15:28:35 -0400
#
#
# Copyright (c) 2015, Arjun Radhakrishna, University of Pennsylvania
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

from exprs import exprs
from exprs import exprtypes
from functools import reduce
import operator

_expr_to_str = exprs.expression_to_string

class LIAExpression(object):
    def __init__(self, coeffs):
        self.coeffs = coeffs
        self.vars = set([v for v in coeffs.keys() if coeffs[v] != 0])

    def get_variables(self):
        return self.vars

    def __str__(self):
        ret = ""
        for var, val in self.coeffs.items():
            if var == 1:
                ret += "+ " + str(val)
            ret += "+ " + str(val) + "*" + exprs.expression_to_string(var)
        return ret

    def get_coefficient(self, var):
        if var in self.coeffs:
            return self.coeffs[var]
        else:
            return 0

    def set_coefficient(self, var, val):
        self.coeffs[var] = val
        if val == 0 and var in self.vars:
            self.vars.remove(var)

    def eval(self, model):
        total = 0
        for var, coeff in self.coeffs.items():
            if var == 1:
                total += coeff
            else:
                total += (coeff * model[var])
        return total

    def __add__(self, other):
        ret = {}
        for d in [ self.coeffs, other.coeffs ]:
            for var, coeff in d.items():
                ret[var] = ret.get(var, 0) + coeff
        return LIAExpression(ret)

    def __sub__(self, other):
        ret = self.coeffs.copy()
        for var, coeff in other.coeffs.items():
            ret[var] = ret.get(var, 0) - coeff
        return LIAExpression(ret)

    def __neg__(self):
        ret = { var:(-coeff) for var, coeff in self.coeffs.items() }
        return LIAExpression(ret)

    def __mul__(self, other):
        if self.is_const():
            c = self.get_const()
            d = other.coeffs
        elif other.is_const():
            c = other.get_const()
            d = self.coeffs
        else:
            raise NotImplementedError
        ret = { var:(c * coeff) for var, coeff in d.items() }
        return LIAExpression(ret)

    @staticmethod
    def from_expr(expr):  # Has to be a linear expression
        # Base case
        if exprs.is_variable_expression(expr) or exprs.is_formal_parameter_expression(expr):
            return LIAExpression({expr:1})
        elif exprs.is_constant_expression(expr):
            return LIAExpression({1:expr.value_object.value_object})

        func_name = expr.function_info.function_name
        if func_name in [ '+', 'add' ]:
            return reduce(LIAExpression.__add__, map(LIAExpression.from_expr, expr.children))
        elif func_name == 'sub' or (func_name == '-' and len(expr.children) == 2):
            return LIAExpression.from_expr(expr.children[0]) - LIAExpression.from_expr(expr.children[1])
        elif func_name in [ '*', 'mul' ]:
            return reduce(LIAExpression.__mul__, map(LIAExpression.from_expr, expr.children))
        elif func_name == '-':
            return -LIAExpression.from_expr(expr.children[0])
        else:
            # print(_expr_to_str(expr))
            raise NotImplementedError

    def is_const(self):
        is_zero = (len(self.coeffs) == 0)
        is_single_const_coeff = (len(self.coeffs) == 1 and (1 in self.coeffs))
        return is_zero or is_single_const_coeff

    def get_const(self):
        if len(self.coeffs) == 0:
            return 0
        else:
            return self.coeffs.get(1, 0)

    def get_var_coeff_pairs(self):
        return [ (var, coeff) for var, coeff in self.coeffs.items() if var != 1 ]

    def substitute(self, var, other):
        assert other.get_coefficient(var) == 0
        c = self.get_coefficient(var)
        ret = self + LIAExpression({1:c}) * other 
        ret.set_coefficient(var, 0)
        return ret

    def to_expr(self, syn_ctx):
        def term_to_expr(var, coeff):
            if var == 1:
                term = exprs.ConstantExpression(exprs.Value(coeff, exprtypes.IntType()))
            else:
                if coeff == 1:
                    term = var
                else:
                    coeff_expr = exprs.ConstantExpression(exprs.Value(coeff, exprtypes.IntType()))
                    term = syn_ctx.make_function_expr('mul', var, coeff_expr)
            return term

        terms = [ term_to_expr(var, coeff) for var, coeff in self.coeffs.items() if coeff != 0 ]

        if len(terms) == 0:
            return exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType()))
        else:
            return reduce(lambda a,b: syn_ctx.make_function_expr('+', a, b), terms)


_op_funcs = {
        '<': operator.__lt__,
        '<=': operator.__le__,
        '>': operator.__gt__,
        '>=': operator.__ge__,
        '=': operator.__eq__,
        'eq': operator.__eq__,
        'ne': operator.__ne__
        }

_op_flip = { 
        '>=':'<=',
        '>':'<',
        '<=':'>=',
        '<':'>',
        'eq':'eq',
        '=':'=',
        'ne':'ne'
        }

class LIAInequality(object):
    def __init__(self, left, op, right):
        self.left = left
        self.right = right
        self.op = op
        self.op_func = _op_funcs[op]
        assert type(self.left) == LIAExpression
        assert type(self.right) == LIAExpression

    def __str__(self):
        ret = str(self.left) + " " + self.op + " " + str(self.right)
        return ret

    def is_valid(self):
        normalized = self.left - self.right
        if not normalized.is_const():
            return False
        return self.op_func(normalized.get_const(), 0)

    def to_positive_form(self):
        normalized = self.left - self.right
        l = {}
        r = {}
        for v, c in normalized.coeffs.items():
            if c > 0:
                l[v] = c
            elif c < 0:
                r[v] = -c
            else:
                pass
        return LIAInequality(LIAExpression(l), self.op, LIAExpression(r))

    def is_equality(self):
        return self.op == 'eq' or self.op == '='

    def get_variables(self):
        return self.left.get_variables() | self.right.get_variables()

    def substitute(self, var, expr):
        l = self.left.substitute(var, expr)
        r = self.right.substitute(var, expr)
        return LIAInequality(l, self.op, r)

    def eval(self, model):
        l = self.left.eval(model)
        r = self.right.eval(model)
        # print(str(self.left), "--->", l)
        # print(str(self.right), "--->", r)
        return self.op_func(l, r)

    @staticmethod
    def from_expr(expr):
        if not exprs.is_function_expression(expr):
            raise NotImplementedError
        op = expr.function_info.function_name
        if op not in _op_funcs:
            raise NotImplementedError

        left = LIAExpression.from_expr(expr.children[0])
        right = LIAExpression.from_expr(expr.children[1])
        return LIAInequality(left, op, right)

    def get_bounds(self, var):
        # Returns (coeff, (Lower, Equality, Upper)) -- All three may be none
        # The meaning is coeff * var (>= Lower, = Eq, <= Upper)
        normalized = self.right - self.left
        op = self.op
        c = - normalized.get_coefficient(var)
        normalized.set_coefficient(var, 0)
        if c == 0:
            return (0, (None, None, None))
        if c < 0:
            normalized = - normalized
            op = _op_flip[op]
            c = -c

        # Convert > and < to >= and <=
        if op == '>':
            normalized = normalized + LIAExpression({1:1})
            op = '>='
        elif op == '<':
            normalized = normalized + LIAExpression({1:-1})
            op = '>='

        if op in [ '=', 'eq' ]:
            return (c, (None, normalized, None))
        elif op == '>=':
            return (c, (normalized, None, None))
        elif op == '<=':
            return (c, (None, None, normalized))
        else:
            raise NotImplementedError

def solve_inequalities(model, outvars, inequalities, syn_ctx):
    # print("===================")
    # for var, val in model.items():
     #    print(exprs.expression_to_string(var) + " = " + str(val))
    if len(outvars) == 1:
        return solve_inequalities_one_outvar(model, outvars[0], inequalities, syn_ctx)

    # raise NotImplementedError
    # Check if we can get away with factoring out one outvar
    for ineq in inequalities:
        if not ineq.is_equality():
            continue
        for outvar in outvars:
            (coeff, (_, eq_lia_expr, _)) = ineq.get_bounds(outvar)
            if coeff == 1:
                eq_expr = eq_lia_expr.to_expr(syn_ctx)
                rest_ineqs = [ e.substitute(outvar, eq_lia_expr) for e in inequalities if e != ineq ]
                rest_outvars = [ o for o in outvars if o != outvar ]
                rest_sol = solve_inequalities(model, rest_outvars, rest_ineqs, syn_ctx)
                sols = list(zip(rest_outvars, rest_sol))
                while True:
                    tp = exprs.substitute_all(eq_expr, sols)
                    if tp == eq_expr:
                        break
                    eq_expr = tp
                sols_dict = dict(sols)
                sols_dict[outvar] = eq_expr
                # print( [ (exprs.expression_to_string(o), exprs.expression_to_string(sols_dict[o])) for o in outvars ])
                # print("===================")
                return [ sols_dict[o] for o in outvars ]

    # Otherwise, just pick the first outvar
    outvar = outvars[0]
    [t] = solve_inequalities_one_outvar(model, outvar, inequalities, syn_ctx)
    lia_t = LIAExpression.from_expr(t)
    rest_ineqs = [ e.substitute(outvar, lia_t) for e in inequalities if e != ineq ]
    rest_outvars = [ o for o in outvars if o != outvar ]
    rest_sol = solve_inequalities(model, rest_outvars, rest_ineqs, syn_ctx)
    sols = list(zip(rest_outvars, rest_sol))
    while True:
        tp = exprs.substitute_all(t, sols)
        if tp == t:
            break
        t = tp
    sols_dict = dict(sols)
    sols_dict[outvar] = t
    # print( [ (exprs.expression_to_string(o), exprs.expression_to_string(sols_dict[o])) for o in outvars ])
    # print("===================")
    return [ sols_dict[o] for o in outvars ]

def solve_inequalities_one_outvar(model, outvar, inequalities, syn_ctx):
    if len(inequalities) == 0:
        return [ exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType())) ]

    bounds = [ ineq.get_bounds(outvar) for ineq in inequalities ]
    eqs = [ (c, eq_exp) for (c, (_, eq_exp, _)) in bounds if eq_exp is not None ]
    lbs = [ (c, lb_exp) for (c, (lb_exp, _, _)) in bounds if lb_exp is not None ]
    ubs = [ (c, ub_exp) for (c, (_, _, ub_exp)) in bounds if ub_exp is not None ]

    # Equalities
    if len(eqs) > 0:
        rhs = eqs[0][1].to_expr(syn_ctx)
        if eqs[0][0] == 1:
            return [ rhs ]
        else:
            return [ syn_ctx.make_function_expr('div', rhs,
                    exprs.ConstantExpression(exprs.Value(eqs[0][0], exprtypes.IntType()))) ]

    # Upper bounds
    if len(ubs) > 0:
        tightest_ub = min(ubs, key=lambda a: a[1].eval(model) / a[0])
        if tightest_ub is not None:
            coeff = tighest_ub[0]
            rhs = tightest_ub[1].to_expr(syn_ctx)
            if coeff == 1:
                return [ rhs ]
            else:
                return [ syn_ctx.make_function_expr('div', rhs,
                    exprs.ConstantExpression(exprs.Value(coeff, exprtypes.IntType()))) ]

    # Lower bounds
    if len(lbs) > 0:
        tightest_lb = max(lbs, key=lambda a: a[1].eval(model) / a[0])
        if tightest_lb is not None:
            coeff = tightest_lb[0]
            rhs = tightest_lb[1].to_expr(syn_ctx)
            if coeff == 1:
                return [ rhs ]
            return [ syn_ctx.make_function_expr('div',
                    syn_ctx.make_function_expr('add', rhs, exprs.ConstantExpression(exprs.Value(1, exprtypes.IntType()))),
                    exprs.ConstantExpression(exprs.Value(coeff, exprtypes.IntType()))) ]

    return exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType()))

