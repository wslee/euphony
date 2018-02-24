#!/usr/bin/env python3
# semantics_slia.py ---
# Filename: semantics_slia.py
# Author: Arjun Radhakrishna
# Created: Sun, 05 Jun 2016 11:49:06 -0400
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

from semantics import semantics_types
from semantics import semantics_lia
from semantics.semantics_types import InterpretedFunctionBase
from exprs import exprtypes
from utils import utils
import z3

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class StrConcat(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.++', 2,
                (exprtypes.StringType(), exprtypes.StringType()),
                exprtypes.StringType())
        # self.smt_function = z3.Concat
        self.eval_children = str.__add__

class StrReplace(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.replace', 3,
                (exprtypes.StringType(), exprtypes.StringType(), exprtypes.StringType()),
                exprtypes.StringType())
        self.smt_function = z3.Replace
        self.eval_children = lambda a,b,c: str.replace(a, b, c, 1)

class StrAt(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.at', 2,
                (exprtypes.StringType(), exprtypes.IntType()),
                exprtypes.StringType())
        # self.smt_function = lambda a,b: a[b]
        self.eval_children = lambda a,b: a[b] if 0 <= b < len(a) else ''

class IntToStr(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('int.to.str', 1,
                (exprtypes.IntType(),),
                exprtypes.StringType())
        # self.smt_function = z3.Itos
        self.eval_children = lambda a : str(a) if a >= 0 else ''

class Substr(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.substr', 3,
                (exprtypes.StringType(), exprtypes.IntType(), exprtypes.IntType()),
                exprtypes.StringType())
        # self.smt_function = z3.Extract

        def substr(string, start, offset):
            if start < 0 or offset < 0:
                return ''
            elif start + offset > len(string):
                return string[start:]
            else:
                return string[start:(start+offset)]

        self.eval_children = lambda a,b,c: substr(a,b,c)

class StrLen(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.len', 1,
                (exprtypes.StringType(),),
                exprtypes.IntType())
        # self.smt_function = z3.Length
        self.eval_children = lambda a: len(a)

class StrToInt(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.to.int', 1,
                (exprtypes.StringType(),),
                exprtypes.IntType())
        # self.smt_function = z3.Stoi
        def eval_c(a):
            try:
                if all(map(lambda x: '0' <= x <= '9', a)):
                    return int(a)
                else:
                    return -1
            except ValueError:
                return -1
        self.eval_children = eval_c

class StrIndexOf(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.indexof', 3,
                (exprtypes.StringType(), exprtypes.StringType(), exprtypes.IntType()),
                exprtypes.IntType())
        # self.smt_function = z3.IndexOf
        self.eval_children = str.find

class StrPrefixOf(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.prefixof', 2,
                (exprtypes.StringType(), exprtypes.StringType()),
                exprtypes.BoolType())
        # self.smt_function = z3.PrefixOf
        # self.eval_children = str.startswith
        self.eval_children = lambda a,b: str.startswith(b,a)

class StrSuffixOf(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.suffixof', 2,
                (exprtypes.StringType(), exprtypes.StringType()),
                exprtypes.BoolType())
        # self.smt_function = z3.SuffixOf
        # self.eval_children = str.endswith
        self.eval_children = lambda a, b: str.endswith(b, a)

class StrContains(InterpretedFunctionBase):
    def __init__(self):
        super().__init__('str.contains', 2,
                (exprtypes.StringType(), exprtypes.StringType()),
                exprtypes.BoolType())
        # self.smt_function = z3.Contains
        self.eval_children = lambda a,b: str.find(a,b) != -1

class SLIAInstantiator(semantics_types.InstantiatorBase):
    def __init__(self):
        super().__init__('slia')
        self.lia_instantiator = semantics_lia.LIAInstantiator()
        self.function_types = {
                'str.++': (exprtypes.StringType(), exprtypes.StringType()),
                'str.replace': (exprtypes.StringType(), exprtypes.StringType(), exprtypes.StringType()),
                'str.at': (exprtypes.StringType(), exprtypes.IntType()),
                'int.to.str': (exprtypes.IntType(), ),
                'str.substr': (exprtypes.StringType(), exprtypes.IntType(), exprtypes.IntType()),
                'str.len': (exprtypes.StringType(), ),
                'str.to.int': (exprtypes.StringType(), ),
                'str.indexof': (exprtypes.StringType(), exprtypes.StringType(), exprtypes.IntType()),
                'str.prefixof': (exprtypes.StringType(), exprtypes.StringType()),
                'str.suffixof': (exprtypes.StringType(), exprtypes.StringType()),
                'str.contains': (exprtypes.StringType(), exprtypes.StringType())
                }
        self.function_instances = {
                'str.++': StrConcat(),
                'str.replace': StrReplace(),
                'str.at': StrAt(),
                'int.to.str': IntToStr(),
                'str.substr': Substr(),
                'str.len': StrLen(),
                'str.to.int': StrToInt(),
                'str.indexof': StrIndexOf(),
                'str.prefixof': StrPrefixOf(),
                'str.suffixof': StrSuffixOf(),
                'str.contains': StrContains()
                }

    def _get_canonical_function_name(self, function_name):
        return function_name

    def _do_instantiation(self, function_name, mangled_name, arg_types):
        lia_func = self.lia_instantiator._do_instantiation(
                function_name,
                mangled_name,
                arg_types)
        if lia_func is not None:
            return lia_func

        if function_name not in self.function_types:
            return None

        # print(function_name)
        assert arg_types == self.function_types[function_name]
        return self.function_instances[function_name]


#
# semantics_slia.py ends here
