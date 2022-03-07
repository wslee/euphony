// BitVector.hpp ---
// Filename: BitVector.hpp
// Author: Abhishek Udupa
// Created: Sat Jan 23 19:10:43 2016 (-0500)
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

#if !defined EUSOLVER_BITVECTOR_HPP_
#define EUSOLVER_BITVECTOR_HPP_

#include <string>
#include <exception>

#include "EUSolverTypes.h"

namespace eusolver {

class BitVectorException : public std::exception
{
private:
    std::string m_exception_info;

public:
    BitVectorException() noexcept;
    BitVectorException(const BitVectorException& other) noexcept;
    BitVectorException(BitVectorException&& other) noexcept;
    BitVectorException(const std::string& exception_info) noexcept;
    virtual ~BitVectorException() noexcept;
    BitVectorException& operator = (const BitVectorException& other) noexcept;
    BitVectorException& operator = (BitVectorException&& other) noexcept;
    const std::string& get_exception_info() const noexcept;
    virtual const char* what() const noexcept override;
};

class BitVector
{
private:
    typedef u32 UWordType;
    typedef i32 SWordType;
    typedef u64 ULongType;
    typedef i64 ILongType;

    static constexpr u64 sc_max_internal_bits = 64;
    static constexpr u64 bits_per_uword() { return 32; }
    static constexpr u64 uwords_for_size(u64 size)
    {
        return (size + (bits_per_uword() - 1)) / bits_per_uword();
    }

    u32 m_bitvector_size;
    u32 m_final_word_mask;
    union {
        UWordType m_internal_bits[2];
        UWordType* m_external_bits;
    } m_bitvec_object;

    inline UWordType* get_bitvec_ptr();
    inline const UWordType* get_bitvec_ptr() const;
    inline void allocate_cleared_storage();
    inline void allocate_storage();
    inline void deallocate_storage();
    inline void clear_storage();
    inline void compute_mask();
    inline void mask_final_word();
    inline u32 autodetect_base(const char* value, u32& value_offset, bool& is_negative);
    inline void set_value_from_string(const char* value, u32 base, bool is_negative);
    // quotient is returned in the canonical digits itself
    // remainder is the return value
    // if the canonical digit string after division is = 1, then done is set to true
    inline u32 divide_canon_digit_string_by_two(u08* canonical_digits, u32 length, u32 base, bool& done);
    inline void get_canonical_digit_string(u08* canonical_digits, const char* value_string, u32 base);
    inline void set_value(u64 value);
    inline void set_value(const BitVector& other);
    inline void set_value(BitVector&& other);
    // base = 0 ==> autodetect base
    inline void set_value(const std::string& value, u32 base = 0);
    inline void set_value(const char* value, u32 base = 0);

    inline void set_bit(u32 bit_num);
    inline void clear_bit(u32 bit_num);
    inline bool test_bit(u32 bit_num) const;

    inline void make_twos_complement();

public:
    BitVector();
    explicit BitVector(u64 size);
    BitVector(u64 value, u64 size);
    BitVector(i64 value, u64 size);
    BitVector(const std::string& value, u64 base, u64 size);
    BitVector(const char* value, u64 base, u64 size);

    BitVector(const BitVector& other);
    BitVector(BitVector&& other);

    ~BitVector();

    BitVector& operator = (const BitVector& other);
    BitVector& operator = (BitVector&& other);

    BitVector& operator = (u64 value);
    BitVector& operator = (i64 value);

    bool operator == (const BitVector& other) const;
    bool operator != (const BitVector& other) const;
    bool operator < (const BitVector& other) const;
    bool operator <= (const BitVector& other) const;
    bool operator > (const BitVector& other) const;
    bool operator >= (const BitVector& other) const;

    bool operator == (u64 other) const;
    bool operator != (u64 other) const;
    bool operator < (u64 other) const;
    bool operator <= (u64 other) const;
    bool operator > (u64 other) const;
    bool operator >= (u64 other) const;

    bool unsigned_lt(const BitVector& other) const;
    bool unsigned_le(const BitVector& other) const;
    bool unsigned_gt(const BitVector& other) const;
    bool unsigned_ge(const BitVector& other) const;

    bool signed_lt(const BitVector& other) const;
    bool signed_le(const BitVector& other) const;
    bool signed_gt(const BitVector& other) const;
    bool signed_ge(const BitVector& other) const;

    BitVector operator + (const BitVector& other) const;
    BitVector& operator += (const BitVector& other);
    BitVector add(const BitVector& other) const;
    void add_inplace(const BitVector& other) const;

    BitVector operator + (i64 other) const;
    BitVector& operator += (i64 other);
    BitVector add(i64 other) const;
    void add_inplace(i64 other) const;

    BitVector operator - (const BitVector& other) const;
    BitVector& operator -= (const BitVector& other);
    BitVector sub(const BitVector& other) const;
    void sub_inplace(const BitVector& other);

    BitVector operator - (i64 other) const;
    BitVector& operator -= (i64 other);
    BitVector sub(i64 other) const;
    void sub_inplace(i64 other);

    BitVector operator ~ () const;
    BitVector logical_negate() const;
    void logical_negate_inplace();

    BitVector operator - () const;
    BitVector arithmetic_negate() const;
    void arithmetic_negate_inplace();

    BitVector operator & (const BitVector& other) const;
    BitVector& operator &= (const BitVector& other);
    BitVector logical_and(const BitVector& other) const;
    void logical_and_inplace(const BitVector& other);

    BitVector operator | (const BitVector& other) const;
    BitVector& operator |= (const BitVector& other);
    BitVector logical_ior(const BitVector& other) const;
    void logical_ior_inplace(const BitVector& other);

    BitVector operator ^ (const BitVector& other) const;
    BitVector& operator ^= (const BitVector& other);
    BitVector logical_xor(const BitVector& other) const;
    void logical_xor_inplace(const BitVector& other);

    BitVector operator << (u32 shift_amount) const;
    BitVector operator << (const BitVector& shift_amount) const;
    BitVector& operator <<= (u32 shift_amount);
    BitVector& operator <<= (const BitVector& shift_amount);

    BitVector logical_shift_left(u32 shift_amount) const;
    void logical_shift_left_inplace(u32 shift_amount);
    BitVector logical_shift_left(const BitVector& shift_amount) const;
    void logical_shift_left_inplace(const BitVector& shift_amount);

    BitVector operator >> (u32 shift_amount) const;
    BitVector operator >> (const BitVector& shift_amount) const;
    BitVector& operator >>= (u32 shift_amount);
    BitVector& operator >>= (const BitVector& shift_amount);

    BitVector logical_shift_right(u32 shift_amount) const;
    void logical_shift_right_inplace(u32 shift_amount);
    BitVector logical_shift_right(const BitVector& shift_amount) const;
    void logical_shift_right_inplace(const BitVector& shift_amount);

    BitVector arithmetic_shift_right(u32 shift_amount) const;
    void arithmetic_shift_right(u32 shift_amount);
    BitVector arithmetic_shift_right(const BitVector& shift_amount) const;
    void arithmetic_shift_right_inplace(const BitVector& shift_amount);
};

} /* end namespace eusolver */

#endif /* EUSOLVER_BITVECTOR_HPP_ */

//
// BitVector.hpp ends here
