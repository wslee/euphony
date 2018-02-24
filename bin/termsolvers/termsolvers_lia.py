#!/usr/bin/env python3
# termsolvers_lia.py ---
#
# Filename: termsolvers_lia.py
# Author: Arjun Radhakrishna
# Created: Wed, 08 Jun 2016 21:12:20 -0400
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

from termsolvers.termsolvers import TermSolverInterface
from exprs import exprs
from exprs import exprtypes
from semantics import semantics_types
from semantics import semantics_core
from utils import z3smt
from utils.lia_utils import LIAInequality
from utils import lia_utils
from exprs import evaluation

_expr_to_str = exprs.expression_to_string
_expr_to_smt = semantics_types.expression_to_smt

class SpecAwareLIATermSolver(TermSolverInterface):
    def __init__(self, term_signature, spec):
        super().__init__()
        self.term_signature = term_signature
        self.synth_funs = spec.synth_funs
        self.spec = spec
        self.syn_ctx = self.spec.syn_ctx
        self.point_var_exprs =  [ exprs.VariableExpression(v) for v in spec.point_vars ]

        self.smt_ctx = z3smt.Z3SMTContext()
        self.eval_ctx = evaluation.EvaluationContext()
        self.canon_apps = [ self.spec.canon_application[sf] for sf in self.synth_funs ]

        self.outvars = []
        for fn in self.synth_funs:
            self.outvars.append(
                    exprs.VariableExpression(exprs.VariableInfo(
                        exprtypes.IntType(), 'outvar_' + fn.function_name,
                        len(self.point_var_exprs) + len(self.outvars))))
        self.all_vars = self.point_var_exprs + self.outvars
        self.all_vars_z3 = [ _expr_to_smt(v, self.smt_ctx) for v in self.all_vars ]

        # self.clauses = spec.get_canon_clauses()
        self.lia_clauses = [ [ 
            LIAInequality.from_expr(exprs.substitute_all(disjunct, list(zip(self.canon_apps, self.outvars))))
            for disjunct in clause  ]
            for clause in spec.get_canon_clauses() ]
        self.rewritten_spec = exprs.substitute_all(
                self.spec.get_canonical_specification(),
                list(zip(self.canon_apps, self.outvars)))

    def generate_more_terms(self):
        pass

    def _compute_term_signature(self, term):
        return self._default_compute_term_signature(term)

    def _trivial_solve(self):
        ret = exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType()))
        if len(self.synth_funs) > 1:
            domain_types = tuple([exprtypes.IntType()] * len(self.synth_funs))
            ret = exprs.FunctionExpression(semantics_core.CommaFunction(domain_types),
                    tuple([ret] * len(self.synth_funs)))
        self.signature_to_term = {None:ret}
        return True

    def _single_solve_single_point(self, ivs, point):
        syn_ctx = self.syn_ctx
        smt_ctx = self.smt_ctx
        eval_ctx = self.eval_ctx
        spec = self.rewritten_spec

        # Find one value of output
        eq_constrs = []
        for var, value in zip(self.point_var_exprs, point):
            c = self.syn_ctx.make_function_expr('eq', 
                    exprs.ConstantExpression(value), var)
            eq_constrs.append(c)
        full_constr = self.syn_ctx.make_function_expr('and',
                spec, *eq_constrs)

        raw_z3_model = exprs.sample(full_constr, smt_ctx, self.all_vars_z3)
        # print("B1:", raw_z3_model)
        model = dict(zip(self.all_vars, [ z3_value.as_long() for z3_value in raw_z3_model ]))
        # print("B2:")
        # for var, val in model.items():
            # print("\t", exprs.expression_to_string(var), "--->", val)

        # Find the first disjunct that 
        # (a) Is true in this model
        # (b) Contains some outvar 
        # print("B3:")
        # for clause in self.lia_clauses:
            # for disj in clause:
                # print(str(disj), end=" , ")
            # print()
        ineqs = []
        outvar_set = set(self.outvars)
        for clause in self.lia_clauses:
            for disjunct in clause:
                # print(str(disjunct) + " --> " + str(disjunct.eval(model)))
                # print(str(disjunct) + " --> " + str(len(outvar_set & disjunct.get_variables())))
                if disjunct.eval(model) and len(outvar_set & disjunct.get_variables()) > 0:
                    ineqs.append(disjunct)
                    break
        # print("B3:")
        # for ineq in ineqs:
            # print("\t", str(ineq))
        return lia_utils.solve_inequalities(model, self.outvars, ineqs, syn_ctx)

    def _single_solve(self, ivs, points):
        s = self.signature_factory()
        for point in points:
            pt_index = self.points.index(point)
            s.add(pt_index)

        for sig, term in self.signature_to_term.items():
            if (sig | s) == s:
                if len(self.synth_funs) == 1:
                    return [ term ]
                else:
                    return term.children

        if len(points) == 1:
            return self._single_solve_single_point(ivs, points[0])
        else:
            raise NotImplementedError

    def solve(self):
        if len(self.points) == 0:
            # print("Trivial solve!")
            return self._trivial_solve()

        # print("-----------------")
        # print("Nontrivial solve!")
        # for point in self.points:
            # print("POINT:", [ p.value_object for p in point])
        # for sig, term in self.signature_to_term.items():
            # print('SIGTOTERM:', str(sig), _expr_to_str(term))

        intro_var_signature = []
        for point in self.points:
            ivs = point[:len(self.spec.intro_vars)]
            intro_var_signature.append((ivs, point))

        # Nobody can understand what python groupby returns!!!
        # ivs_groups = itertools.groupby(
        #         sorted(intro_var_signature, key=lambda a: a[0]),
        #         key=lambda a: a[0])
        curr_ivs = None
        ivs_groups = []
        for ivs, point in intro_var_signature:
            if ivs == curr_ivs:
                ivs_groups[-1][1].append(point)
            else:
                ivs_groups.append((ivs, [point]))
                curr_ivs = ivs

        for ivs, points in ivs_groups:
            # print("A:")
            terms = self._single_solve(ivs, points)
            # print("C:", [ exprs.expression_to_string(t) for t in terms ])
            new_terms = []
            for term, sf in zip(terms, self.synth_funs):
                new_terms.append(exprs.substitute_all(term, 
                    list(zip(self.spec.intro_vars, self.spec.formal_params[sf]))))
            terms = new_terms
            # print([ _expr_to_str(t) for t in terms ])

            sig = self.signature_factory()
            if len(self.synth_funs) > 1:
                domain_types = tuple([exprtypes.IntType()] * len(self.synth_funs))
                single_term = exprs.FunctionExpression(semantics_core.CommaFunction(domain_types),
                        tuple(terms))
            else:
                single_term = terms[0]

            for i, t in enumerate(self.term_signature(single_term, self.points)):
                if t:
                    sig.add(i)
            self.signature_to_term[sig] = single_term
        # print("-----------------")

        return True

