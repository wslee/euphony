#!/usr/bin/env python3
# exprtypes.py ---
#
# Filename: exprtypes.py
# Author: Abhishek Udupa
# Created: Tue Aug 18 12:58:59 2015 (-0400)
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

"""Defines a type class and a set of types commonly used"""

from utils import basetypes
from enum import IntEnum
from utils import utils

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class TypeCodes(IntEnum):
    """An (extensible) set of type codes. There must be
    (at least) one class deriving from TypeBase for each of these
    type codes."""

    boolean_type = 1
    integer_type = 2
    bit_vector_type = 3
    string_type = 4

_type_id_counter = 0

class TypeBase(object):
    """Base class for all types. Only handles type codes."""

    def __init__(self, type_code):
        global _type_id_counter
        self.type_code = type_code
        self.type_id = _type_id_counter
        _type_id_counter += 1

    def __str__(self):
        raise basetypes.AbstractMethodError('TypeBase.__str__()')

    def __repr__(self):
        raise basetypes.AbstractMethodError('TypeBase.__repr__()')

    def get_smt_type(self, smt_context_object):
        raise basetypes.AbstractMethodError('TypeBase.get_smt_type()')


class _BoolType(TypeBase):
    """A Boolean Type."""

    def __init__(self):
        super().__init__(TypeCodes.boolean_type)

    def __str__(self):
        return 'BooleanType'

    def __repr__(self):
        return 'BooleanType'

    def __hash__(self):
        return hash(TypeCodes.boolean_type)

    def get_smt_type(self, smt_context_object):
        return smt_context_object.make_bool_sort()

    def print_string(self):
        return 'Bool'

_boolean_type_instance = _BoolType()

def BoolType():
    return _boolean_type_instance

class _StringType(TypeBase):
    """A String Type."""

    def __init__(self):
        super().__init__(TypeCodes.string_type)

    def __str__(self):
        return 'StringType'

    def __repr__(self):
        return 'StringType'

    def __hash__(self):
        return hash(TypeCodes.string_type)

    def get_smt_type(self, smt_context_object):
        return smt_context_object.make_string_sort()

    def print_string(self):
        return 'String'

_string_type_instance = _StringType()

def StringType():
    return _string_type_instance

class _IntType(TypeBase):
    """An Integer Type."""

    def __init__(self):
        super().__init__(TypeCodes.integer_type)

    def __str__(self):
        return 'IntegerType'

    def __repr__(self):
        return 'IntegerType'

    def __hash__(self):
        return hash(TypeCodes.integer_type)

    def get_smt_type(self, smt_context_object):
        return smt_context_object.make_int_sort()

    def print_string(self):
        return 'Int'

_integer_type_instance = _IntType()

def IntType():
    return _integer_type_instance


class _BitVectorType(TypeBase):
    """A (parametrized) bit vector type"""

    def __init__(self, size):
        assert(size > 0)
        super().__init__(TypeCodes.bit_vector_type)
        self.size = size

    def __str__(self):
        return ('(BitVectorType %d)' % self.size)

    def __repr__(self):
        return self.__str__()

    def __hash__(self):
        return (hash(TypeCodes.bit_vector_type) ^
                hash(self.size))

    def get_smt_type(self, smt_context_object):
        return smt_context_object.make_bitvector_sort(self.size)

    def __eq__(self, other):
        if (not isinstance(other, _BitVectorType)):
            return False
        return (other.size == self.size)

    def __ne__(self, other):
        return (not self.__eq__(other))

    def get_size(self):
        return self.size

    def print_string(self):
        return '(BitVec %d)' % self.size

_bitvector_type_intern_dict = {}

def BitVectorType(size):
    if size not in _bitvector_type_intern_dict:
        _bitvector_type_intern_dict[size] = _BitVectorType(size)
    return _bitvector_type_intern_dict[size]

#
# exprtypes.py ends here
