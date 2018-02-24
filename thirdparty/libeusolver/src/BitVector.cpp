// BitVector.cpp ---
// Filename: BitVector.cpp
// Author: Abhishek Udupa
// Created: Sat Jan 23 19:10:24 2016 (-0500)
//
// Copyright (c) 2016, Abhishek Udupa, University of Pennsylvania
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

#include "BitVector.hpp"
#include <cstring>
#include <cctype>

namespace eusolver {

// Implementation of BitVectorException
BitVectorException::BitVectorException() noexcept
    : m_exception_info("BitVectorException: No information.")
{
    // Nothing here
}

BitVectorException::BitVectorException(const BitVectorException& other) noexcept
    : m_exception_info(other.m_exception_info)
{
    // Nothing here
}

BitVectorException::BitVectorException(BitVectorException&& other) noexcept
    : m_exception_info(std::move(other.m_exception_info))
{
    // Nothing here
}

BitVectorException::BitVectorException(const std::string& exception_info) noexcept
    : m_exception_info((std::string)"BitVectorException: " + exception_info)
{
    // Nothing here
}

BitVectorException::~BitVectorException()
{
    // Nothing here
}

BitVectorException& BitVectorException::operator = (const BitVectorException& other) noexcept
{
    if (&other == this) {
        return *this;
    }
    m_exception_info = other.m_exception_info;
    return *this;
}

BitVectorException& BitVectorException::operator = (BitVectorException&& other) noexcept
{
    if (&other == this) {
        return *this;
    }
    std::swap(m_exception_info, other.m_exception_info);
    return *this;
}

const std::string& BitVectorException::get_exception_info() const noexcept
{
    return m_exception_info;
}

const char* BitVectorException::what() const noexcept
{
    return m_exception_info.c_str();
}


// Implementation of BitVector
// private helper methods
inline BitVector::UWordType* BitVector::get_bitvec_ptr()
{
    if (m_bitvector_size > sc_max_internal_bits) {
        return m_bitvec_object.m_external_bits;
    } else {
        return m_bitvec_object.m_internal_bits;
    }
}

inline const BitVector::UWordType* BitVector::get_bitvec_ptr() const
{
    if (m_bitvector_size > sc_max_internal_bits) {
        return m_bitvec_object.m_external_bits;
    } else {
        return m_bitvec_object.m_internal_bits;
    }
}

inline void BitVector::allocate_cleared_storage()
{
    if (m_bitvector_size > sc_max_internal_bits) {
        auto const num_words = uwords_for_size(m_bitvector_size);
        m_bitvec_object.m_external_bits = (UWordType*)calloc(num_words, sizeof(UWordType));
    } else {
        m_bitvec_object.m_internal_bits[0] = 0;
        m_bitvec_object.m_internal_bits[1] = 0;
    }
}

inline void BitVector::allocate_storage()
{
    if (m_bitvector_size > sc_max_internal_bits) {
        auto const num_words = uwords_for_size(m_bitvector_size);
        m_bitvec_object.m_external_bits = (UWordType*)malloc(num_words * sizeof(UWordType));
    }
}

inline void BitVector::deallocate_storage()
{
    if (m_bitvector_size > sc_max_internal_bits) {
        free(m_bitvec_object.m_external_bits);
        m_bitvec_object.m_external_bits = nullptr;
    }
}

inline void BitVector::clear_storage()
{
    auto const len = uwords_for_size(m_bitvector_size);
    auto bitvec_ptr = get_bitvec_ptr();
    std::memset(bitvec_ptr, 0, len * sizeof(UWordType));
}

inline void BitVector::compute_mask()
{
    auto const bits_in_last_word = m_bitvector_size % bits_per_uword();
    if (bits_in_last_word == 0) {
        m_final_word_mask = (~((UWordType)0));
    } else {
        m_final_word_mask = (((UWordType)1 << bits_in_last_word) - 1);
    }
}

inline void BitVector::mask_final_word()
{
    auto const final_word_index = uwords_for_size(m_bitvector_size) - 1;
    auto bitvec_ptr = get_bitvec_ptr();
    bitvec_ptr[final_word_index] &= m_final_word_mask;
    if (m_bitvector_size <= bits_per_uword()) {
        bitvec_ptr[final_word_index + 1] = 0;
    }
}

inline void BitVector::set_value(u64 value)
{
    UWordType lo_bits = value & ((u64)(~((UWordType)0)));
    UWordType hi_bits = (value >> bits_per_uword());
    auto bitvec_ptr = get_bitvec_ptr();
    bitvec_ptr[0] = lo_bits;
    bitvec_ptr[1] = hi_bits;
    mask_final_word();
}

inline void BitVector::set_value(const BitVector& other)
{
    clear_storage();
    auto const min_bits = std::min(m_bitvector_size, other.m_bitvector_size);
    auto const num_words_to_copy = uwords_for_size(min_bits);
    auto const other_ptr = other.get_bitvec_ptr();
    auto const my_ptr = get_bitvec_ptr();
    memcpy(my_ptr, other_ptr, num_words_to_copy * sizeof(UWordType));
    mask_final_word();
}

inline void BitVector::set_value(BitVector&& other)
{
    if (m_bitvector_size <= sc_max_internal_bits &&
        other.m_bitvector_size <= sc_max_internal_bits) {
        std::swap(m_bitvec_object.m_internal_bits[0], other.m_bitvec_object.m_internal_bits[0]);
        std::swap(m_bitvec_object.m_internal_bits[1], other.m_bitvec_object.m_internal_bits[1]);
    } else if (m_bitvector_size <= sc_max_internal_bits) {
        auto const lo = m_bitvec_object.m_internal_bits[0];
        auto const hi = m_bitvec_object.m_internal_bits[1];

        // swap across fields of unions, using temporaries above.
        m_bitvec_object.m_external_bits = other.m_bitvec_object.m_external_bits;
        other.m_bitvec_object.m_internal_bits[0] = lo;
        other.m_bitvec_object.m_internal_bits[1] = hi;
    } else if (other.m_bitvector_size <= sc_max_internal_bits) {
        auto const lo = other.m_bitvec_object.m_internal_bits[0];
        auto const hi = other.m_bitvec_object.m_internal_bits[1];

        // swap across fields of unions using temporaries above
        other.m_bitvec_object.m_external_bits = m_bitvec_object.m_external_bits;
        m_bitvec_object.m_internal_bits[0] = lo;
        m_bitvec_object.m_internal_bits[1] = hi;
    } else {
        std::swap(m_bitvec_object.m_external_bits, other.m_bitvec_object.m_external_bits);
    }
    std::swap(m_bitvector_size, other.m_bitvector_size);
    std::swap(m_final_word_mask, other.m_final_word_mask);
}

inline u32 BitVector::autodetect_base(const char* value, u32& value_offset, bool& is_negative)
{
    u32 index = 0;
    is_negative = false;
    if (value[index] == '-') {
        is_negative = true;
        ++index;
    }
    if (value[index] == '0' && std::tolower(value[index+1]) == 'b') {
        value_offset = index+2;
        return 2;
    }
    else if (value[index] == '0' && std::tolower(value[index+1]) == 'x') {
        value_offset = index+2;
        return 16;
    }
    else if (value[index] == '0' && std::tolower(value[index+1]) == 'o') {
        value_offset = index+2;
        return 8;
    }
    else if (value[index] == '#' && std::tolower(value[index+1]) == 'b') {
        value_offset = index+2;
        return 2;
    }
    else if (value[index] == '#' && std::tolower(value[index+1]) == 'x') {
        value_offset = index+2;
        return 16;
    } else if (std::isdigit(value[index])) {
        value_offset = index+1;
        return 10;
    }
    else {
        throw BitVectorException((std::string)"Could not autodetect base for bitvector literal: " +
                                 value);
    }
}

inline void BitVector::get_canonical_digit_string(u08* canonical_digits,
                                                  const char* value_string, u32 base)
{
    const char* src_ptr = value_string;
    u08* dst_ptr = canonical_digits;
    while (*src_ptr != '\0') {
        auto c = *src_ptr;
        if (std::isdigit(c)) {
            u32 canon = c - '0';
            if (canon >= base) {
                throw BitVectorException((std::string)"Illegal digits in bitvector literal: " + value_string +
                                         "with base " + std::to_string(base));
            }
            *dst_ptr = canon;
        } else {
            u32 canon = 10 + (std::tolower(c) - 'a');
            if (canon >= base) {
                throw BitVectorException((std::string)"Illegal digits in bitvector literal: " + value_string +
                                         "with base " + std::to_string(base));
            }
            *dst_ptr = canon;
        }
        ++dst_ptr;
    }
    return;
}

inline u32 BitVector::divide_canon_digit_string_by_two(u08* canonical_digits,
                                                       u32 length, u32 base, bool& done)
{
    u32 remainder = 0;
    done = true;

    const u32 limit = length - 1;
    for (u32 i = 0; i < limit; ++i) {
        remainder = canonical_digits[i] % 2;
        canonical_digits[i] >>= 1;
        if (canonical_digits[i] > 0) {
            done = false;
        }
        canonical_digits[i+1] += (base * remainder);
    }
    remainder = canonical_digits[limit] % 2;
    canonical_digits[limit] >>= 1;
    if (canonical_digits[limit] > 1) {
        done = false;
    }
    return remainder;
}

inline void BitVector::set_bit(u32 bit_num)
{
    if (bit_num >= m_bitvector_size) {
        return;
    }

    auto const offset = bit_num / bits_per_uword();
    auto const bit_pos = bit_num % bits_per_uword();

    auto bitvec_ptr = get_bitvec_ptr();
    UWordType mask = (bit_pos == 0 ? 1 : (1 << bit_pos));
    bitvec_ptr[offset] |= mask;
}

inline void BitVector::clear_bit(u32 bit_num)
{
    if (bit_num >= m_bitvector_size) {
        return;
    }

    auto const offset = bit_num / bits_per_uword();
    auto const bit_pos = bit_num % bits_per_uword();

    auto bitvec_ptr = get_bitvec_ptr();
    UWordType mask = (bit_pos == 0 ? 1 : (1 << bit_pos));
    mask = ~mask;
    bitvec_ptr[offset] &= mask;
}

inline bool BitVector::test_bit(u32 bit_num) const
{
    if (bit_num >= m_bitvector_size) {
        return false;
    }

    auto const offset = bit_num / bits_per_uword();
    auto const bit_pos = bit_num % bits_per_uword();

    auto bitvec_ptr = get_bitvec_ptr();
    UWordType mask = (bit_pos == 0 ? 1 : (1 << bit_pos));
    if ((bitvec_ptr[offset] & mask) == 0) {
        return false;
    } else {
        return true;
    }
}

inline void BitVector::set_value_from_string(const char* value, u32 base,
                                             bool is_negative)
{
    clear_storage();
    const u32 num_digits = strlen(value);
    u08* canon_digits = (u08*)malloc(strlen(value) * sizeof(u08));
    get_canonical_digit_string(canon_digits, value, base);
    bool done = false;
    u32 bit_pos = 0;
    do {
        auto rem = divide_canon_digit_string_by_two(canon_digits, num_digits, base, done);
        if (rem != 0) {
            set_bit(bit_pos);
            ++bit_pos;
        }
        if (done && canon_digits[num_digits-1] == 1 && bit_pos < m_bitvector_size) {
            set_bit(bit_pos);
            ++bit_pos;
        }
    } while (!done && bit_pos < m_bitvector_size);
    if (is_negative) {
        make_twos_complement();
    }
}

// base = 0 ==> autodetect base
inline void BitVector::set_value(const std::string& value, u32 base = 0)
{
    u32 actual_value_offset = 0;
    u32 actual_base;
    bool is_negative;
    if (base > 16) {
        throw BitVectorException((std::string)"Only bases upto 16 are currently supported " +
                                 "for bitvector literals");
    }
    if (base == 0) {
        actual_base = autodetect_base(value.c_str(), actual_value_offset, is_negative);
    } else {
        auto const computed_base = autodetect_base(value, value_offset, is_negative);
        actual_base = base;
        if (computed_base != actual_base) {
            throw BitVectorException((std::string)"Inconsistent base " + std::to_string(base) +
                                     " requested for bitvector literal: " + value);
        }
    }

    set_value_from_string(value.c_str() + actual_value_offset, actual_base, is_negative);
}

inline void BitVector::set_value(const char* value, u32 base = 0)
{
    set_value(std::string(value), base);
}

// public methods
BitVector::BitVector()
    : m_bitvector_size(0)
{
    // Nothing here
}

BitVector::BitVector(u32 size)
    : m_bitvector_size(size)
{
    allocate_cleared_storage();
    compute_mask();
}

BitVector::BitVector(u64 value, u32 size)
    : m_bitvector_size(size)
{
    allocate_cleared_storage();
    compute_mask();
    auto bitvec_ptr = get_bitvec_ptr();
    (*(static_cast<u64*>(static_cast<void*>(bitvec_ptr)))) = value;
    mask_final_word();
}

BitVector::BitVector(i64 value, u32 size)
    : BitVector((u64)value, size)
{
    // Nothing here
}

BitVector::BitVector(const std::string& value, u32 base, u32 size)
    : m_bitvector_size(size)
{
    allocate_storage();
    compute_mask();
    set_value(value, base);
}

BitVector::BitVector(const char* value, u32 base, u32 size)
    : BitVector(std::string(value), base, size)
{
    // Nothing here
}

BitVector::BitVector(const BitVector& other)
    : m_bitvector_size(other.m_bitvector_size)
{
    allocate_storage();
    compute_mask();
    set_value(other);
}

BitVector::BitVector(BitVector&& other)
    : BitVector()
{
    set_value(std::move(other));
}

BitVector::~BitVector()
{
    deallocate_storage();
}

} /* end namespace eusolver */

//
// BitVector.cpp ends here
