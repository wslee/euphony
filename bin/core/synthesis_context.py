#!/usr/bin/env python3
# synthesis_context.py ---
#
# Filename: synthesis_context.py
# Author: Abhishek Udupa
# Created: Wed Sep  2 12:59:38 2015 (-0400)
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

from utils import utils
from semantics import semantics_types
from exprs import exprs
from exprs import exprtypes
from utils import basetypes

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class SynthesisContext(object):
    """A class for managing the synthesis context.
    Args:
    function_instantiator: an object that instantiates operators based on
    the name of the operator and types of the arguments provided to the operator.
    """

    def __init__(self, *function_instantiators):
        self.function_instantiators = function_instantiators
        self.variables_map = {}
        self.unknown_function_map = {}
        self.spec = None
        self.synth_funs = None

    def make_variable(self, var_type, var_name,
                      var_eval_offset = exprs.VariableInfo._undefined_offset):
        """Makes a variable info of the given name and type."""
        assert(isinstance(var_type, exprtypes.TypeBase))
        existing = self.variables_map.get(var_name, None)
        if (existing != None and existing.variable_type == var_type):
            return existing
        elif (existing != None and existing.variable_type != var_type):
            raise ValueError(('Variable named \'%s\' has already ' +
                                 'been created with type %s') % (var_name, str(existing.var_type)))
        else:
            retval = exprs.VariableInfo(var_type, var_name, var_eval_offset)
            retval.synthesis_ctx = self
            self.variables_map[var_name] = retval
            return retval

    def get_variable(self, var_name):
        return self.variables_map.get(var_name, None)

    def get_variable_expr(self, var_name):
        return exprs.VariableExpression(self.get_variable(var_name))

    def set_eval_offset_for_variable(self, var_name, var_eval_offset):
        var_info = self.get_variable(var_name)
        if (var_info == None):
            raise ValueError('Could not find a variable named %s in context' % var_name)
        var_info.var_eval_offset = var_eval_offset

    def make_variable_expr(self, var_type, var_name,
                           var_eval_offset = exprs.VariableInfo._undefined_offset):
        var_info = self.make_variable(var_type, var_name, var_eval_offset)
        return exprs.VariableExpression(var_info)

    def make_constant_expr(self, const_type, const_value):
        """Makes a typed constant expression with the given value."""
        assert(isinstance(const_type, exprtypes.TypeBase))
        return exprs.ConstantExpression(exprs.Value(const_type, const_value))

    def make_function(self, function_name, *arg_types):
        function_info = None
        for instantiator in self.function_instantiators:
            function_info = instantiator.instantiate(function_name, arg_types)
            if (function_info != None):
                function_info.synthesis_ctx = self
                break

        return function_info

    def make_synth_function(self, function_name, domain_types, range_type):
        predef_function = self.make_function(function_name, *domain_types)
        if (predef_function != None):
            raise ValueError(('Function named \'%s\' is a predefined function ' +
                                 'given the signature. Could not instantiate it as ' +
                                 'an unknown function') % function_name)

        mangled_name = semantics_types.mangle_function_name(function_name, domain_types)
        existing_fun = self.unknown_function_map.get(mangled_name, None)
        if (existing_fun != None):
            return existing_fun

        new_fun = semantics_types.SynthFunction(function_name, len(domain_types),
                                                      domain_types, range_type)
        new_fun.synthesis_ctx = self
        self.unknown_function_map[mangled_name] = new_fun
        return new_fun

    def make_function_expr(self, function_name_or_info, *child_exps):
        """Makes a typed function expression applied to the given child expressions."""

        if (isinstance(function_name_or_info, str)):
            function_info = self.make_function(function_name_or_info, *child_exps)
            function_name = function_name_or_info
        else:
            assert (isinstance(function_name_or_info, semantics_types.FunctionBase))
            function_info = function_name_or_info
            function_name = function_info.function_name

        if (function_info == None):
            raise basetypes.ArgumentError('Could not instantiate function named "' +
                                          function_name + '" with argument types: (' +
                                          ', '.join([str(exprs.get_expression_type(x))
                                                     for x in child_exps]) + ')')

        return exprs.FunctionExpression(function_info, tuple(child_exps))

    def make_ac_function_expr(self, function_name_or_info, *child_exps):
        if (len(child_exps) == 1):
            return child_exps[0]

        return self.make_function_expr(function_name_or_info, *child_exps)

    def make_true_expr(self):
        """Makes an expression representing the Boolean constant TRUE."""
        return exprs.ConstantExpression(exprs.Value(True, exprtypes.BoolType()))

    def make_false_expr(self):
        """Makes an expression representing the boolean constant FALSE."""
        return exprs.ConstantExpression(exprs.Value(False, exprtypes.BoolType()))

    def validate_function(self, function_info):
        if function_info.function_name == 'let':
            return True
        if (function_info.synthesis_ctx is not self):
            return False
        for instantiator in self.function_instantiators:
            if (instantiator.validate_function(function_info)):
                return True
        # could be an unknown function
        return (self.unknown_function_map.get(function_info.mangled_function_name, None) != None)

    def validate_variable(self, variable_info):
        if (variable_info.synthesis_ctx is not self):
            return False
        return (self.variables_map.get(variable_info.variable_name, None) != None)

    def set_synth_funs(self, synth_funs):
        assert self.synth_funs is None
        self.synth_funs = synth_funs

    def get_synth_funs(self):
        return self.synth_funs

    def set_macro_instantiator(self, instantiator):
        assert instantiator in self.function_instantiators
        self.macro_instantiator = instantiator
#
# synthesis_context.py ends here
