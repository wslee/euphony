#!/usr/bin/env python3
# unifiers_lia.py ---
#
# Filename: unifiers_lia.py
# Author: Arjun Radhakrishna
# Created: Mon, 06 Jun 2016 19:41:46 -0400
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

from eusolver import BitSet
from semantics import semantics_core
from unifiers.unifiers import UnifierInterface
from exprs import evaluation
from exprs import exprs
from exprs import exprtypes
from utils.lia_utils import LIAInequality

_expr_to_str = exprs.expression_to_string

_true_expr = exprs.ConstantExpression(exprs.Value(True, exprtypes.BoolType()))
_false_expr = exprs.ConstantExpression(exprs.Value(False, exprtypes.BoolType()))

def simplify_inequality(inequality):
    if LIAInequality.from_expr(inequality).is_valid():
        return _true_expr
    return inequality

def _filter_to_intro_vars(clauses, intro_vars):
    only_intro_var_clauses = []
    for clause in clauses:
        new_clause = []
        for disjunct in clause:
            variables = exprs.get_all_variables(disjunct)
            for v in variables:
                if v not in intro_vars:
                    break
            else:
                new_clause.append(simplify_inequality(disjunct))
        only_intro_var_clauses.append(new_clause)
    return only_intro_var_clauses

def _clauses_to_expr(syn_ctx, clauses):
    clause_exprs = []
    for clause in clauses:
        clause_expr_children = []
        for disjunct in clause:
            if disjunct == _true_expr:
                clause_expr_children = [_true_expr]
                break
            elif disjunct != _false_expr:
                clause_expr_children.append(simplify_inequality(disjunct))

        if len(clause_expr_children) > 1:
            clause_exprs.append(syn_ctx.make_function_expr('or', *clause_expr_children))
        elif len(clause_expr_children) == 0:
            clause_exprs.append(_false_expr)
        elif len(clause_expr_children) and clause_expr_children[0] != _true_expr:
            clause_exprs.append(clause_expr_children[0])

    if _false_expr in clause_exprs:
        return _false_expr
    elif len(clause_exprs) == 1:
        return clause_exprs[0]
    else:
        return syn_ctx.make_function_expr('and', *clause_exprs)


class SpecAwareLIAUnifier(UnifierInterface):
    def __init__(self, pred_generator, term_solver, synth_funs, syn_ctx, spec):
        self.pred_generator = pred_generator
        self.term_solver = term_solver
        self.points = []
        self.spec = spec
        self.synth_funs = synth_funs
        self.syn_ctx = syn_ctx

        self.eval_ctx = evaluation.EvaluationContext()
        self.clauses = spec.get_canon_clauses()
        self.intro_vars = spec.get_intro_vars()

    def add_points(self, points):
        self.points.extend(points)

    def _eliminate_forall_vars(self, clauses):
        only_intro_var_clauses = _filter_to_intro_vars(clauses, self.intro_vars)

        if all([len(c) > 0 for c in only_intro_var_clauses ]):
            ret = _clauses_to_expr(self.syn_ctx, only_intro_var_clauses)
        else:
            raise NotImplementedError

        return ret

    # Assumes single app
    # Coverable points is the set of points that term covers
    # Uncovered points is the subset of coverable points that haven't been covered yet
    def _compute_pre_condition(self, coverable_sig, uncovered_sig, term):
        relevent_points = [ p for (i,p) in enumerate(self.points) if (i in uncovered_sig) and (i in coverable_sig) ]
        eval_ctx = self.eval_ctx

        # Change term to use introvars
        for sf in self.synth_funs:
            act_params = self.spec.canon_application[sf].children
            form_params = self.spec.formal_params[sf]
            term_sub = exprs.substitute_all(term, list(zip(form_params, act_params)))

        def eval_on_relevent_points(pred):
            ret = []
            for p in relevent_points:
                eval_ctx.set_valuation_map(p)
                ret.append(evaluation.evaluate_expression_raw(pred, eval_ctx))
            return ret

        # Rewrite clauses with current term instead of synth_fun application
        curr_clauses = []
        for clause in self.clauses:
            curr_clause = []
            for disjunct in clause:
                curr_disjunct = disjunct
                if len(self.synth_funs) == 1:
                    curr_disjunct = exprs.substitute(disjunct, self.spec.canon_application[self.synth_funs[0]], term_sub)
                else:
                    sub_pairs = list(zip( [ self.spec.canon_application[sf] for sf in self.synth_funs ], term_sub.children))
                    curr_disjunct = exprs.substitute_all(disjunct, sub_pairs)
                curr_clause.append(curr_disjunct)
            curr_clauses.append(curr_clause)

        only_intro_var_clauses = _filter_to_intro_vars(curr_clauses, self.intro_vars)
        if not all([ len(oivc) > 0 for oivc in only_intro_var_clauses ]):
            raise NotImplementedError
        else:
            # Do the only_intro_var_clauses cover all relevent points?
            some_point_uncovered = False
            good_clauses = [] # If there are single disjuncts that cover everything
            for oivc in only_intro_var_clauses:
                sig = set()
                good_clause = []
                for d in oivc:
                    s = eval_on_relevent_points(d)
                    if all(s):
                        good_clause.append(d)
                    for i, t in enumerate(s):
                        if t:
                            sig.add(i)
                good_clauses.append(good_clause)
                if len(sig) != len(relevent_points):
                    some_point_uncovered = True
                    break
            if some_point_uncovered:
                raise NotImplementedError
            elif all([ len(gc) > 0 for gc in good_clauses ]):
                pre_cond = _clauses_to_expr(self.syn_ctx, good_clauses)
            else:
                pre_cond = _clauses_to_expr(self.syn_ctx, only_intro_var_clauses)

        if pre_cond is not None:
            return pre_cond
        else:
            raise NotImplementedError

    def _pred_term_list_to_expr(self, pred_terms):
        if len(pred_terms) == 1:
            if len(self.synth_funs) == 1:
                return pred_terms[0][1] # Just return the term
            else:
                return list(pred_terms[0][1].children)
        else:
            if len(self.synth_funs) == 1:
                return self.syn_ctx.make_function_expr(
                        'ite',
                        pred_terms[0][0],
                        pred_terms[0][1],
                        self._pred_term_list_to_expr(pred_terms[1:]))
            else:
                conds = [ pred_terms[0][0] ] * len(self.synth_funs)
                thens = list(pred_terms[0][1].children)
                elses = self._pred_term_list_to_expr(pred_terms[1:])
                return [ self.syn_ctx.make_function_expr('ite', c, t, e)
                        for (c,t,e) in zip(conds, thens, elses) ]


    def get_num_distinct_preds(self):
        return 0

    def get_largest_pred_size_enumerated(self):
        return 0

    def unify(self):
        term_solver = self.term_solver
        sig_to_term = term_solver.get_signature_to_term()

        # print([ f.function_name for f in self.synth_funs])
        # for point in self.points:
            # print([ c.value_object for c in point])
        # for (sig, term) in sig_to_term.items():
            # print(str(sig), exprs.expression_to_string(term))
        eval_ctx = self.eval_ctx
        self.last_dt_size = 0

        triv = self._try_trivial_unification()
        if triv is not None:
            yield ("TERM", triv)
            return

        # print([ [ pi.value_object for pi in p ] for p in self.points])

        pred_terms = []

        # Pick terms which cover maximum number of points
        sigs = [ (s, s) for s in sig_to_term.keys() ]
        while True:
            full_sig, curr_sig = max(sigs, key=lambda fc: len(fc[1]))

            # We have covered all points
            if len(curr_sig) == 0:
                break

            term = sig_to_term[full_sig]
            pred = self._compute_pre_condition(full_sig, curr_sig, term)
            pred_terms.append((pred, term))

            pred_sig = BitSet(len(self.points))
            for i in curr_sig:
                eval_ctx.set_valuation_map(self.points[i])
                if evaluation.evaluate_expression_raw(pred, eval_ctx):
                    pred_sig.add(i)
            assert not pred_sig.is_empty()

            # Remove newly covered points from all signatures
            sigs = [ (f, c.difference(pred_sig)) for (f,c) in sigs ]

        # for pred, term in pred_terms:
        #     print(_expr_to_str(pred), ' ====> ', _expr_to_str(term))
        e = self._pred_term_list_to_expr(pred_terms)
        if len(self.synth_funs) == 1:
            act_params = self.spec.canon_application[self.synth_funs[0]].children
            form_params = self.spec.formal_params[self.synth_funs[0]]
            e = exprs.substitute_all(e, list(zip(act_params, form_params)))
        else:
            es = []
            for ep, sf in zip(e, self.synth_funs):
                act_params = self.spec.canon_application[sf].children
                form_params = self.spec.formal_params[sf]
                es.append(exprs.substitute_all(ep, list(zip(act_params, form_params))))
            domain_types = tuple([exprtypes.IntType()] * len(self.synth_funs))
            e = exprs.FunctionExpression(semantics_core.CommaFunction(domain_types),
                    tuple(es))
        yield ('TERM', e)

