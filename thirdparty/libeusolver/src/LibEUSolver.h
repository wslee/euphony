/* LibEUSolver.h ---
 * Filename: LibEUSolver.h
 * Author: Abhishek Udupa
 * Created: Mon Oct  5 00:03:50 2015 (-0400)
 */

/* Copyright (c) 2013, Abhishek Udupa, University of Pennsylvania
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *    This product includes software developed by The University of Pennsylvania
 * 4. Neither the name of the University of Pennsylvania nor the
 *    names of its contributors may be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/* Code: */

#if !defined EUSOLVER_LIB_EU_SOLVER_H_
#define EUSOLVER_LIB_EU_SOLVER_H_

/* This file defines the C api for using libeusolver */

#include "EUSolverTypes.h"

#ifdef __cplusplus
typedef uint8_t u08;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;

typedef int8_t i08;
typedef int16_t i16;
typedef int32_t i32;
typedef int64_t i64;

extern "C" {
#endif

/* BitSet functions */
void* eus_bitset_construct(u64 size_of_universe, bool initial_value);
void eus_bitset_destroy(void* bitset_ptr);
bool eus_bitsets_equal(const void* bitset1, const void* bitset2);
bool eus_bitsets_not_equal(const void* bitset1, const void* bitset2);
bool eus_bitset_is_proper_subset(const void* bitset1, const void* bitset2);
bool eus_bitset_is_subset(const void* bitset1, const void* bitset2);
bool eus_bitset_is_proper_superset(const void* bitset1, const void* bitset2);
bool eus_bitset_is_superset(const void* bitset1, const void* bitset2);
void eus_bitset_set_bit(void* bitset, u64 bit_num);
void eus_bitset_clear_bit(void* bitset, u64 bit_num);
bool eus_bitset_flip_bit(void* bitset, u64 bit_num);
bool eus_bitset_test_bit(const void* bitset, u64 bit_num);
void eus_bitset_set_all(void* bitset);
void eus_bitset_clear_all(void* bitset);
void eus_bitset_flip_all(void* bitset);
u64 eus_bitset_get_size_of_universe(const void* bitset);
u64 eus_bitset_get_length(const void* bitset);
bool eus_bitset_is_full(const void* bitset);
bool eus_bitset_is_empty(const void* bitset);

void* eus_bitset_and_functional(const void* bitset1, const void* bitset2);
void* eus_bitset_or_functional(const void* bitset1, const void* bitset2);
void* eus_bitset_xor_functional(const void* bitset1, const void* bitset2);
void* eus_bitset_minus_functional(const void* bitset1, const void* bitset2);
void* eus_bitset_negate_functional(const void* bitset);

void eus_bitset_inplace_and(void* bitset1_and_result, const void* bitset2);
void eus_bitset_inplace_or(void* bitset1_and_result, const void* bitset2);
void eus_bitset_inplace_xor(void* bitset1_and_result, const void* bitset2);
void eus_bitset_inplace_minus(void* bitset1_and_result, const void* bitset2);
void eus_bitset_inplace_negate(void* bitset_and_result);

bool eus_bitsets_are_disjoint(const void* bitset1, const void* bitset2);

i64 eus_bitset_get_next_element_greater_than_or_equal_to(const void* bitset, u64 position);
i64 eus_bitset_get_next_element_greater_than(const void* bitset, u64 position);
i64 eus_bitset_get_prev_element_lesser_than_or_equal_to(const void* bitset, u64 position);
i64 eus_bitset_get_prev_element_lesser_than(const void* bitset, u64 position);

u64 eus_bitset_get_hash(const void* bitset);
const char* eus_bitset_to_string(const void* bitset);
void* eus_bitset_clone(const void* bitset);
void eus_bitset_copy_in(void* bitset1, const void* bitset2);

/* error handling */
bool eus_check_error();
const char* eus_get_last_error_string();

/* decision tree traversal */
bool eus_decision_tree_is_split_node(const void* node);
bool eus_decision_tree_is_leaf_node(const void* node);
void eus_decision_tree_inc_ref(const void* node);
void eus_decision_tree_dec_ref(const void* node);
const void* eus_decision_tree_get_positive_child(const void* node);
const void* eus_decision_tree_get_negative_child(const void* node);
u64 eus_decision_tree_get_split_attribute_id(const void* node);
u64 eus_decision_tree_get_label_id(const void* node);
const void* eus_decision_tree_get_all_label_ids(const void* node);
const char* eus_decision_tree_to_string(const void* node);

/* learning methods */
const void* eus_learn_decision_tree_for_ml_data(void** pred_signatures,
                                                void** term_signatures,
                                                u64 num_preds,
                                                u64 num_terms);

#ifdef __cplusplus
}
#endif

#endif /* EUSOLVER_LIB_EU_SOLVER_H_ */


/* LibEUSolver.h ends here */
