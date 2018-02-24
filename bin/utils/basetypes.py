#!/usr/bin/env python3
# basetypes.py ---
#
# Filename: basetypes.py
# Author: Abhishek Udupa
# Created: Tue Aug 18 11:13:18 2015 (-0400)
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


"""Implementation of a few basic types used in various contexts"""

from utils import utils

if __name__ == '__main__':
    utils.print_module_misuse_and_exit()

class OptionError(Exception):
    def __init__(self, error_msg):
        self.error_msg = error_msg

    def __str__(self):
        return 'Option Error: ' + self.error_msg

    def __repr__(self):
        return self.__str__()


class ArgumentError(Exception):
    def __init__(self, error_msg):
        self.error_msg = error_msg

    def __str__(self):
        return 'Argument Error: ' + self.error_msg

    def __repr__(self):
        return self.__str__()

class AbstractMethodError(Exception):
    def __init__(self, method_name):
        self.method_name = method_name

    def __str__(self):
        return 'Attempted to call abstract method: ' + self.method_name

    def __repr__(self):
        return self.__str__()

class UnhandledCaseError(Exception):
    def __init__(self, error_msg):
        self.error_msg = error_msg

    def __str__(self):
        return
        """Unhandled case, could be new subclass, or just a non-exhaustive
        pattern/case match. Details: """ + self.error_msg

class PartialFunctionError(Exception):
    def __init__(self):
        pass

class UnboundLetVariableError(Exception):
    def __init__(self):
        pass

#
# basetypes.py ends here
