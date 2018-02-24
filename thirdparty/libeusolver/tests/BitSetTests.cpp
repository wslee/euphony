// BitSetTests.cpp ---
//
// Filename: BitSetTests.cpp
// Author: Abhishek Udupa
// Created: Thu Oct 15 15:00:10 2015 (-0400)
//
//
// Copyright (c) 2015, Abhishek Udupa, University of Pennsylvania
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software
//    must display the following acknowledgement:
//    This product includes software developed by The University of Pennsylvania
// 4. Neither the name of the University of Pennsylvania nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//

// Code:

#include "../src/BitSet.hpp"
#include <assert.h>
#include <vector>

typedef eusolver::u64 u64;

static inline void run_bitset_tests(eusolver::BitSet* bitset)
{
    (*bitset)[0] = true;
    bitset->set_bit(3);
    bitset->insert(5);

    // test constructors and assignment
    eusolver::BitSet copy(*bitset);
    assert(copy == *bitset);
    assert(copy.flip_bit(5) == true);
    assert(bitset->test_bit(5) == true);
    assert(copy != *bitset);

    std::vector<u64> elem_vec;
    for (auto elem : *bitset) {
        elem_vec.push_back(elem);
    }

    assert(elem_vec.size() == 3);
    assert(elem_vec[0] == 0);
    assert(elem_vec[1] == 3);
    assert(elem_vec[2] == 5);

    // comparisons
    assert(*bitset >= copy);
    assert(*bitset > copy);

    assert(copy <= *bitset);
    assert(copy < *bitset);

    copy.flip_bit(5);
    assert(*bitset >= copy);
    assert(copy <= *bitset);
    assert(!(copy < *bitset));
    assert(!(*bitset < copy));

    assert(!bitset->is_disjoint_from(copy));
    copy.clear_all();
    assert(bitset->is_disjoint_from(copy));

    assert(copy.length() == 0);
    assert(bitset->length() == 3);

    assert(!bitset->is_empty());
    assert(!bitset->is_full());

    assert(!copy.is_full());
    assert(copy.is_empty());
}

int main()
{
    auto bitset_a = new eusolver::BitSet(96);
    run_bitset_tests(bitset_a);

    eusolver::BitSet bitset_b(1);
    bitset_b.set_bit(0);
    assert(bitset_b.is_full());
}

//
// BitSetTests.cpp ends here
