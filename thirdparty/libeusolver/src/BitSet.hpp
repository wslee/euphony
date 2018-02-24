// BitSet.hpp ---
//
// Filename: BitSet.hpp
// Author: Abhishek Udupa
// Created: Tue Sep 29 14:58:46 2015 (-0400)
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

#if !defined EUSOLVER_BITSET_HPP_
#define EUSOLVER_BITSET_HPP_

#include <string>
#include <utility>
#include <cstring>
#include <cstdlib>
#include <exception>
#include <iterator>

#include "EUSolverTypes.h"

namespace eusolver {

class BitSetException : public std::exception
{
private:
    std::string m_exception_info;

public:
    BitSetException() noexcept;
    BitSetException(const BitSetException& other) noexcept;
    BitSetException(BitSetException&& other) noexcept;
    BitSetException(const std::string& exception_info) noexcept;
    virtual ~BitSetException() noexcept;
    BitSetException& operator = (const BitSetException& other) noexcept;
    BitSetException& operator = (BitSetException&& other) noexcept;
    const std::string& get_exception_info() const noexcept;
    virtual const char* what() const noexcept override;
};

class BitSet
{
private:
    typedef u64 WordType;
    struct HashStruct
    {
        bool m_hash_valid : 1;
        u64 m_hash_value : 63;
    };

    static_assert(sizeof(WordType) <= 8,
                  "WordType in BitSet must be <= 8 bytes");

    // helper functions for determining sizes, etc.
    static constexpr u64 internal_rep_length()
    {
        return (sizeof(WordType*) + sizeof(HashStruct));
    }

    static constexpr u64 bits_per_byte() { return 8; }
    static constexpr u64 bytes_per_word() { return sizeof(WordType); }
    static constexpr u64 bits_per_word() { return (bits_per_byte() * bytes_per_word()); }
    static constexpr u64 num_words_for_bits(u64 num_bits)
    {
        return ((u64)((num_bits + (bits_per_word() - 1)) / bits_per_word()));
    }

    static constexpr WordType all_ones_mask()
    {
        return (~((WordType)0));
    }

    u64 m_size_of_universe;
    static constexpr u64 sc_internal_bitvec_num_bytes = sizeof(WordType*) + sizeof(HashStruct);
    static constexpr u64 sc_internal_bitvec_num_words =
        sc_internal_bitvec_num_bytes / sizeof(WordType);
    static constexpr u64 sc_preallocated_num_bits =
        sc_internal_bitvec_num_words * sizeof(WordType) * 8;

    union {
        WordType m_internal_bits[sc_internal_bitvec_num_words];
        struct {
            WordType* m_bit_vector;
            HashStruct m_hash_object;
        } m_external_bits;
    } m_set_object;


    // Inner types
    class BitRef
    {
    private:
        BitSet* m_bitset_ptr;
        u64 m_bit_position;

    public:
        BitRef();
        BitRef(const BitRef& other);
        BitRef(BitRef&& other);
        BitRef(BitSet* bitset_ptr, u64 bit_position);
        ~BitRef();
        BitRef& operator = (const BitRef& other);
        BitRef& operator = (BitRef&& other);
        BitRef& operator = (bool value);
        operator bool () const;
        bool operator == (const BitRef& other) const;
        bool operator != (const BitRef& other) const;
        bool operator == (bool value) const;
        bool operator != (bool value) const;
        bool operator ! () const;
    };

    // helper and utility functions
    inline void allocate(u64 size_of_universe);
    inline void initialize(bool initial_value);
    inline void initialize(const BitSet& other);
    inline void check_out_of_bounds(u64 bit_position) const;
    inline WordType* get_bitvec_ptr();
    inline const WordType* get_bitvec_ptr() const;
    inline void invalidate_hash();

    // static private helper methods
    static inline WordType construct_mask(u64 bit_position);
    static inline void check_equality_of_universes(const BitSet* bitset1,
                                                   const BitSet* bitset2);
    static inline void negate_bitset(const BitSet* bitset, BitSet* result);

    template <typename Fun>
    static inline void apply_binary_function_on_bitsets(const BitSet* bitset1,
                                                        const BitSet* bitset2,
                                                        BitSet* result)
    {
        check_equality_of_universes(bitset1, bitset2);
        auto const len = num_words_for_bits(bitset1->m_size_of_universe);
        auto src_ptr1 = bitset1->get_bitvec_ptr();
        auto src_ptr2 = bitset2->get_bitvec_ptr();
        auto dst_ptr = result->get_bitvec_ptr();
        Fun fun;

        for (u64 i = 0; i < len; ++i) {
            *dst_ptr = fun(*src_ptr1, *src_ptr2);
            ++src_ptr1;
            ++src_ptr2;
            ++dst_ptr;
        }
        result->invalidate_hash();
        return;
    }

    static inline void and_with_negated_second_bitsets(const BitSet* bitset1,
                                                       const BitSet* bitset2,
                                                       BitSet* result);
    static inline void and_bitsets(const BitSet* bitset1,
                                   const BitSet* bitset2,
                                   BitSet* result);
    static inline void or_bitsets(const BitSet* bitset1,
                                  const BitSet* bitset2,
                                  BitSet* result);
    static inline void xor_bitsets(const BitSet* bitset1,
                                   const BitSet* bitset2,
                                   BitSet* result);

public:
    class ConstIterator : public std::iterator<std::bidirectional_iterator_tag,
                                               const u64, i64, const u64*, const u64&>
    {
        friend BitSet;
    private:
        const BitSet* m_bitset;
        i64 m_bit_position;

    public:
        ConstIterator();
        ConstIterator(const ConstIterator& other);
        ConstIterator(const BitSet* bitset, u64 bit_position);
        ~ConstIterator();

        ConstIterator& operator = (const ConstIterator& other);

        bool operator == (const ConstIterator& other) const;
        bool operator != (const ConstIterator& other) const;

        u64 operator * () const;

        ConstIterator& operator ++ ();
        ConstIterator operator ++ (int unused);
        ConstIterator& operator -- ();
        ConstIterator operator -- (int unused);
    };

    typedef ConstIterator Iterator;
    typedef Iterator iterator;
    typedef Iterator const_iterator;

public:
    BitSet();
    BitSet(const BitSet& other);
    BitSet(BitSet&& other);
    explicit BitSet(u64 size_of_universe);
    BitSet(u64 size_of_universe, bool initial_value);
    ~BitSet();
    BitSet& operator = (const BitSet& other);
    BitSet& operator = (BitSet&& other);
    bool operator == (const BitSet& other) const;
    bool operator != (const BitSet& other) const;
    // is this a proper subset of other?
    bool operator < (const BitSet& other) const;
    // is this a subset of other?
    bool operator <= (const BitSet& other) const;
    // is this a proper superset of other?
    bool operator > (const BitSet& other) const;
    // is this a superset of other?
    bool operator >= (const BitSet& other) const;

    bool is_disjoint_from(const BitSet& other) const;
    bool is_disjoint_from(const BitSet* other) const;

    void set_bit(u64 bit_num);
    void clear_bit(u64 bit_num);
    bool test_bit(u64 bit_num) const;
    // returns the value of the bit BEFORE the flip
    bool flip_bit(u64 bit_num);
    // gang set
    void set_all();
    // gang clear
    void clear_all();
    // gang flip
    void flip_all();
    u64 get_size_of_universe() const;
    u64 length() const;
    u64 size() const;
    bool is_full() const;
    bool is_empty() const;

    BitSet operator & (const BitSet& other) const;
    BitSet operator | (const BitSet& other) const;
    BitSet operator ^ (const BitSet& other) const;
    BitSet operator ~ () const;
    BitSet operator ! () const;
    BitSet operator - (const BitSet& other) const;

    BitSet& operator &= (const BitSet& other);
    BitSet& operator |= (const BitSet& other);
    BitSet& operator ^= (const BitSet& other);
    BitSet& operator -= (const BitSet& other);

    // pointer based methods
    BitSet* intersection_with(const BitSet* other) const;
    void intersect_with_in_place(const BitSet* other);
    BitSet* union_with(const BitSet* other) const;
    void union_with_in_place(const BitSet* other);
    BitSet* symmetric_difference_with(const BitSet* other) const;
    void symmetric_difference_with_in_place(const BitSet* other);
    BitSet* negate() const;
    void negate_in_place();
    BitSet* difference_with(const BitSet* other) const;
    void difference_with_in_place(const BitSet* other);

    // STL vector interface, but with fixed size
    bool operator [] (u64 bit_num) const;
    BitRef operator [] (u64 bit_num);
    bool at(u64 bit_num) const;
    BitRef at(u64 bit_num);

    // STL set interface
    Iterator begin() const;
    Iterator end() const;
    void erase(u64 bit_num);
    void erase(const Iterator& position);
    void insert(u64 bit_num);
    void clear();

    // interface for iterators (and possibly clients to use)
    i64 get_next_element_greater_than_or_equal_to(u64 position) const;
    i64 get_next_element_greater_than(u64 position) const;
    i64 get_prev_element_lesser_than_or_equal_to(u64 position) const;
    i64 get_prev_element_lesser_than(u64 position) const;

    // copy in bits from another bitset
    void copy_in(const BitSet* other);
    void copy_in(const BitSet& other);

    u64 hash() const;

    std::string to_string() const;
    BitSet* clone() const;
};

} /* end namespace eusolver */

#endif /* EUSOLVER_BITSET_HPP_ */

//
// BitSet.hpp ends here
