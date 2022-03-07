#!/usr/bin/env python3
# verifiers.py ---
#
# Filename: verifiers.py
# Author: Arjun Radhakrishna
# Created: Mon, 06 Jun 2016 14:51:36 -0400
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

from exprs import exprs
from utils import z3smt
from exprs import exprtypes
import z3
from semantics import semantics_types
from utils import basetypes
from exprs import evaluation
from utils.bitvectors import BitVector
import options

_expr_to_str = exprs.expression_to_string
_expr_to_smt = semantics_types.expression_to_smt
_is_expr = exprs.is_expression
_get_expr_with_id = exprs.get_expr_with_id

def model_to_point(model, var_smt_expr_list, var_info_list):
    num_vars = len(var_smt_expr_list)
    point = [None] * num_vars
    for i in range(num_vars):
        eval_value = model.evaluate(var_smt_expr_list[i], True)
        point[i] = z3smt.z3value_to_value(eval_value, var_info_list[i])
    return tuple(point)

def _decision_tree_to_guard_term_list_internal(decision_tree, pred_list, term_list,
                                               syn_ctx, retval, guard_stack):
    if (decision_tree.is_leaf()):
        retval.append((syn_ctx.make_ac_function_expr('and', *guard_stack),
                       [term_list[x] for x in decision_tree.get_all_label_ids()]))
    else:
        # split node
        attr_id = decision_tree.get_split_attribute_id()
        guard_stack.append(pred_list[attr_id])
        _decision_tree_to_guard_term_list_internal(decision_tree.get_positive_child(),
                                                   pred_list, term_list, syn_ctx,
                                                   retval, guard_stack)
        guard_stack.pop()
        guard_stack.append(syn_ctx.make_function_expr('not', pred_list[attr_id]))
        _decision_tree_to_guard_term_list_internal(decision_tree.get_negative_child(),
                                                   pred_list, term_list, syn_ctx,
                                                   retval, guard_stack)
        guard_stack.pop()

# The leaves of the decision trees are listed left to right
def decision_tree_to_guard_term_list(decision_tree, pred_list, term_list, syn_ctx):
    retval = []
    _decision_tree_to_guard_term_list_internal(decision_tree, pred_list,
                                               term_list, syn_ctx, retval, [])
    return retval

def _decision_tree_to_expr_internal(decision_tree, pred_list, syn_ctx, selected_leaf_terms):
    if (decision_tree.is_leaf()):
        return selected_leaf_terms.pop(0)
    else:
        if_term = _decision_tree_to_expr_internal(decision_tree.get_positive_child(),
                                                  pred_list, syn_ctx, selected_leaf_terms)
        else_term = _decision_tree_to_expr_internal(decision_tree.get_negative_child(),
                                                    pred_list, syn_ctx, selected_leaf_terms)
        return syn_ctx.make_function_expr('ite', pred_list[decision_tree.get_split_attribute_id()],
                                          if_term, else_term)

# We use the fact that the guard_term_list lists leaves left to right
def decision_tree_to_expr(decision_tree, pred_list, syn_ctx, selected_leaf_terms):
    return _decision_tree_to_expr_internal(decision_tree, pred_list, syn_ctx, selected_leaf_terms)

def naive_dt_to_expr(syn_ctx, dt, preds, terms):
    if dt.is_leaf():
        for tid in dt.get_all_label_ids():
            return terms[tid]
    else:
        pred_id = dt.get_split_attribute_id()
        pred = preds[pred_id]
        thene = naive_dt_to_expr(syn_ctx, dt.get_positive_child(), preds, terms)
        elsee = naive_dt_to_expr(syn_ctx, dt.get_negative_child(), preds, terms)
        return syn_ctx.make_function_expr('ite', pred, thene, elsee)


class VerifierBase(object):
    def __init__(self):
        pass

    def verify(self, unification):
        raise basetypes.AbstractMethodError('VerifierBase.verify()')

    def verify_term_solve(self, terms):
        raise basetypes.AbstractMethodError('VerifierBase.verify_term_solve()')

    def _default_verify(self, unification):
        type, expr_object = unification
        if type == "TERM":
            sol_or_cexs = self._verify_expr(expr_object)
        elif type == "DT_TUPLE":
            (term_list, term_sig_list, pred_list, pred_sig_list, dt) = expr_object
            guard_term_list = decision_tree_to_guard_term_list(dt, pred_list,
                                                               term_list,
                                                               self.syn_ctx)
            sol_or_cexs = self._verify_guard_term_list(guard_term_list, expr_object)
        else:
            raise Exception('Unexpected unification type: %s', type)
        return sol_or_cexs

class MultiPointVerifier(VerifierBase):
    def __init__(self, syn_ctx, spec):
        self.syn_ctx = syn_ctx
        self.spec = spec

        self.canon_spec = spec.get_canonical_specification()
        self.neg_canon_spec = syn_ctx.make_function_expr('not', self.canon_spec)
        self.synth_funs = syn_ctx.get_synth_funs()

        self.smt_ctx = z3smt.Z3SMTContext()
        self.smt_solver = self.smt_ctx.make_solver()
        self.var_info_list = spec.get_point_variables()

        var_expr_list = [exprs.VariableExpression(x) for x in self.var_info_list]
        self.var_smt_expr_list = [_expr_to_smt(x, self.smt_ctx) 
                for x in var_expr_list]

    def _verify_expr(self, term):
        smt_ctx = self.smt_ctx
        smt_solver = self.smt_solver

        if len(self.synth_funs) == 1:
            smt_ctx.set_interpretation(self.synth_funs[0], term)
        else:
            assert exprs.is_application_of(term, ',')
            for f, t in zip(self.synth_funs, term.children):
                smt_ctx.set_interpretation(f, t)
        # print(_expr_to_str(self.neg_canon_spec))
        full_constraint = _expr_to_smt(self.neg_canon_spec, smt_ctx)

        smt_solver.push()
        smt_solver.add(full_constraint)
        r = smt_solver.check()
        smt_solver.pop()

        if (r == z3.sat):
            cex_point = model_to_point(smt_solver.model(),
                                       self.var_smt_expr_list,
                                       self.var_info_list)
            return [cex_point]
        else:
            return term

    def verify(self, unification):
        type, expr_object = unification
        if type == "TERM":
            sol_or_cexs = self._verify_expr(expr_object)
        else:
            raise Exception('Unexpected unification type: %s', type)
        return sol_or_cexs

class StdVerifier(VerifierBase):
    def __init__(self, syn_ctx, spec):
        self.syn_ctx = syn_ctx
        self.spec = spec
        self.synth_funs = syn_ctx.get_synth_funs()

        self.smt_ctx = z3smt.Z3SMTContext()
        self.smt_solver = self.smt_ctx.make_solver()

        # This var_info_list is the order of variables in cex points
        self.var_info_list = spec.get_point_variables()
        var_expr_list = [exprs.VariableExpression(x) for x in self.var_info_list]
        self.var_smt_expr_list = [_expr_to_smt(x, self.smt_ctx) for x in var_expr_list]
        
        self.intro_vars = spec.get_intro_vars()
        self.smt_intro_vars = [_expr_to_smt(x, self.smt_ctx) for x in self.intro_vars]

        fun_apps = [ syn_ctx.make_function_expr(f, *self.intro_vars) for f in self.synth_funs ]
        fun_app_subst_vars = [ syn_ctx.make_variable_expr(f.range_type, '__output__' + f.function_name) for f in self.synth_funs ]
        self.outvar_cnstr = syn_ctx.make_function_expr('and', *[ 
            syn_ctx.make_function_expr('eq', v, a) for (v, a) in zip(fun_app_subst_vars, fun_apps) ])
        self.canon_spec = spec.get_canonical_specification()
        canon_spec_with_outvar = exprs.substitute_all(self.canon_spec, list(zip(fun_apps, fun_app_subst_vars)))
        neg_canon_spec_with_outvar = syn_ctx.make_function_expr('not', canon_spec_with_outvar)
        self.frozen_smt_cnstr = _expr_to_smt(neg_canon_spec_with_outvar, self.smt_ctx)
        self.smt_solver.push()
        self.smt_solver.add(self.frozen_smt_cnstr)

    def _verify_expr(self, term):
        smt_ctx = self.smt_ctx
        smt_solver = self.smt_solver

        if len(self.synth_funs) == 1:
            smt_ctx.set_interpretation(self.synth_funs[0], term)
        else:
            assert exprs.is_application_of(term, ',')
            for f, t in zip(self.synth_funs, term.children):
                smt_ctx.set_interpretation(f, t)
        eq_cnstr = _expr_to_smt(self.outvar_cnstr, smt_ctx)
        smt_solver.push()
        smt_solver.add(eq_cnstr)
        # print("1:", exprs.expression_to_string(self.canon_spec))
        # print("2:", smt_solver)
        r = smt_solver.check()
        # print("3:", smt_solver.model())
        smt_solver.pop()

        if (r == z3.sat):
            cex_point = model_to_point(smt_solver.model(),
                                       self.var_smt_expr_list,
                                       self.var_info_list)
            return [cex_point]
        else:
            return term

    def _verify_guard_term_list(self, guard_term_list, dt_tuple):
        smt_ctx = self.smt_ctx
        smt_solver = self.smt_solver
        intro_vars = self.smt_intro_vars
        cex_points = []
        selected_leaf_terms = []

        at_least_one_branch_failed = False
        for (pred, term_list) in guard_term_list:
            smt_solver.push()
            smt_pred = _expr_to_smt(pred, smt_ctx, intro_vars)
            # print('SMT guard')
            # print(smt_pred)
            smt_solver.add(smt_pred)
            all_terms_failed = True
            for term in term_list:
                # print('Verifying term')
                # print(_expr_to_str(term))
                # print('with guard')
                # print(_expr_to_str(pred))
                if len(self.synth_funs) == 1:
                    smt_ctx.set_interpretation(self.synth_funs[0], term)
                else:
                    assert exprs.is_application_of(term, ',')
                    for f, t in zip(self.synth_funs, term.children):
                        smt_ctx.set_interpretation(f, t)
                eq_cnstr = _expr_to_smt(self.outvar_cnstr, smt_ctx);
                # print('SMT constraint')
                # print(eq_cnstr)
                smt_solver.push()
                smt_solver.add(eq_cnstr)
                r = smt_solver.check()
                smt_solver.pop()
                if (r == z3.sat):
                    cex_points.append(model_to_point(smt_solver.model(),
                                                     self.var_smt_expr_list,
                                                     self.var_info_list))
                else:
                    all_terms_failed = False
                    selected_leaf_terms.append(term)
                    break

            if (all_terms_failed):
                at_least_one_branch_failed = True
            smt_solver.pop()

        if (at_least_one_branch_failed):
            retval = list(set(cex_points))
            retval.sort()
            return retval
        else:
            (term_list, term_sig_list, pred_list, pred_sig_list, dt) = dt_tuple
            e = decision_tree_to_expr(dt, pred_list, self.syn_ctx, selected_leaf_terms)
            return e

    def verify(self, unification):
        return self._default_verify(unification)

    def verify_term_solve(self, terms):
        smt_ctx = self.smt_ctx
        smt_solver = self.smt_solver
        smt_solver.pop()

        eq_cnstrs = []
        for term in terms:
            if len(self.synth_funs) == 1:
                smt_ctx.set_interpretation(self.synth_funs[0], term)
            else:
                assert exprs.is_application_of(term, ',')
                for f, t in zip(self.synth_funs, term.children):
                    smt_ctx.set_interpretation(f, t)
            eq_cnstrs.append(_expr_to_smt(self.canon_spec, smt_ctx))
        eq_cnstr = z3.And(*[ z3.Not(ec) for ec in eq_cnstrs ], eq_cnstrs[0].ctx)

        # print("----------")
        # print(eq_cnstr)

        smt_solver.push()
        smt_solver.add(eq_cnstr)
        r = smt_solver.check()

        # print(smt_solver)
        # print(smt_solver.model())
        # print("----------")
        smt_solver.pop()

        smt_solver.push()
        smt_solver.add(self.frozen_smt_cnstr)

        if (r == z3.sat):
            cex_point = model_to_point(smt_solver.model(),
                                       self.var_smt_expr_list,
                                       self.var_info_list)
            return [cex_point]
        else:
            return None


class PBEVerifier(VerifierBase):
    def __init__(self, syn_ctx, spec):
        self.spec = spec
        self.valuations = self.spec.valuations
        self.syn_ctx = syn_ctx
        self.eval_ctx = self.spec.eval_ctx 

    def _verify_expr(self, term):
        # print("verify term")
        # print(exprs.expression_to_string(term))
        eval_ctx = self.eval_ctx
        for point, value in self.valuations.items():
            eval_ctx.set_valuation_map(point)
            try:
                result = evaluation.evaluate_expression_raw(term, eval_ctx)
                if result != value:
                    if options.allex:
                        return [point for point, value in self.valuations.items()]
                    else:
                        return [point]
            except:
                continue

        return term

    def _verify_guard_term_list(self, guard_term_list, dt_tuple):
        eval_ctx = self.eval_ctx
        cex_points = []
        selected_leaf_terms = []

        at_least_one_branch_failed = False

        for (pred, term_list) in guard_term_list:
            good_terms = term_list.copy()

            for point, value in self.spec.valuations.items():
                eval_ctx.set_valuation_map(point)
                try:
                    if not evaluation.evaluate_expression_raw(pred, eval_ctx):
                        continue

                    next_good_terms = []
                    for term in good_terms:
                        curr_value = evaluation.evaluate_expression_raw(term, eval_ctx)
                        if curr_value == value:
                            next_good_terms.append(term)
                    good_terms = next_good_terms

                    if len(good_terms) == 0:
                        at_least_one_branch_failed = True
                        cex_points.append(point)
                        break
                except:
                    continue

            if len(good_terms) > 0:
                selected_leaf_terms.append(good_terms[0])


        if at_least_one_branch_failed:
            retval = list(set(cex_points))
            retval.sort()
            return retval
        else:
            (term_list, term_sig_list, pred_list, pred_sig_list, dt) = dt_tuple
            e = decision_tree_to_expr(dt, pred_list, self.syn_ctx, selected_leaf_terms)
            return e

    def verify(self, unification):
        return self._default_verify(unification)

    def verify_term_solve(self, terms):
        eval_ctx = self.eval_ctx
        for point, value in self.valuations.items():
            eval_ctx.set_valuation_map(point)
            found_one = False
            for term in terms:
                try:
                    result = evaluation.evaluate_expression_raw(term, eval_ctx)
                    if result == value:
                        found_one = True
                except:
                    continue
            if not found_one:
                return [point]
        return None
