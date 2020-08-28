#!/usr/bin/env python3
# termsolvers.py ---
#
# Filename: termsolvers.py
# Author: Arjun Radhakrishna
# Created: Mon, 06 Jun 2016 13:54:34 -0400
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


from exprs import evaluation
from eusolver import BitSet
from phogs import phog
from enumerators import enumerators
from exprs import exprs
from semantics import semantics_types
from utils import basetypes
import options
from enum import Enum

_expr_to_str = exprs.expression_to_string
_is_expr = exprs.is_expression
_get_expr_with_id = exprs.get_expr_with_id

class StoppingCondition(Enum):
    one_term_sufficiency = 1
    term_sufficiency = 2 
# def check_term_sufficiency(sig_to_term, num_points):
#     accumulator = BitSet(num_points)
#     for (sig, term) in sig_to_term.items():
#         accumulator |= sig
#     return (accumulator.is_full())

# def check_one_term_sufficiency(sig_to_term, num_points):
#     for (sig, term) in sig_to_term.items():
#         if sig.is_full():
#             return True
#     return False

class TermSolverInterface(object):
    def __init__(self):
        self.points = []
        self.current_largest_term_size = 0
        self.signature_to_term = {}

    def get_signature_to_term(self):
        return self.signature_to_term

    def get_num_distinct_terms(self):
        return len(self.signature_to_term)

    def get_largest_term_size_enumerated(self):
        return 0

    def add_points(self, new_points):
        points = self.points
        points.extend(new_points)
        self.signature_factory = BitSet.make_factory(len(points))
        self.one_full_signature = False
        self._do_complete_sig_to_term()

    def _do_complete_sig_to_term(self):
        # print("Completing sig to term")
        # for point in self.points:
        #     print("POINT:", [ p.value_object for p in point])
        self.full_signature = self.signature_factory()

        old_sig_to_term = self.signature_to_term
        new_sig_to_term = {}

        # for sig, term in old_sig_to_term.items():
        #     print("OLD SIG TO TERM:", str(sig), _expr_to_str(term))

        for sig, term in old_sig_to_term.items():
            new_sig = self._compute_term_signature(term)
            if not new_sig.is_empty():
                new_sig_to_term[new_sig] = term
            self.full_signature |= new_sig
            if new_sig.is_full():
                self.one_full_signature = True

        # for sig, term in new_sig_to_term.items():
        #     print("NEW SIG TO TERM:", str(sig), _expr_to_str(term))

        self.signature_to_term = new_sig_to_term


    def _default_compute_term_signature(self, term, old_signature=None):
        points = self.points
        # num_points = len(points)

        retval = self.signature_factory()

        if old_signature is not None:
            retval.copy_in(old_signature)
            start_index = old_signature.size_of_universe()
        else:
            start_index = 0

        # num_new_points = retval.size_of_universe()
        new_points = points[start_index:]
        for i, v in enumerate(self.term_signature(term, new_points), start_index):
            if v:
                retval.add(i)
        # print(_expr_to_str(term), ': ', str(retval))
        return retval

    def solve(self):
        raise basetypes.AbstractMethodError('TermSolverInterface.solve()')

    def generate_more_terms(self):
        raise basetypes.AbstractMethodError('TermSolverInterface.generate_more_terms()')

class EnumerativeTermSolverBase(TermSolverInterface):
    def __init__(self, term_signature, stat_model=None):
        super().__init__()
        self.term_signature = term_signature
        # statistical model to guide search
        self.stat_model = stat_model
        self.bunch_generator = None
        self.max_term_size = 128
        self.stopping_condition = StoppingCondition.term_sufficiency
        self.full_signature = BitSet.make_factory(0)()
        self.one_full_signature = False

    def set_max_term_size(self, size):
        self.max_term_size = size

    def _trivial_solve(self):
        term_size = 1
        while (term_size <= self.max_term_size):
            self.term_generator.set_size(term_size)
            for term in self.term_generator.generate():
                # print("by trivial : " + exprs.expression_to_string(term))
                self.signature_to_term = {None : term}
                return True
            term_size += 1
        return False

    def get_largest_term_size_enumerated(self):
        if self.bunch_generator is None:
            return self.current_largest_term_size
        return max(self.current_largest_term_size,
                self.bunch_generator.current_object_size)

    def restart_bunched_generator(self):
        # Book keeping
        if self.bunch_generator is not None:
            self.current_largest_term_size = max(self.current_largest_term_size,
                    self.bunch_generator.current_object_size)

        # HACK HACK HACK: BunchGenerator bunch_size should be initialized properly.
        # If bunch_size is larger than the number of point_distinct predicates, it goes into an infinite loop
        # 
        self.bunch_generator = enumerators.BunchedGenerator(self.term_generator,
                                                            # self.max_term_size, len(self.points) * 2)
                                                            self.max_term_size, 1)

        if self.stat_model is not None:
            self.bunch_generator_state = self.stat_model.generate(self.term_generator.factory._compute_signature, self.points)
        else:
            self.bunch_generator_state = self.bunch_generator.generate()
        # clearning up for collecting data at next cegis iter
        if self.stat_model is not None:
            self.stat_model.clear_data()

    def _default_solve(self, restart_everytime):

        num_points = len(self.points)
        if (num_points == 0): # No points, any term will do
            return self._trivial_solve()

        signature_to_term = self.signature_to_term

        # no restart (incremental search in using PHOG)
        if (options.inc or options.noindis) and options.use_phog():
            restart_everytime = False

        if restart_everytime or self.bunch_generator is None:
            self.restart_bunched_generator()
        while True:
            success = self.generate_more_terms()
            if not success:
                return False
            if (self.stopping_condition == StoppingCondition.term_sufficiency
                    and self.full_signature.is_full()):
                return True
            elif (self.stopping_condition == StoppingCondition.one_term_sufficiency
                    and self.one_full_signature):
                return True

    def _default_generate_more_terms(self, transform_term=None):
        signature_to_term = self.signature_to_term
        bunch_generator_state = self.bunch_generator_state
        try:
            bunch = next(bunch_generator_state)
        except StopIteration:
            return False

        for term in bunch:
            if transform_term is not None:
                term = transform_term(term)
            sig = self._compute_term_signature(term)
            # collecting data
            if self.stat_model is not None and options.use_phog():
                self.stat_model.add_for_statistics(term)

            # w/o indistinguishability
            # do not apply indis when using PHOG (indistinguishability is done in phog.py)
            if (sig in signature_to_term or sig.is_empty()) and (not options.use_phog()):
                continue
            signature_to_term[sig] = term

            # for sig,term in signature_to_term.items():
            #     print(exprs.expression_to_string(term), ' : ', sig)
            self.full_signature = self.full_signature | sig
            if sig.is_full():
                self.one_full_signature = True
                # print statistics when using PHOG
                if options.use_phog() and self.stat_model is not None: self.stat_model.print_statistics()

        return True



class PointlessTermSolver(EnumerativeTermSolverBase):
    def __init__(self, term_signature, term_generator):
        super().__init__(term_signature)
        self.term_generator = term_generator
        self.eval_cache = {}
        self.monotonic_expr_id = 0

    def _compute_term_signature(self, term):
        eval_cache = self.eval_cache
        old_signature = eval_cache.get(term.expr_id)
        retval = self._default_compute_term_signature(term, old_signature)
        eval_cache[term.expr_id] = retval
        return retval

    def generate_more_terms(self):
        def add_expr_id(term):
            term = _get_expr_with_id(term, self.monotonic_expr_id)
            self.monotonic_expr_id += 1
            return term
        return self._default_generate_more_terms(transform_term=add_expr_id)

    def solve(self):
        self.monotonic_expr_id = 0
        return self._default_solve(restart_everytime=False)


class PointDistinctTermSolver(EnumerativeTermSolverBase):
    def __init__(self, term_signature, term_generator, stat_model=None):
        super().__init__(term_signature, stat_model=stat_model)
        assert type(term_generator.factory) is enumerators.PointDistinctGeneratorFactory
        self.term_generator = term_generator

    def _compute_term_signature(self, term):
        return self._default_compute_term_signature(term)

    def generate_more_terms(self):
        return self._default_generate_more_terms(transform_term=None)

    def solve(self):
        return self._default_solve(restart_everytime=True)

# TermSolver = PointlessTermSolver
# TermSolver = PointDistinctTermSolver
