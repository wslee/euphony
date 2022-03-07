#!/usr/bin/env python3
# lia_massager.py ---
#
# Filename: lia_massager.py
# Author: Arjun Radhakrishna
# Created: Wed, 01 Jun 2016 11:27:20 -0400
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
from verifiers import verifiers
import eusolver
from termsolvers import termsolvers_lia
from exprs import exprtypes
from utils.lia_utils import LIAExpression, LIAInequality
from utils import utils
from utils import z3smt
import semantics
from eusolver import BitSet

def simplify(syn_ctx, expr):
    e0 = expr
    while True:
        e0 = simplify_basic(syn_ctx, e0)
        e1 = simplify_modus_ponens(syn_ctx, e0)
        if not exprs.equals(e0, e1):
            e0 = e1
            continue
        break
    return e1

def simplify_basic(syn_ctx, expr):
    if not exprs.is_function_expression(expr):
        return expr
    func_name = expr.function_info.function_name

    if func_name not in [ 'and', 'or', 'not', 'ite' ]:
        return expr

    true = exprs.ConstantExpression(exprs.Value(True, exprtypes.BoolType()))
    false = exprs.ConstantExpression(exprs.Value(False, exprtypes.BoolType()))
    if func_name == 'and':
        cond_children = [ simplify_basic(syn_ctx, c) for c in expr.children ]
        cond_true_children = [ c for c in cond_children if c != true ]
        cond_false_children = [ c for c in cond_children if c == false ]
        if len(cond_false_children) > 0:
            return false
        elif len(cond_true_children) == 0:
            return true
        elif len(cond_true_children) == 1:
            return cond_true_children[0]
        else:
            return syn_ctx.make_function_expr('and', *cond_true_children)
    elif func_name == 'or':
        cond_children = [ simplify_basic(syn_ctx, c) for c in expr.children ]
        cond_true_children = [ c for c in cond_children if c == true ]
        cond_false_children = [ c for c in cond_children if c != false ]
        if len(cond_true_children) > 0:
            return true
        elif len(cond_false_children) == 0:
            return false
        elif len(cond_false_children) == 1:
            return cond_false_children[0]
        else:
            return syn_ctx.make_function_expr('or', *cond_false_children)
    elif func_name == 'not':
        child = simplify_basic(syn_ctx, expr.children[0])
        if child == true:
            return false
        elif child == false:
            return true
        else:
            return expr
    else: #ITE
        cond = simplify_basic(syn_ctx, expr.children[0])
        if cond == true:
            return simplify_basic(syn_ctx, expr.children[1])
        elif cond == false:
            return simplify_basic(syn_ctx, expr.children[2])
        else:
            return syn_ctx.make_function_expr('ite', cond, 
                    simplify_basic(syn_ctx, expr.children[1]),
                    simplify_basic(syn_ctx, expr.children[2]))

def make_linear_term(syn_ctx, v, c, consts, neg, constant_multiplication):
    if c == 1:
        return v
    if c in consts and constant_multiplication:
        return syn_ctx.make_function_expr('*', v, exprs.ConstantExpression(exprs.Value(c, exprtypes.IntType())))
    if neg and 0 in consts and (-c) in consts and constant_multiplication:
        return syn_ctx.make_function_expr('-', exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType())),
                syn_ctx.make_function_expr('*', v, exprs.ConstantExpression(exprs.Value(-c, exprtypes.IntType()))))
    if neg and c < 0:
        return syn_ctx.make_function_expr('-', exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType())),
                make_linear_term(syn_ctx, v, -c, consts, neg, constant_multiplication))
    if c > 0:
        ret = v
        for x in range(1, c):
            ret = syn_ctx.make_function_expr('+', v, ret)
        return ret
    return None

def make_constant(syn_ctx, c, consts, neg):
    if c in consts:
        return exprs.ConstantExpression(exprs.Value(c, exprtypes.IntType()))
    if -c in consts and neg and 0 in consts:
        return syn_ctx.make_function_expr('-', exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType())),
                exprs.ConstantExpression(exprs.Value(-c, exprtypes.IntType())))
    if c > 0:
        ret = exprs.ConstantExpression(exprs.Value(1, exprtypes.IntType()))
        for x in range(1, c):
            ret = syn_ctx.make_function_expr('+', ret, exprs.ConstantExpression(exprs.Value(1, exprtypes.IntType())))
        return ret
    elif c < 0 and neg and 0 in consts:
        return syn_ctx.make_function_expr('-', exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType())), make_constant(syn_ctx, -c, consts, neg))

    return None

def get_terms(e):
    if not exprs.is_application_of(e, 'ite'):
        return [e]
    else:
        ret = []
        ret.extend(get_terms(e.children[1]))
        ret.extend(get_terms(e.children[2]))
        return ret

def get_preds(e):
    if not exprs.is_application_of(e, 'ite'):
        return []
    else:
        ret = [ e.children[0] ]
        ret.extend(get_preds(e.children[1]))
        ret.extend(get_preds(e.children[2]))
        return ret

def decompose_boolean_combination(e):
    if exprs.is_application_of(e, 'and') or exprs.is_application_of(e, 'or'):
        ret = []
        for child in e.children:
            ret.extend(decompose_boolean_combination(child))
        return ret 
    elif exprs.is_application_of(e, 'not'): 
        return decompose_boolean_combination(e.children[0])
    else:
        return [e]

def get_atomic_preds(e):
    preds = get_preds(e)
    aps = []
    for p in preds:
        aps.extend(decompose_boolean_combination(p))
    return aps


def rewrite_term(syn_ctx, term, neg, consts, constant_multiplication):
    lia_term = LIAExpression.from_expr(term)
    return rewrite_lia_term(syn_ctx, lia_term, neg, consts, constant_multiplication)

def rewrite_lia_term(syn_ctx, lia_term, neg, consts, constant_multiplication):
    c = lia_term.get_const()
    linear_terms = [ make_linear_term(syn_ctx, v, coeff, consts, neg, constant_multiplication)
            for (v, coeff) in lia_term.get_var_coeff_pairs() ]

    if c != 0:
        new_term = make_constant(syn_ctx, c, consts, neg)
        if new_term is None:
            return None
    elif len(linear_terms) > 0:
        new_term = linear_terms[0]
        linear_terms = linear_terms[1:]
    else:
        if 0 in consts:
            return exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType()))
        else:
            return None
    for nt in linear_terms:
        new_term = syn_ctx.make_function_expr('+', nt, new_term)
    return new_term

def rewrite_pred(syn_ctx, pred, boolean_combs, comparators, neg, consts, constant_multiplication):
    liaineq = LIAInequality.from_expr(pred).to_positive_form()

    if liaineq.is_valid():
        if len(consts) > 0:
            return exprs.ConstantExpression(exprs.Value(True, exprtypes.BoolType()))
        else:
            return None

    (left, op, right) = (liaineq.left, liaineq.op, liaineq.right)

    negate = { '<':'>=', '>':'<=', '>=':'<', '<=':'>' }
    flip = { '<':'>', '>':'<', '>=':'<=', '<=':'>=' }
    addNot = False
    if op not in comparators:
        if op in negate and negate[op] in comparators:
            (left, op, right) = (left, negate[op], right)
            addNot = True
        elif op in flip and flip[op] in comparators:
            (left, op, right) = (right, flip[op], left)
        elif op == '=' and ('<=' in comparators or '>=' in comparators):
                new_op = '<=' if '<=' in comparators else '>='
                p1 = syn_ctx.make_function_expr(new_op, pred.children[0], pred.children[1])
                p2 = syn_ctx.make_function_expr(new_op, pred.children[1], pred.children[0])
                return syn_ctx.make_function_expr('and', 
                        rewrite_pred(syn_ctx, p1, boolean_combs, comparators, neg, consts, constant_multiplication),
                        rewrite_pred(syn_ctx, p2, boolean_combs, comparators, neg, consts, constant_multiplication))
        else:
            return None

    liaineq = LIAInequality(left, op, right).to_positive_form()
    left_term = rewrite_lia_term(syn_ctx, liaineq.left, neg, consts, constant_multiplication)
    right_term = rewrite_lia_term(syn_ctx, liaineq.right, neg, consts, constant_multiplication)
    if left_term is None or right_term is None:
        return None

    ret = syn_ctx.make_function_expr(liaineq.op, left_term, right_term)
    if addNot:
        ret = syn_ctx.make_function_expr('not', ret)
    return ret

def verify(expr, boolean_combs, comparators, consts, negatives, constant_multiplication, div, mod):
    if not constant_multiplication and exprs.find_application(expr, '*') is not None:
        return False
    if not negatives and exprs.find_application(expr, '-') is not None:
        return False
    used_consts = set([ e.value_object.value_object for e in exprs.get_all_constants(expr) ])
    if not used_consts.issubset(consts):
        return False
    if not boolean_combs and ( exprs.find_application(expr, 'and') is not None or
            exprs.find_application(expr, 'or') is not None or
            exprs.find_application(expr, 'not') is not None):
        return False
    used_comparators = set()
    for c in [ '<', '<=', '=', 'ne', '>', '>=' ]:
        if exprs.find_application(expr, c) is not None:
            used_comparators.add(c)
    if not used_comparators.issubset(comparators):
        return False
    return True

def simplify_modus_ponens(syn_ctx, expr):
    if exprs.is_application_of(expr, 'ite'):
        [cond,e_then,e_else] = expr.children
        rcond = apply_modus_ponens(syn_ctx, cond)
        rthen = simplify_modus_ponens(syn_ctx, e_then)
        relse = simplify_modus_ponens(syn_ctx, e_else)
        ret = syn_ctx.make_function_expr('ite', rcond, rthen, relse)
        return ret
    else:
        return expr

def is_and_or(e):
    return (
            exprs.is_application_of(e, 'and') or
            exprs.is_application_of(e, 'or')
            )

def apply_modus_ponens(syn_ctx, pred):
    if exprs.is_application_of(pred, 'and'):
        children = pred.children
        new_children = [ c for c in children ]
        for child in children:
            if is_and_or(child):
                continue
            # Is atomic
            to_remove = []
            for nc in new_children:
                if exprs.is_application_of(nc, 'or') and any(map(lambda e: exprs.equals(e, child), nc.children)):
                    to_remove.append(nc)
                else:
                    pass
            new_children = [ nc for nc in new_children if nc not in to_remove ]
        if len(new_children) == 1:
            return new_children[0]
        else:
            return syn_ctx.make_function_expr('and', *new_children)
    else:
        return pred

def rewrite_boolean_combs(syn_ctx, sol):
    import functools

    if not exprs.is_application_of(sol, 'ite'):
        return sol

    cond = sol.children[0]
    child1 = rewrite_boolean_combs(syn_ctx, sol.children[1])
    child2 = rewrite_boolean_combs(syn_ctx, sol.children[2])

    if not exprs.is_function_expression(cond):
        return syn_ctx.make_function_expr('ite', cond, child1, child2)
    fun = cond.function_info.function_name
    if fun not in [ 'and', 'or', 'not' ]:
        return syn_ctx.make_function_expr('ite', cond, child1, child2)

    if fun == 'not':
        return syn_ctx.make_function_expr('ite', cond.children[0], child2, child1)
    elif len(cond.children) == 1:
        return syn_ctx.make_function_expr('ite', cond.children[0], child1, child2)

    if fun == 'or':
        init = child2
        combine = lambda a, b: syn_ctx.make_function_expr('ite', b, child1, a)
        cond_children = cond.children
        if any([ exprs.find_application(c, 'and') is not None or exprs.find_application(c, 'or') is not None for c in cond_children ]):
            ret = rewrite_boolean_combs(syn_ctx, functools.reduce(combine, cond.children, init))
        else:
            ret = functools.reduce(combine, cond.children, init)
        return ret
    else:
        init = child1
        combine = lambda a, b: syn_ctx.make_function_expr('ite', b, a, child2)
        cond_children = cond.children
        if any([ exprs.find_application(c, 'and') is not None or exprs.find_application(c, 'or') is not None for c in cond_children ]):
            ret = rewrite_boolean_combs(syn_ctx, functools.reduce(combine, cond.children, init))
        else:
            ret = functools.reduce(combine, cond.children, init)
        return ret

def rewrite_arbitrary_arity_and_or(syn_ctx, sol):
    import functools
    apps = exprs.find_all_applications(sol, 'and')
    for app in apps:
        if len(app.children) == 2:
            continue 
        elif len(app.children) == 1:
            new_app = syn_ctx.make_function_expr('and', app.children[0], app.children[0]) 
        else:
            new_app = functools.reduce(lambda a, b: syn_ctx.make_function_expr('and', a, b), app.children)
        sol = exprs.substitute(sol, app, new_app)

    new_apps = exprs.find_all_applications(sol, 'and')
    assert all([ len(new_app.children) == 2 for new_app in new_apps ])

    apps = exprs.find_all_applications(sol, 'or')
    for app in apps:
        if len(app.children) == 2:
            continue 
        elif len(app.children) == 1:
            new_app = syn_ctx.make_function_expr('or', app.children[0], app.children[0]) 
        else:
            new_app = functools.reduce(lambda a, b: syn_ctx.make_function_expr('or', a, b), app.children)
        sol = exprs.substitute(sol, app, new_app)

    new_apps = exprs.find_all_applications(sol, 'or')
    assert all([ len(new_app.children) == 2 for new_app in new_apps ])

    return sol
        

        

def massage_full_lia_solution(syn_ctx, synth_funs, final_solution, massaging):
    # for sf in final_solution:
    #   print(exprs.expression_to_string(sf))
    try:
        new_final_solution = []
        for sf, sol in zip(synth_funs, final_solution):
            if sf not in massaging:
                new_final_solution.append(sol)
                continue

            (boolean_combs, comparators, consts, negatives, constant_multiplication, div, mod) = massaging[sf]

            # Don't try to rewrite div's and mod's
            # It is futile
            if not div and exprs.find_application(sol, 'div') != None:
                return None
            if not mod and exprs.find_application(sol, 'mod') != None:
                return None

            terms = get_terms(sol)
            for term in terms:
                termp = rewrite_term(syn_ctx, term, negatives, consts, constant_multiplication)
                if termp is None:
                    return None
                sol = exprs.substitute(sol, term, termp)

            aps = get_atomic_preds(sol)
            for ap in aps:
                new_ap = rewrite_pred(syn_ctx, ap, boolean_combs, comparators, negatives, consts, constant_multiplication)
                if new_ap is None:
                    # print(exprs.expression_to_string(ap))
                    return None
                sol = exprs.substitute(sol, ap, new_ap)

            sol = simplify(syn_ctx, sol)

            if not boolean_combs:
                # print(exprs.expression_to_string(sol))
                # sol = rewrite_boolean_combs(syn_ctx, sol)
                sol = dt_rewrite_boolean_combs(syn_ctx, sol, sf)
            else:
                sol = rewrite_arbitrary_arity_and_or(syn_ctx, sol)

            if not \
                    verify(sol, boolean_combs, comparators, consts, negatives, constant_multiplication, div, mod):
                        return None

            new_final_solution.append(sol)

        return new_final_solution
    except:
        raise
        # return None

# Assumes boolean functions are in terms of formal parameters
def dt_rewrite_boolean_combs(syn_ctx, sol, synth_fun):
    orig_sol = sol
    smt_ctx = z3smt.Z3SMTContext()
    vs = exprs.get_all_variables(sol)
    dummy_vars = [
            exprs.VariableExpression(
                exprs.VariableInfo(
                    v.variable_info.variable_type,
                    "D" + v.variable_info.variable_name,
                    i)) for (i, v) in enumerate(vs) ]
    argvars = [ semantics.semantics_types.expression_to_smt(v, smt_ctx) 
            for v in dummy_vars ]
    sol = exprs.substitute_all(sol, list(zip(vs, dummy_vars)))
    preds = get_atomic_preds(sol)
    terms = get_terms(sol)

    points = []

    from exprs import evaluation
    eval_ctx = evaluation.EvaluationContext()
    def add_point(point, pred_sig_list, term_sig_list):
        points.append(point)
        eval_ctx.set_valuation_map(point)
        solv = evaluation.evaluate_expression_raw(sol, eval_ctx)
        new_pred_sig_list = [
            utils.bitset_extend(sig, evaluation.evaluate_expression_raw(pred, eval_ctx))
            for (sig, pred) in zip(pred_sig_list, preds)
            ]
        new_term_sig_list = [
            utils.bitset_extend(sig, solv == evaluation.evaluate_expression_raw(term, eval_ctx))
            for (sig, term) in zip(term_sig_list, terms)
            ]
        return (new_pred_sig_list, new_term_sig_list)

    pred_sig_list = [ BitSet(0) for p in preds ]
    term_sig_list = [ BitSet(0) for t in terms ]

    expr = terms[0]
    fsol = None
    while True:
        z3point = exprs.sample(syn_ctx.make_function_expr('ne', expr, sol), smt_ctx, argvars)
        if z3point is None:
            fsol = expr
            break
        else:
            point = list(map(lambda v, d: z3smt.z3value_to_value(v, d.variable_info), z3point, dummy_vars))
            (pred_sig_list, term_sig_list) = add_point(point, pred_sig_list, term_sig_list)
            dt = eusolver.eus_learn_decision_tree_for_ml_data(pred_sig_list, term_sig_list)
            expr = verifiers.naive_dt_to_expr(syn_ctx, dt, preds, terms)
    sol = exprs.substitute_all(fsol, list(zip(dummy_vars, vs)))
    return sol

