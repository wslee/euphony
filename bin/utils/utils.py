#!/usr/bin/env python3
# utils.py ---
#
# Filename: utils.py
# Author: Abhishek Udupa
# Created: Tue Aug 18 12:03:06 2015 (-0400)
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


"""Some utility functions, which are largely self-explanatory"""

import math
import sys
from eusolver import BitSet

def print_module_misuse_and_exit():
    # print('This module is intented for use as a library, and not as a ' +
    #       'standalone program!')
    sys.exit(1)


if __name__ == '__main__':
    pass
    # print_module_misuse_and_exit()


def static_var(varname, value):
    def decorate(func):
        setattr(func, varname, value)
        return func
    return decorate


def is_number_prime(number):
    for i in range(2, math.ceil(math.sqrt(number))):
        if (number % i == 0):
            return False
    return True


def round_to_next_higher_prime(number):
    while (not is_number_prime(number)):
        number += 1
    return number


def partitions(n, k):
    """generate all splits of n into k components. Order
    "of the split components is considered relevant.
    """
    if (n < k):
        raise ValueError('n must be greater than or equal to k in call ' +
                            'to utils.partitions(n, k)')

    cuts = []
    cuts.append(0)
    cuts.append(n-k+1)
    for i in range(k - 1):
      cuts.append(n - k + 1 + i + 1)

    done = False

    while (not done):
        retval = tuple([cuts[i] - cuts[i-1] for i in range(1, k+1)])
        rightmost = 0
        for i in range(1,k):
            if cuts[i] - cuts[i - 1] > 1:
                rightmost = i
                cuts[i] = cuts[i] - 1
                break
        if rightmost == 0:
            done = True
        else:
            accum = 1
            for i in reversed(range(1, rightmost)):
                cuts[i] = cuts[rightmost] - accum
                accum = accum + 1
        yield retval

def is_subsequence_of(iterable1, iterable2):
    """Tests if :iterable1: is a subsequence of :iterable2:."""
    if (len(iterable1) > len(iterable2)):
        return False

    for i in range(len(iterable1)):
        if (iterable1[i] != iterable2[i]):
            return False

    return True

'''
def bitvector_to_string(bitvec_value, bitvec_size):
    if (bitvec_size % 4 == 0):
        format_string = '0%dX' % (bitvec_size / 4)
        prefix_string = '#x'
    else:
        format_string = '0%db' % bitvec_size
        prefix_string = '#b'
    return prefix_string + format(bitvec_value, format_string)
'''
def bitvector_to_string(bitvec_value, bitvec_size):
    return str(bitvec_value)


def all_of(iterable, predicate):
    for elem in iterable:
        if (not predicate(elem)):
            return False
    return True

class UIDGenerator(object):
    def __init__(self):
        self.next_uid = 0

    def get_uid(self):
        r = self.next_uid
        self.next_uid += 1
        return r

    def get_string_uid(self, prefix = ''):
        r = ((prefix + '%s') % self.next_uid)
        self.next_uid += 1
        return r

def bitset_extend(bitset, value):
    assert type(value) == bool
    newset = BitSet(bitset.size_of_universe() + 1)
    newset.copy_in(bitset)
    if value:
        newset.add(bitset.size_of_universe())
    return newset

def timeout(func, args=(), kwargs={}, timeout_duration=1, default=None):
    import signal

    class TimeoutError(Exception):
        pass

    def handler(signum, frame):
        raise TimeoutError()

    # set the timeout handler
    signal.signal(signal.SIGALRM, handler) 
    signal.alarm(timeout_duration)
    try:
        result = func(*args, **kwargs)
    except TimeoutError as exc:
        result = default
    finally:
        signal.alarm(0)

    return result

#
# utils.py ends here

if __name__ == '__main__':
    def f(i):
        import time
        time.sleep(4)
        return i
    t = timeout(f, (42,), timeout_duration = 3, default=None)
    # print(t)
