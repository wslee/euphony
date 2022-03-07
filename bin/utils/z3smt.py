#!/usr/bin/env python3
# z3smt.py ---
#
# Filename: z3smt.py
# Author: Abhishek Udupa
# Created: Thu Aug 20 17:57:12 2015 (-0400)
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

import z3
from utils import utils
from exprs import exprs
from exprs import exprtypes
from utils.bitvectors import BitVector

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class Z3SMTContext(object):
    """A simple wrapper around the z3.Context class."""
    def __init__(self, *args, **kwargs):
        # z3.set_param(auto_config=False)
        # http://stackoverflow.com/questions/18770582/z3-offering-random-solutions-in-solving
        # z3.set_param('smt.phase_selection',0)
        # z3.set_param('smt.random_seed',0)
        import os
        z3.init(os.getenv('Z3_LIBRARY_PATH', '.'))
        self.context_obj = z3.Context(*args, **kwargs)
        self.interpretation_map = {}
        self.solvers = []

    def ctx(self):
        return self.context_obj

    def ref(self):
        return self.context_obj.ref()

    def make_solver(self):
        ret = z3.Solver(ctx=self.ctx())
        self.solvers.append(ret)
        return ret

    def interrupt(self):
        self.context_obj.interrupt()

    def make_bool_sort(self):
        return z3.BoolSort(self.ctx())

    def make_int_sort(self):
        return z3.IntSort(self.ctx())

    def make_string_sort(self):
        return z3.StringSort(self.ctx())

    def make_bitvector_sort(self, size):
        return z3.BitVecSort(size, self.ctx())

    def set_interpretation(self, unknown_function_or_unknown_function_id, interpretation):
        if type(unknown_function_or_unknown_function_id) != int:
            unknown_function_id = unknown_function_or_unknown_function_id.unknown_function_id
        else:
            unknown_function_id = unknown_function_or_unknown_function_id
        self.interpretation_map[unknown_function_id] = interpretation


def z3value_to_value(value, var_info):
    if (var_info.variable_type == exprtypes.BoolType()):
        return exprs.Value(bool(value), exprtypes.BoolType())
    elif (var_info.variable_type == exprtypes.IntType()):
        # TODO: Why are these int(str(value)) instead of value.as_long()
        return exprs.Value(int(str(value)), exprtypes.IntType())
    elif (var_info.variable_type.type_code == exprtypes.TypeCodes.bit_vector_type):
        return exprs.Value(BitVector(int(str(value)),
                                         var_info.variable_type.size),
                               var_info.variable_type)
    else:
        raise basetypes.UnhandledCaseError('solvers.In model_to_point')

#
# z3smt.py ends here
