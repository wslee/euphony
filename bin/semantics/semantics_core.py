#!/usr/bin/env python3
# semantics_core.py ---
#
# Filename: semantics_core.py
# Author: Abhishek Udupa
# Created: Tue Aug 18 16:25:53 2015 (-0400)
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
"""This module implements the semantics for the core theory,
i.e., equality, conditionals and basic boolean operations."""

from exprs import evaluation
from exprs import exprs
from exprs import exprtypes
from utils import utils
import z3
from semantics import semantics_types
from semantics.semantics_types import InterpretedFunctionBase

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class LetFunction(InterpretedFunctionBase):
    def __init__(self, binding_names, binding_vars, binding_types, ret_type):
        domain_types = binding_types + [ret_type]
        super().__init__('let', len(domain_types), domain_types, ret_type)
        self.binding_names = binding_names
        self.binding_vars = binding_vars
        self.binding_types = binding_types

    def to_string(self, expr_object):
        ret = "(let ("
        ret += ' '.join([
            "(%s %s %s)" % (bn, bt.print_string(), exprs.expression_to_string(e))
            for bn, bt, e in zip(self.binding_names, self.binding_types, expr_object.children[:-1]) ])
        ret += ') '
        if len(expr_object.children) > 0:
            ret += exprs.expression_to_string(expr_object.children[-1])
        ret += ')'
        return ret

    def evaluate(self, expr_object, eval_context_object):
        bindings = {}
        for bv, child in zip(self.binding_vars, expr_object.children[:-1]):
            evaluation.evaluate_expression_on_stack(child, eval_context_object)
            bindings[bv] = eval_context_object.peek()
            eval_context_object.pop()

        eval_context_object.push_let_variables(bindings)
        in_expr = expr_object.children[-1]
        evaluation.evaluate_expression_on_stack(in_expr, eval_context_object)
        eval_context_object.pop_let_variables()
        # res = eval_context_object.peek()
        # eval_context_object.pop()

    def to_smt(self, expr_object, smt_context_object, var_subst_map):
        smt_binding_var = [ semantics_types.expression_to_smt(bv, smt_context_object, var_subst_map)
                for bv in self.binding_vars ]
        smt_children = [ semantics_types.expression_to_smt(child, smt_context_object, var_subst_map)
                for child in expr_object.children ]
        return z3.substitute(smt_children[-1], list(zip(smt_binding_var, smt_children[:-1])))

class CommaFunction(InterpretedFunctionBase):
    def __init__(self, domain_types):
        super().__init__(',', len(domain_types), domain_types, None)
        self.eval_children = lambda *a: a
    # Should not be converted to SMT
    # Nor should it be evaluated

class EqFunction(InterpretedFunctionBase):
    """A function object for equality. Parametrized by the domain type."""
    def __init__(self, domain_type):
        super().__init__('=', 2, (domain_type, domain_type), exprtypes.BoolType())
        self.smt_function = lambda a, b: a == b
        self.eval_children = lambda a, b: a == b
        self.commutative = True

class NeFunction(InterpretedFunctionBase):
    def __init__(self, domain_type):
        super().__init__('ne', 2, (domain_type, domain_type), exprtypes.BoolType())
        self.smt_function = lambda a, b: a != b
        self.eval_children = lambda a, b: a != b
        self.commutative = True

    def to_string(self, expr_object):
        return "(not (= %s %s))" % tuple([exprs.expression_to_string(c) for c in expr_object.children])

class AndFunction(InterpretedFunctionBase):
    """A function object for conjunctions. Allows arbitrary number of arguments."""
    def __init__(self):
        super().__init__('and', -1, (exprtypes.BoolType(), ), exprtypes.BoolType())
        self.smt_function = lambda *children: z3.And(children, children[0].ctx)
        self.eval_children = lambda *children: all(children)
        self.commutative = True
        self.associative = True

class OrFunction(InterpretedFunctionBase):
    """A function object for disjunctions. Allows arbitrary number of arguments."""
    def __init__(self):
        super().__init__('or', -1, (exprtypes.BoolType(), ), exprtypes.BoolType())
        self.smt_function = lambda *children: z3.Or(children, children[0].ctx)
        self.eval_children = lambda *children: any(children)
        self.commutative = True
        self.associative = True

class NotFunction(InterpretedFunctionBase):
    """A function object for negation."""
    def __init__(self):
        super().__init__('not', 1, (exprtypes.BoolType(),), exprtypes.BoolType())
        self.smt_function = z3.Not
        self.eval_children = lambda child: not child

class ImpliesFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('=>', 2, (exprtypes.BoolType(), exprtypes.BoolType()),
                         exprtypes.BoolType())
        self.smt_function = z3.Implies
        self.eval_children = lambda a, b: (not a) or b

class IffFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('iff', 2, (exprtypes.BoolType(), exprtypes.BoolType()),
                         exprtypes.BoolType())
        self.smt_function = lambda a, b: a == b
        self.eval_children = lambda a, b: a == b
        self.commutative = True
        self.associative = True

class XorFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('xor', 2, (exprtypes.BoolType(), exprtypes.BoolType()),
                         exprtypes.BoolType())
        self.smt_function = z3.Xor
        self.eval_children = lambda a, b: a != b
        self.commutative = True
        self.associative = True

class IteFunction(InterpretedFunctionBase):
    def __init__(self, range_type):
        super().__init__('ite', 3, (exprtypes.BoolType(),
                                    range_type, range_type),
                         range_type)
        self.smt_function = z3.If
        self.eval_children = lambda a, b, c: b if a else c

class CoreInstantiator(semantics_types.InstantiatorBase):
    def __init__(self):
        super().__init__('core')
        self.and_instance = None
        self.or_instance = None

    def _get_and_instance(self):
        if (self.and_instance == None):
            self.and_instance = AndFunction()
        return self.and_instance

    def _get_or_instance(self):
        if (self.or_instance == None):
            self.or_instance = OrFunction()
        return self.or_instance

    def _get_canonical_function_name(self, function_name):
        if (function_name == '=' or function_name == 'eq'):
            return 'eq'
        elif (function_name == '!=' or function_name == 'ne'):
            return 'ne'
        elif (function_name == '=>' or function_name == 'implies'):
            return 'implies'
        else:
            return function_name

    def _do_instantiation(self, function_name, mangled_name, arg_types):
        function_name = self._get_canonical_function_name(function_name)
        if (function_name == 'eq' or function_name == 'ne'):
            if (len(arg_types) != 2 or arg_types[0] != arg_types[1]):
                self._raise_failure(function_name, arg_types)
            if (function_name == 'eq'):
                return EqFunction(arg_types[0])
            else:
                return NeFunction(arg_types[0])

        elif (function_name == 'and' or function_name == 'or'):
            if (not self._is_all_of_type(arg_types, exprtypes.TypeCodes.boolean_type)):
                self._raise_failure(function_name, arg_types)
            return self._get_and_instance() if function_name == 'and' else self._get_or_instance()

        elif (function_name == 'not'):
            if (len(arg_types) != 1 or arg_types[0].type_code != exprtypes.TypeCodes.boolean_type):
                self._raise_failure(function_name, arg_types)
            return NotFunction()

        elif (function_name == 'implies' or function_name == 'iff' or function_name == 'xor'):
            if (len(arg_types) != 2 or
                (not self._is_all_of_type(arg_types, exprtypes.TypeCodes.boolean_type))):
                self._raise_failure(function_name, arg_types)
            if (function_name == 'implies'):
                return ImpliesFunction()
            elif (function_name == 'iff'):
                return IffFunction()
            else:
                return XorFunction()

        elif (function_name == 'ite'):
            if (len(arg_types) != 3 or
                arg_types[0].type_code != exprtypes.TypeCodes.boolean_type or
                arg_types[1] != arg_types[2]):
                self._raise_failure(function_name, arg_types)
            return IteFunction(arg_types[1])

        else:
            return None


class MacroInstantiator(semantics_types.InstantiatorBase):
    def __init__(self, function_interpretations={}):
        super().__init__('macro')
        self.function_interpretations = function_interpretations

    def _do_instantiation(self, function_name, mangled_name, arg_types):
        if function_name not in self.function_interpretations:
            return None

        function_interpretation = self.function_interpretations[function_name]
        assert function_name == function_interpretation.function_name
        assert len(arg_types) == function_interpretation.function_arity
        assert arg_types == function_interpretation.domain_types

        return function_interpretation

    def _get_canonical_function_name(self, function_name):
        return function_name

    def add_function(self, function_name, function_interpretation):
        self.function_interpretations[function_name] = function_interpretation

    def instantiate_all(self, expr):
        instantiated_one = False
        while not instantiated_one:
            instantiated_one = True
            for fname, fint in self.function_interpretations.items():
                while True:
                    app = exprs.find_application(expr, fname)
                    if app is None:
                        break
                    instantiated_one = False
                    actual_params = app.children
                    formal_params = fint.formal_parameters
                    new_app = exprs.substitute_all(
                            fint.interpretation_expression,
                            list(zip(formal_params, actual_params)))
                    expr = exprs.substitute(expr, app, new_app)
        return expr

    def instantiate_macro(self, expr, fname):
        instantiated_one = False
        while not instantiated_one:
            instantiated_one = True
            fint = self.function_interpretations[fname]
            while True:
                app = exprs.find_application(expr, fname)
                if app is None:
                    break
                instantiated_one = False
                actual_params = app.children
                formal_params = fint.formal_parameters
                new_app = exprs.substitute_all(
                        fint.interpretation_expression,
                        list(zip(formal_params, actual_params)))
                expr = exprs.substitute(expr, app, new_app)
        return expr

class UninterpretedFunctionInstantiator(semantics_types.InstantiatorBase):
    def __init__(self, functions={}):
        super().__init__('uf')
        self.functions = functions

    def add_function(self, function_name, function_info):
        self.functions[function_name] = function_info

    def _get_canonical_function_name(self, function_name):
        return function_name

    def _do_instantiation(self, function_name, mangled_name, arg_types):
        if function_name not in self.functions:
            return None

        function_info = self.functions[function_name]
        assert function_name == function_info.function_name
        assert len(arg_types) == function_info.function_arity
        assert arg_types == function_info.domain_types

        return function_info

    def get_functions(self):
        return self.functions

class SynthFunctionInstantiator(semantics_types.InstantiatorBase):
    def __init__(self):
        super().__init__('synth')
        self.functions = {}

    def add_function(self, function_name, function_info):
        self.functions[function_name] = function_info

    def _get_canonical_function_name(self, function_name):
        return function_name

    def _do_instantiation(self, function_name, mangled_name, arg_types):
        if function_name not in self.functions:
            return None

        function_info = self.functions[function_name]
        assert function_name == function_info.function_name
        assert len(arg_types) == function_info.function_arity
        assert arg_types == function_info.domain_types

        return function_info

    def get_functions(self):
        return self.functions

#
# semantics_core.py ends here
