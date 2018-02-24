#!/usr/bin/env python3
# Specifications.py ---
#
# Filename: specifications.py
# Author: Arjun Radhakrishna
# Created: Tue, 07 Jun 2016 14:10:26 -0400
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

from utils import basetypes
from exprs import evaluation
from exprs import expr_transforms
from exprs import exprs

class SpecInterface(object):
    def term_signature(self, term, points):
        raise basetypes.AbstractMethodError('SpecInterface.check_on_point()')

    def is_pointwise(self):
        return not self.is_multipoint

class FormulaSpec(SpecInterface):
    def __init__(self, spec_expr, syn_ctx, synth_funs):
        self.syn_ctx = syn_ctx
        self.eval_ctx = evaluation.EvaluationContext()
        self.synth_funs = synth_funs
        self.spec_expr = spec_expr

    def term_signature(self, term, points):
        eval_ctx = self.eval_ctx
        if len(self.synth_funs) > 1:
            assert exprs.is_application_of(term, ',')
            interpretations = term.children
            for func, interpretation in zip(self.synth_funs, interpretations):
                eval_ctx.set_interpretation(func, interpretation)
        else:
            eval_ctx.set_interpretation(self.synth_funs[0], term)

        retval = []
        for point in points:
            eval_ctx.set_valuation_map(point)
            try:
                # print(exprs.expression_to_string(self.canon_spec))
                r = evaluation.evaluate_expression_raw(self.canon_spec, eval_ctx)
                # print(exprs.expression_to_string(term), "is", r, "on", [p for p in point])
                # print(eval_ctx.eval_stack_top)
                retval.append(r)
            except (basetypes.PartialFunctionError, basetypes.UnboundLetVariableError):
                # Exceptions may be raised when applying partial functions like div, mod, etc
                retval.append(False)

        return retval

    def get_canonical_specification(self):
        return self.canon_spec


# Just the base class. Separated because I might want to add random stuff here
class MultiPointSpec(FormulaSpec):
    def __init__(self, spec_expr, syn_ctx, synth_funs):
        super().__init__(spec_expr, syn_ctx, synth_funs)
        self.point_vars, self.canon_spec = \
                expr_transforms.canonicalize_multipoint_specification(spec_expr, syn_ctx)
        self.is_multipoint = True

    def get_point_variables(self):
        return self.point_vars

    def get_applications(self):
        applications = {}
        for sf in self.synth_funs:
            sf_name = sf.function_name
            apps = exprs.find_all_applications(self.spec_expr, sf_name)
            applications[sf] = apps
        return applications


class StandardSpec(FormulaSpec):
    def __init__(self, spec_expr, syn_ctx, synth_funs, theory):
        super().__init__(spec_expr, syn_ctx, synth_funs)
        self.theory = theory
        self.init_spec_tuple()

        self.formal_params = {}
        for fn in self.synth_funs:
            self.formal_params[fn] = [ 
                    exprs.FormalParameterExpression(fn, argtype, i)
                    for (i, argtype) in enumerate(fn.domain_types) ]
        self.is_multipoint = False

    def init_spec_tuple(self):
        syn_ctx = self.syn_ctx
        actual_spec = self.spec_expr
        variables_list, functions_list, canon_spec, canon_clauses, intro_vars = \
                expr_transforms.canonicalize_specification(actual_spec, syn_ctx, self.theory)
        self.canon_spec = canon_spec
        self.intro_vars = intro_vars
        self.point_vars = variables_list
        self.canon_clauses = canon_clauses
        self.canon_application = {}
        for fun in self.synth_funs:
            self.canon_application[fun] = \
                    syn_ctx.make_function_expr(fun, *self.intro_vars)

    def get_point_variables(self):
        return self.point_vars

    def get_intro_vars(self):
        return self.intro_vars

    def get_canon_clauses(self):
        return self.canon_clauses


class PBESpec(SpecInterface):
    def __init__(self, expr_valuations, synth_fun, theory):
        self.synth_fun = synth_fun
        self.eval_ctx = evaluation.EvaluationContext()
        self.theory = theory
        
        self._initialize_valuations(expr_valuations)

        args = [ exprs.FormalParameterExpression(synth_fun, argtype, i) 
                for i, argtype in enumerate(synth_fun.domain_types)] 
        self.synth_fun_expr = exprs.FunctionExpression(synth_fun, tuple(args))
        self.is_multipoint = False

    def _initialize_valuations(self, expr_valuations):
        eval_ctx = self.eval_ctx
        def evaluate(t):
            return 
        self.valuations = {}
        for args, value in expr_valuations:
            raw_args = tuple([ evaluation.evaluate_expression(a, eval_ctx) for a in args ])
            raw_value = evaluation.evaluate_expression_raw(value, eval_ctx)
            self.valuations[raw_args] = raw_value

    def term_signature(self, term, points):
        # try:
            eval_ctx = self.eval_ctx
            eval_ctx.set_interpretation(self.synth_fun, term)
            synth_fun_expr = self.synth_fun_expr

            retval = []
            for point in points:
                if point not in self.valuations:
                    # print("Something is almost certainly wrong!")
                    retval.append(True)
                    continue
                eval_ctx.set_valuation_map(point)
                try:
                    retval.append(self.valuations[point] == evaluation.evaluate_expression_raw(synth_fun_expr, eval_ctx))
                except (basetypes.PartialFunctionError, basetypes.UnboundLetVariableError):
                    retval.append(False)

            return retval
        # except:
        #     return [False] * len(points)


