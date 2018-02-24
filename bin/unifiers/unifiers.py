#!/usr/bin/env python3
# unifiers.py ---
#
# Filename: unifiers.py
# Author: Arjun Radhakrishna
# Created: Mon, 06 Jun 2016 14:32:01 -0400
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

from exprs import exprs
from termsolvers import termsolvers
import random
from semantics import semantics_types
from exprs import exprtypes
from exprs import evaluation
import eusolver
from utils import basetypes

_expr_to_str = exprs.expression_to_string
_is_expr = exprs.is_expression
_get_expr_with_id = exprs.get_expr_with_id

def get_decision_tree_size(dt):
    if (dt.is_leaf()):
        return 1
    else:
        return (1 + get_decision_tree_size(dt.get_positive_child()) +
                get_decision_tree_size(dt.get_negative_child()))

class UnifierInterface(object):
    def add_points(self):
        raise basetypes.AbstractMethodError('UnifierInterface.add_points()')

    def unify(self):
        raise basetypes.AbstractMethodError('UnifierInterface.solve()')

    def _try_trivial_unification(self):
        # we can trivially unify if there exists a term
        # which satisfies the spec at all points
        trivial_term = None
        for (sig, term) in self.term_solver.get_signature_to_term().items():
            if (sig is None or sig.is_full()):
                trivial_term = term
                break
        return trivial_term

class EnumerativeDTUnifierBase(UnifierInterface):
    def __init__(self, pred_generator, term_solver, syn_ctx):
        self.pred_generator = pred_generator
        self.term_solver = term_solver
        self.points = []
        self.pred_solver = None
        self.syn_ctx = syn_ctx

    def add_points(self, new_points):
        self.points.extend(new_points)
        self.pred_solver.add_points(new_points)

    def get_largest_pred_size_enumerated(self):
        if self.pred_solver is not None:
            return self.pred_solver.get_largest_term_size_enumerated()
        return -1

    def get_signature_to_pred(self):
        return self.pred_solver.get_signature_to_term()

    def _try_decision_tree_learning(self):
        term_list = []
        term_sig_list = []
        pred_list = []
        pred_sig_list = []
        for (term_sig, term) in self.term_solver.get_signature_to_term().items():
            term_list.append(term)
            term_sig_list.append(term_sig)
        for (pred_sig, pred) in self.pred_solver.signature_to_term.items():
            pred_list.append(pred)
            pred_sig_list.append(pred_sig)

        # print('Calling native decision tree learner...')
        # print('pred_sig_list: %s' % [str(x) for x in pred_sig_list])
        # print('term_sig_list: %s' % [str(x) for x in term_sig_list], flush=True)
        # print('pred_list: %s' % [_expr_to_str(x) for x in pred_list], flush=True)
        # print('term_list: %s' % [_expr_to_str(x) for x in term_list], flush=True)
        # print('points   :\n%s' % _point_list_to_str(self.points), flush=True)
        dt = eusolver.eus_learn_decision_tree_for_ml_data(pred_sig_list,
                                                          term_sig_list)
        # print('Done!', flush=True)
        # print(dt, flush=True)
        # print('Obtained decision tree:\n%s' % str(dt))
        if (dt == None):
            return None
        else:
            return (term_list, term_sig_list, pred_list, pred_sig_list, dt)

    def get_num_distinct_preds(self):
        return len(self.pred_solver.signature_to_term)

    def unify(self):
        term_solver = self.term_solver
        # signature_to_term = term_solver.get_signature_to_term()
        self.last_dt_size = 0

        pred_solver = self.pred_solver
        pred_solver.restart_bunched_generator()
        while True:
            triv = self._try_trivial_unification()
            if triv is not None:
                yield ("TERM", triv)
                return

            old_pred_num = len(pred_solver.signature_to_term)
            self.pred_solver.generate_more_terms()
            new_pred_num = len(pred_solver.signature_to_term)
            if old_pred_num == new_pred_num:
                continue

            dt_tuple = self._try_decision_tree_learning()
            if (dt_tuple == None):
                term_solver.generate_more_terms()
                continue
            self.last_dt_size = get_decision_tree_size(dt_tuple[-1])

            yield ("DT_TUPLE", dt_tuple)
            term_solver.generate_more_terms()

    def _dummy_spec(self, synth_fun):
        func = semantics_types.SynthFunction(
                'pred_indicator_' + str(random.randint(1, 10000000)),
                synth_fun.function_arity,
                synth_fun.domain_types,
                exprtypes.BoolType())
        args = [ exprs.FormalParameterExpression(func, argtype, i) 
                for i, argtype in enumerate(synth_fun.domain_types)] 
        indicator_expr = exprs.FunctionExpression(func, tuple(args))
        eval_ctx = evaluation.EvaluationContext()

        def compute_indicator(term, points):
            eval_ctx.set_interpretation(func, term)

            retval = []
            for point in points:
                eval_ctx.set_valuation_map(point)
                try:
                    retval.append(evaluation.evaluate_expression_raw(indicator_expr, eval_ctx))
                except (basetypes.UnboundLetVariableError, basetypes.PartialFunctionError):
                    # Can't mess up on predicates
                    return [False] * len(points)
            return retval

        return func, compute_indicator


class PointlessEnumDTUnifier(EnumerativeDTUnifierBase):
    def __init__(self, pred_generator, term_solver, synth_fun, syn_ctx):
        super().__init__(pred_generator, term_solver, syn_ctx)
        indicator_fun, compute_indicator = \
                self._dummy_spec(synth_fun)
        self.pred_solver = termsolvers.PointlessTermSolver(
                compute_indicator,
                pred_generator)

class PointDistinctDTUnifier(EnumerativeDTUnifierBase):
    def __init__(self, pred_generator, term_solver, synth_fun, syn_ctx, stat_model=None):
        super().__init__(pred_generator, term_solver, syn_ctx)
        indicator_fun, compute_indicator = \
                self._dummy_spec(synth_fun)
        self.pred_solver = termsolvers.PointDistinctTermSolver(
                compute_indicator,
                pred_generator, stat_model=stat_model)


class NullUnifier(UnifierInterface):
    def __init__(self, pred_generator, term_solver, synth_fun, syn_ctx, spec):
        self.term_solver = term_solver
        self.last_dt_size = 0

    def get_num_distinct_preds(self):
        return 0

    def get_largest_pred_size_enumerated(self):
        return 0

    def add_points(self, points):
        pass

    def unify(self):
        triv = self._try_trivial_unification()
        if triv is not None:
            yield ("TERM", triv)
            return
        raise Exception

