#!/usr/bin/env python3
# semantics_lia.py ---
# Filename: semantics_lia.py
# Author: Abhishek Udupa
# Created: Mon Aug 31 21:50:39 2015 (-0400)
#
# Copyright (c) 2013, Abhishek Udupa, University of Pennsylvania
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
from exprs import exprtypes
import functools
from utils import utils
import z3
from semantics import semantics_types
from semantics.semantics_types import InterpretedFunctionBase

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class AddFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('+', -1, (exprtypes.IntType(), ), exprtypes.IntType())
        self.eval_children = lambda *args: sum(args)
        self.smt_function = z3.Sum
        self.commutative = True
        self.associative = True

class SubFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('-', 2, (exprtypes.IntType(), exprtypes.IntType()), exprtypes.IntType())
        self.eval_children = lambda a, b : a - b
        self.smt_function = lambda a, b : a - b

class ModFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('mod', 2, (exprtypes.IntType(), exprtypes.IntType()), exprtypes.IntType())
        def eval_c(a, b):
            if b != 0:
                return a % b if b > 0 else (-a) % (-b)
            else:
                raise basetypes.PartialFunctionError
        self.eval_children = eval_c
        self.smt_function = lambda a, b : a % b

class MinusFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('-', 1, (exprtypes.IntType(),), exprtypes.IntType())
        self.eval_children = lambda x: -x
        self.smt_function = lambda x: -x

class MulFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('*', -1, (exprtypes.IntType(), ), exprtypes.IntType())
        self.eval_children = lambda *cs: functools.reduce(lambda x,y: x*y, cs, 1)
        self.smt_function = z3.Product
        self.commutative = True
        self.associative = True

class DivFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('div', 2, (exprtypes.IntType(), exprtypes.IntType()), exprtypes.IntType())
        def eval_c(a, b):
            if b != 0:
                return a // b
            else:
                raise basetypes.PartialFunctionError
        self.eval_children = eval_c
        self.smt_function = lambda a, b : a / b

class LEFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('<=', 2, (exprtypes.IntType(), exprtypes.IntType()), exprtypes.BoolType())
        self.eval_children = lambda a, b : a <= b
        self.smt_function = lambda a, b : a <= b

class LTFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('<', 2, (exprtypes.IntType(), exprtypes.IntType()), exprtypes.BoolType())
        self.eval_children = lambda a, b : a < b
        self.smt_function = lambda a, b : a < b

class GEFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('>=', 2, (exprtypes.IntType(), exprtypes.IntType()), exprtypes.BoolType())
        self.eval_children = lambda a, b : a >= b
        self.smt_function = lambda a, b : a >= b

class GTFunction(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('>', 2, (exprtypes.IntType(), exprtypes.IntType()), exprtypes.BoolType())
        self.eval_children = lambda a, b : a > b
        self.smt_function = lambda a, b : a > b

class LIAInstantiator(semantics_types.InstantiatorBase):
    def __init__(self):
        super().__init__('lia')
        self.add_instance = None
        self.mul_instance = None

    def _get_add_instance(self):
        if (self.add_instance == None):
            self.add_instance = AddFunction()
        return self.add_instance

    def _get_mul_instance(self):
        if (self.mul_instance == None):
            self.mul_instance = MulFunction()
        return self.mul_instance

    def _get_canonical_function_name(self, function_name):
        if (function_name == '+' or function_name == 'add'):
            return 'add'
        elif (function_name == '-' or function_name == 'sub'):
            return function_name
        elif (function_name == '*' or function_name == 'mul'):
            return 'mul'
        elif (function_name == '/' or function_name == 'div'):
            return 'div'
        elif (function_name == 'le' or function_name == '<='):
            return 'le'
        elif (function_name == 'ge' or function_name == '>='):
            return 'ge'
        elif (function_name == 'lt' or function_name == '<'):
            return 'lt'
        elif (function_name == 'gt' or function_name == '>'):
            return 'gt'
        else:
            return function_name

    def _do_instantiation(self, function_name, mangled_name, arg_types):
        function_name = self._get_canonical_function_name(function_name)
        if (function_name == 'add' or function_name == 'mul'):
            if (len(arg_types) < 2 or
                (not self._is_all_of_type(arg_types, exprtypes.TypeCodes.integer_type))):
                self._raise_failure(function_name, arg_types)

            if (function_name == 'add'):
                return self._get_add_instance()
            else:
                return self._get_mul_instance()

        elif function_name in [ 'div', 'sub', 'mod' ] or \
                (function_name == '-' and len(arg_types) == 2):
            if (len(arg_types) != 2 or
                (not self._is_all_of_type(arg_types, exprtypes.TypeCodes.integer_type))):
                self._raise_failure(function_name, arg_types)

            if (function_name == 'div'):
                return DivFunction()
            elif function_name == 'sub' or function_name == '-':
                return SubFunction()
            elif function_name == 'mod':
                return ModFunction()
            else:
                raise NotImplementedError

        elif (function_name == '-'):
            if (len(arg_types) != 1 or arg_types[0].type_code != exprtypes.TypeCodes.integer_type):
                self._raise_failure(function_name, arg_types)
            return MinusFunction()

        elif (function_name == 'le' or function_name == 'ge' or
              function_name == 'gt' or function_name == 'lt'):
            if (len(arg_types) != 2 or
                (not self._is_all_of_type(arg_types, exprtypes.TypeCodes.integer_type))):
                self._raise_failure(function_name, arg_types)

            if (function_name == 'le'):
                return LEFunction()
            elif (function_name == 'ge'):
                return GEFunction()
            elif (function_name == 'lt'):
                return LTFunction()
            else:
                return GTFunction()
        else:
            return None
#
# semantics_lia.py ends here
