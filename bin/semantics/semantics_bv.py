#!/usr/bin/env python3
# semantics_bv.py ---
#
# Filename: semantics_bv.py
# Author: Abhishek Udupa
# Created: Tue Sep  1 12:39:38 2015 (-0400)
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
from exprs import exprtypes
from utils import utils
import z3
from semantics import semantics_types
from semantics.semantics_types import InterpretedFunctionBase

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

'''
All functions and semantics should match the file at 
http://smtlib.cs.uiowa.edu/Logics/QF_BV.smt2 downloaded on
Mon, 06 Jun 2016 10:01:57 -0400

File header:
 :smt-lib-version 2.5
 :written-by "Silvio Ranise, Cesare Tinelli, and Clark Barrett"
 :date "2010-05-02"
 :last-updated "2015-04-25"
'''

'''
class BVConcat(InterpretedFunctionBase):
    def __init__(self, size1, size2):
        super().__init__('concat', 2, (exprtypes.BitVectorType(size1),
                                       exprtypes.BitVectorType(size2)),
                         exprtypes.BitVectorType(size1 + size2))
        self.smt_function = z3.Concat
        self.eval_children = lambda a, b: a.concat(b)

class BVExtract(InterpretedFunctionBase):
    def __init__(self, start_offset, end_offset, bv_size):
        super().__init__('extract', 1, (exprtypes.BitVectorType(bv_size),),
                         exprtypes.BitVectorType(end_offset - start_offset + 1))

        self.start_offset = start_offset
        self.end_offset = end_offset
        self.mangled_function_name = 'extract_%d_%d_%d' % (start_offset, end_offset,
                                                           self.domain_types[0].type_code)

    def to_smt(self, expr_object, smt_context_object, var_subst_map):
        child_terms = self._children_to_smt(expr_object, smt_context_object, var_subst_map)
        return z3.Extract(end_offset, start_offset, child_terms[0])

    def evaluate(self, expr_object, eval_context_object):
        self._evaluate_children(expr_object, eval_context_object)
        mask = (1 << (self.end_offset - self.start_offset + 1)) - 1
        if (self.start_offset > 0):
            mask = mask << self.start_offset
        res = eval_context_object.peek() & mask
        eval_context_object.pop()
        eval_context_object.push(mask)
'''

class BVNot(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvnot', 1, (exprtypes.BitVectorType(bv_size),),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a : ~a
        self.eval_children = lambda a : ~a

class BVAnd(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvand', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a,b: a & b
        self.eval_children = lambda a,b: a & b
        self.commutative = True
        self.associative = True

class BVOr(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvor', 2, (exprtypes.BitVectorType(bv_size),
                                    exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a,b: a | b
        self.eval_children = lambda a,b: a | b
        self.commutative = True
        self.associative = True

class BVNeg(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvneg', 1, (exprtypes.BitVectorType(bv_size),),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a: -a
        self.eval_children = lambda a: a.negate()

class BVAdd(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvadd', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a,b: a + b
        self.eval_children = lambda a,b: a + b
        self.commutative = True
        self.associative = True

class BVMul(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvmul', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a,b: a * b
        self.eval_children = lambda a,b: a * b
        self.commutative = True
        self.associative = True

class BVSub(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvsub', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a,b: a - b
        self.eval_children = lambda a,b: a - b

class BVUDiv(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvudiv', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = z3.UDiv
        def eval_c(a, b):
            if b.value == 0:
                raise basetypes.PartialFunctionError()
            return a.udiv(b)
        self.eval_children = eval_c

class BVSDiv(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvsdiv', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a,b : a / b
        def eval_c(a, b):
            if b.value == 0:
                raise basetypes.PartialFunctionError()
            return a.sdiv(b)
        self.eval_children = eval_c

class BVSRem(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvsrem', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = z3.SRem
        def eval_c(a, b):
            if b.value == 0:
                raise basetypes.PartialFunctionError()
            return a.srem(b)
        self.eval_children = eval_c



class BVURem(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvurem', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = z3.URem
        def eval_c(a, b):
            if b.value == 0:
                raise basetypes.PartialFunctionError()
            return a.urem(b)
        self.eval_children = eval_c

class BVShl(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvshl', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a, b : a << b
        self.eval_children = lambda a, b : a << b

class BVLShR(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvlshr', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = z3.LShR
        self.eval_children = lambda a, b : a.lshr(b)

class BVAShR(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvashr', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a, b: a >> b
        self.eval_children = lambda a, b : a.ashr(b)

class BVUlt(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvult', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = z3.ULT
        self.eval_children = lambda a, b : a.ult(b)

class BVUle(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvule', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = z3.ULE
        self.eval_children = lambda a, b : a.ule(b)

class BVUge(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvuge', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = z3.UGE
        self.eval_children = lambda a, b : a.uge(b)

class BVUgt(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvugt', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = z3.UGT
        self.eval_children = lambda a, b : a.ugt(b)

class BVSle(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvsle', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = lambda a, b : a <= b
        self.eval_children = lambda a, b : a.sle(b)

class BVSlt(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvslt', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = lambda a, b : a < b
        self.eval_children = lambda a, b : a.slt(b)

class BVSge(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvsge', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = lambda a, b : a >= b
        self.eval_children = lambda a, b : a.sge(b)

class BVSgt(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvsgt', 2, (exprtypes.BitVectorType(bv_size),
                                     exprtypes.BitVectorType(bv_size)),
                         exprtypes.BoolType())
        self.smt_function = lambda a, b : a > b
        self.eval_children = lambda a, b : a.sgt(b)

class BVXor(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvxor', 2, (exprtypes.BitVectorType(bv_size),
                                    exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a, b : a ^ b
        self.eval_children = lambda a, b : a ^ b
        self.commutative = True
        self.associative = True

class BVXNor(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvxnor', 2, (exprtypes.BitVectorType(bv_size),
                                    exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a, b : ~(a ^ b)
        self.eval_children = lambda a, b : ~(a ^ b)
        self.commutative = True
        self.associative = True

class BVNand(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvnand', 2, (exprtypes.BitVectorType(bv_size),
                                    exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a, b : ~(a & b)
        self.eval_children = lambda a, b : ~(a & b)
        self.commutative = True
        self.associative = True

class BVNor(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvnor', 2, (exprtypes.BitVectorType(bv_size),
                                    exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(bv_size))
        self.smt_function = lambda a, b : ~(a | b)
        self.eval_children = lambda a, b : ~(a | b)
        self.commutative = True
        self.associative = True

class BVComp(InterpretedFunctionBase):
    def __init__(self, bv_size):
        super().__init__('bvcomp', 2, (exprtypes.BitVectorType(bv_size),
                                    exprtypes.BitVectorType(bv_size)),
                         exprtypes.BitVectorType(1))
        self.smt_function = lambda a, b : z3.If(a == b, z3.BitVecVal(1, 1), z3.BitVecVal(0, 1))
        self.eval_children = lambda a, b : a.bvcomp(b)
        self.commutative = True
        self.associative = True

class BVInstantiator(semantics_types.InstantiatorBase):
    def __init__(self):
        super().__init__('bv')
        self.instances = {}

    def _get_instance(self, function_name, bv_size):
        if function_name not in self.instances:
            if function_name == 'bvnot':
                self.instances[(function_name, bv_size)] = BVNot(bv_size)
            elif function_name == 'bvand':
                self.instances[(function_name, bv_size)] = BVAnd(bv_size)
            elif function_name == 'bvor':
                self.instances[(function_name, bv_size)] = BVOr(bv_size)
            elif function_name == 'bvxor':
                self.instances[(function_name, bv_size)] = BVXor(bv_size)
            elif function_name == 'bvadd':
                self.instances[(function_name, bv_size)] = BVAdd(bv_size)
            elif function_name == 'bvsub':
                self.instances[(function_name, bv_size)] = BVSub(bv_size)
            elif function_name == 'bvlshr':
                self.instances[(function_name, bv_size)] = BVLShR(bv_size)
            elif function_name == 'bvshl':
                self.instances[(function_name, bv_size)] = BVShl(bv_size)
            elif function_name == 'bvule':
                self.instances[(function_name, bv_size)] = BVUle(bv_size)
            elif function_name == 'bvsge':
                self.instances[(function_name, bv_size)] = BVSge(bv_size)
            elif function_name == 'bvsle':
                self.instances[(function_name, bv_size)] = BVSle(bv_size)
            elif function_name == 'bvneg':
                self.instances[(function_name, bv_size)] = BVNeg(bv_size)
            elif function_name == 'bvmul':
                self.instances[(function_name, bv_size)] = BVMul(bv_size)
            elif function_name == 'bvudiv':
                self.instances[(function_name, bv_size)] = BVUDiv(bv_size)
            elif function_name == 'bvurem':
                self.instances[(function_name, bv_size)] = BVURem(bv_size)
            elif function_name == 'bvashr':
                self.instances[(function_name, bv_size)] = BVAShR(bv_size)
            elif function_name == 'bvsdiv':
                self.instances[(function_name, bv_size)] = BVSDiv(bv_size)
            elif function_name == 'bvsrem':
                self.instances[(function_name, bv_size)] = BVSRem(bv_size)
            else:
                self._raise_failure(function_name, [])
        return self.instances[(function_name, bv_size)]

    def _get_canonical_function_name(self, function_name):
        return function_name

    def is_unary(self, function_name):
        return function_name in [ 'bvnot', 'bvneg' ]

    def is_binary_of_identical_lengths(self, function_name):
        return function_name in [ 'bvand',
                'bvor',
                'bvxor',
                'bvadd',
                'bvmul',
                'bvudiv',
                'bvsdiv',
                'bvsrem',
                'bvurem',
                'bvashr',
                'bvsub',
                'bvlshr',
                'bvshl',
                'bvule',
                'bvsge',
                'bvsle' ]

    def _do_instantiation(self, function_name, mangled_name, arg_types):
        if self.is_unary(function_name):
            if (len(arg_types) != 1 or
                    (not self._is_all_of_type(arg_types, exprtypes.TypeCodes.bit_vector_type))):
                self._raise_failure(function_name, arg_types)
            bv_size = arg_types[0].size
            return self._get_instance(function_name, bv_size)

        elif self.is_binary_of_identical_lengths(function_name):
            if (len(arg_types) != 2 or
                    (not self._is_all_of_type(arg_types, exprtypes.TypeCodes.bit_vector_type))):
                self._raise_failure(function_name, arg_types)
            bv_size = arg_types[0].size
            return self._get_instance(function_name, bv_size)

        else:
            return None

#
# semantics_bv.py ends here
