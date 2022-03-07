// MultiLabelDecisionTreeLearner.cpp ---
//
// Filename: MultiLabelDecisionTreeLearner.cpp
// Author: Abhishek Udupa
// Created: Mon Oct  5 12:44:50 2015 (-0400)
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

#include <limits>
#include <unordered_map>
#include <cmath>
#include <iostream>

#include "MultiLabelDecisionTreeLearner.hpp"

#define EUSOLVER_DEBUG_DT_CHECK_INPUTS_ 1

namespace eusolver {
namespace multilabel_decision_tree_learner {

namespace detail_ {

class BitSetHasher
{
public:
    inline u64 operator () (const BitSet& bitset) const
    {
        return bitset.hash();
    }
};

static std::unordered_map<BitSet, double, BitSetHasher> entropy_cache;

// we need at least this much of an information gain ratio
// to consider things a good split
static constexpr double sc_info_gain_threshold = 0.0001;

typedef std::vector<const BitSet*> InputVector;

static inline void
check_dt_learning_inputs(const InputVector& attribute_vector,
                         const InputVector& labelling_vector)
{
#if (EUSOLVER_DEBUG_DT_CHECK_INPUTS_ != 0)

    if (attribute_vector.size() == 0 || labelling_vector.size() == 0) {
        throw DecisionTreeException((std::string)"Inputs to decision tree learning cannot " +
                                    "be empty.");
    }

    const u64 num_points = attribute_vector[0]->get_size_of_universe();
    if (num_points == 0) {
        throw DecisionTreeException((std::string)"Cannot learn decision tree with zero " +
                                    "sample points.");
    }

    for (auto const& bitset : attribute_vector) {
        if (bitset->get_size_of_universe() != num_points) {
            throw DecisionTreeException((std::string)"Inconsistent number of points in " +
                                        "attribute vector provided to learn decision tree.");
        }
    }
    for (auto const& bitset : labelling_vector) {
        if (bitset->get_size_of_universe() != num_points) {
            throw DecisionTreeException((std::string)"Inconsistent number of points in " +
                                        "labelling vector provided to learn decision tree.");
        }
    }

#endif /* EUSOLVER_DEBUG_DT_CHECK_INPUTS_ == 1 */
}

static inline BitSet get_common_labels(const InputVector& point_to_labelling_vector,
                                       const BitSet& point_filter)
{
    BitSet intersection_of_labels(point_to_labelling_vector[0]->get_size_of_universe(), true);
    for (auto const& point_id : point_filter) {
        intersection_of_labels &= (*(point_to_labelling_vector[point_id]));
    }
    return intersection_of_labels;
}

static inline std::unordered_map<u64, u64>
compute_label_covers(const InputVector& point_to_labelling_vector,
                     const BitSet& point_set, const BitSet& label_set)
{
    std::unordered_map<u64, u64> retval;
    for (auto label_id : label_set) {
        u64 current_label_cover = 0;
        for (auto point_id : point_set) {
            if (point_to_labelling_vector[point_id]->test_bit(label_id)) {
                ++current_label_cover;
            }
        }
        retval[label_id] = current_label_cover;
    }
    return retval;
}

static inline std::vector<u64>
compute_summations_of_point_covers(const InputVector& point_to_labelling_vector,
                                   const std::unordered_map<u64, u64>& label_cover_function,
                                   const BitSet& point_set)
{
    std::vector<u64> retval(point_set.get_size_of_universe(), 0);
    for (auto point_id : point_set) {
        u64 current_total = 0;
        for (auto label_id : (*(point_to_labelling_vector[point_id]))) {
            auto it = label_cover_function.find(label_id);
            current_total += it->second;
        }
        retval[point_id] = current_total;
    }
    return retval;
}

static inline double
get_entropy_for_set(const InputVector& labelling_to_point_vector,
                    const InputVector& point_to_labelling_vector,
                    const BitSet& point_set)
{
    // audupa: TESTING
    // return an entropy value of zero if there exists a common label
    BitSet intersection_of_labels(point_to_labelling_vector[0]->get_size_of_universe(), true);
    for (auto point_id : point_set) {
        intersection_of_labels &= (*(point_to_labelling_vector[point_id]));
    }

    if (!intersection_of_labels.is_empty()) {
        return 0.0;
    }
    // audupa: this seems to increase the number of points needed. REJECT!
    // audupa: end testing

    // first determine the set of possible labels
    // for this set of points

    // audupa: Implement memoization of entropy
    auto cached_it = detail_::entropy_cache.find(point_set);
    if (cached_it != detail_::entropy_cache.end()) {
        return cached_it->second;
    }

    BitSet union_of_labels(point_to_labelling_vector[0]->get_size_of_universe());
    for (auto point_id : point_set) {
        union_of_labels |= (*(point_to_labelling_vector[point_id]));
    }

    // for each label, we now compute the COVER of that label
    // given a label id i, cover(i) is defined as the number of points
    // in point_set that can possibly be labelled with label id i
    auto label_cover_function = compute_label_covers(point_to_labelling_vector,
                                                     point_set, union_of_labels);
    auto summation_of_point_covers = compute_summations_of_point_covers(point_to_labelling_vector,
                                                                        label_cover_function,
                                                                        point_set);
    // Now compute the probability of each label p(label)
    auto const point_probability = (double)1.0 / (double)(point_set.size());

    std::unordered_map<u64, double> label_probabilities;

    for (auto label_id : union_of_labels) {
        double current_label_probability = 0.0;
        auto it = label_cover_function.find(label_id);
        double current_label_cover = it->second;

        for (auto point_id : point_set) {
            if (!point_to_labelling_vector[point_id]->test_bit(label_id)) {
                continue;
            }
            current_label_probability += (point_probability *
                                          ((double)current_label_cover /
                                           (double)(summation_of_point_covers[point_id])));
        }
        label_probabilities[label_id] = current_label_probability;
    }

    double final_entropy = 0.0;
    for (auto const& label_id_prob_pair : label_probabilities) {
        auto const prob = label_id_prob_pair.second;
        final_entropy += (prob * std::log2(prob));
    }

    // std::cout << "Entropy of set: " << point_set.to_string()
    //           << " = " << -final_entropy << std::endl;
    detail_::entropy_cache[point_set] = (-final_entropy);
    return (-final_entropy);
}

static inline double
get_entropy_for_split_on_attribute(const InputVector& attribute_to_point_vector,
                                   const InputVector& labelling_to_point_vector,
                                   const InputVector& point_to_attribute_vector,
                                   const InputVector& point_to_labelling_vector,
                                   const BitSet& point_filter, u64 attribute_id)
{
    auto const num_points = attribute_to_point_vector[0]->get_size_of_universe();
    BitSet positive_points(num_points);
    BitSet negative_points(num_points);
    u64 positive_set_size = 0;
    u64 negative_set_size = 0;
    u64 total_set_size = 0;

    for (auto i : point_filter) {
        ++total_set_size;
        if (point_to_attribute_vector[i]->test_bit(attribute_id)) {
            positive_points.set_bit(i);
            ++positive_set_size;
        } else {
            negative_points.set_bit(i);
            ++negative_set_size;
        }
    }

    auto const positive_ratio = (double)positive_set_size / (double)total_set_size;
    auto const negative_ratio = (double)negative_set_size / (double)total_set_size;

    auto const positive_set_entropy = get_entropy_for_set(labelling_to_point_vector,
                                                          point_to_labelling_vector,
                                                          positive_points);
    auto const negative_set_entropy = get_entropy_for_set(labelling_to_point_vector,
                                                          point_to_labelling_vector,
                                                          negative_points);
    return ((positive_set_entropy * positive_ratio) +
            (negative_set_entropy * negative_ratio));
}

static inline const DecisionTreeNodeBase*
learn_dt_for_ml_data(const InputVector& attribute_to_point_vector,
                     const InputVector& labelling_to_point_vector,
                     const InputVector& point_to_attribute_vector,
                     const InputVector& point_to_labelling_vector,
                     const BitSet& point_filter)
{
    // check if we can exit early, that is if we have a common label

    // std::cout << "MultiLabelDecisionTreeLearner: Checking common label..." << std::endl;

    auto common_labels = get_common_labels(point_to_labelling_vector, point_filter);
    if (!common_labels.is_empty()) {
        // std::cout << "MultiLabelDecisionTreeLearner: Found common label "
        //           << common_label << std::endl;
        return new DecisionTreeLeafNode(common_labels);
    }

    // std::cout << "MultiLabelDecisionTreeLearner: No common label!" << std::endl;
    // std::cout << "MultiLabelDecisionTreeLearner: Learning decision tree for points:"
    //           << std::endl << point_filter.to_string() << std::endl;

    // early exit not possible, determine the locally optimal split
    // but before that determine the entropy of the current set
    auto const current_entropy = get_entropy_for_set(labelling_to_point_vector,
                                                     point_to_labelling_vector,
                                                     point_filter);

    double min_split_entropy = std::numeric_limits<double>::max();
    i64 attribute_with_minimal_split_entropy = -1;

    const u64 num_attributes = point_to_attribute_vector[0]->get_size_of_universe();
    for (u64 i = 0; i < num_attributes; ++i) {
        // std::cout << "Evaluating split on attribute " << i << std::endl;
        auto const cur_split_entropy = get_entropy_for_split_on_attribute(attribute_to_point_vector,
                                                                          labelling_to_point_vector,
                                                                          point_to_attribute_vector,
                                                                          point_to_labelling_vector,
                                                                          point_filter, i);
        auto const info_gain = current_entropy - cur_split_entropy;
        if ((info_gain / current_entropy >= sc_info_gain_threshold) &&
            (cur_split_entropy < min_split_entropy)) {
            min_split_entropy = cur_split_entropy;
            attribute_with_minimal_split_entropy = i;
        }

        // std::cout << "Split on attribute " << i << " results in " << info_gain
        //           << " bits of information gain." << std::endl;
    }

    if (attribute_with_minimal_split_entropy < 0) {
        // no split possible, decision tree cannot be learned :-(
        return nullptr;
    }

    // try to split on best attribute
    auto const num_points = attribute_to_point_vector[0]->get_size_of_universe();
    BitSet positive_points(num_points);
    BitSet negative_points(num_points);

    // std::cout << "MultiLabelDecisionTreeLearner: Splitting on attribute "
    //           << attribute_with_minimal_split_entropy << std::endl;
    // std::cout << "Entropy of set before split = " << current_entropy << std::endl;
    // std::cout << "Entropy after split = " << min_split_entropy << std::endl;

    for (auto point_id : point_filter) {
        if (attribute_to_point_vector[attribute_with_minimal_split_entropy]->test_bit(point_id)) {
            positive_points.set_bit(point_id);
        } else {
            negative_points.set_bit(point_id);
        }
    }

    auto positive_child = learn_dt_for_ml_data(attribute_to_point_vector,
                                               labelling_to_point_vector,
                                               point_to_attribute_vector,
                                               point_to_labelling_vector,
                                               positive_points);
    if (positive_child == nullptr) {
        return nullptr;
    }
    auto negative_child = learn_dt_for_ml_data(attribute_to_point_vector,
                                               labelling_to_point_vector,
                                               point_to_attribute_vector,
                                               point_to_labelling_vector,
                                               negative_points);
    if (negative_child == nullptr) {
        delete positive_child;
        return nullptr;
    }

    return new DecisionTreeSplitNode(attribute_with_minimal_split_entropy,
                                     positive_child, negative_child);
}

/**
   Transposes an input vector.
 */

static inline InputVector transpose_bitset_vector(const InputVector& input_vector)
{
    auto const num_input_bitsets = input_vector.size();
    if (num_input_bitsets == 0) {
        return InputVector();
    }

    auto const size_of_input_bitset_universe = input_vector[0]->get_size_of_universe();
    if (size_of_input_bitset_universe == 0) {
        return InputVector();
    }

    InputVector retval(size_of_input_bitset_universe, nullptr);
    for (u64 i = 0; i < size_of_input_bitset_universe; ++i) {
        auto cur_bitset = new BitSet(num_input_bitsets);
        for (u64 j = 0; j < num_input_bitsets; ++j) {
            if (input_vector[j]->test_bit(i)) {
                cur_bitset->set_bit(j);
            }
        }
        retval[i] = cur_bitset;
    }
    return retval;
}

template <typename PtrType>
static inline void free_ptr_vector(const std::vector<PtrType>& the_vector)
{
    auto const num_elems = the_vector.size();
    for (u64 i = 0; i < num_elems; ++i) {
        delete the_vector[i];
    }
}

} /* end namespace detail_ */


// Implementation of DecisionTreeException
DecisionTreeException::DecisionTreeException() noexcept
    : m_exception_info("DecisionTreeException: No information.")
{
    // Nothing here
}

DecisionTreeException::DecisionTreeException(const std::string& exception_info) noexcept
    : m_exception_info((std::string)"DecisionTreeException: " + exception_info)
{
    // Nothing here
}

DecisionTreeException::DecisionTreeException(const DecisionTreeException& other) noexcept
    : m_exception_info(other.m_exception_info)
{
    // Nothing here
}

DecisionTreeException::DecisionTreeException(DecisionTreeException&& other) noexcept
    : m_exception_info(std::move(other.m_exception_info))
{
    // Nothing here
}

DecisionTreeException::~DecisionTreeException() noexcept
{
    // Nothing here
}

DecisionTreeException&
DecisionTreeException::operator = (const DecisionTreeException& other) noexcept
{
    if (&other == this) {
        return *this;
    }
    m_exception_info = other.m_exception_info;
    return *this;
}

DecisionTreeException&
DecisionTreeException::operator = (DecisionTreeException&& other) noexcept
{
    if (&other == this) {
        return *this;
    }
    m_exception_info = std::move(other.m_exception_info);
    return *this;
}

const std::string& DecisionTreeException::get_exception_info() const noexcept
{
    return m_exception_info;
}

const char* DecisionTreeException::what() const noexcept
{
    return m_exception_info.c_str();
}


// Implementation of actual learning methods

/**
   attribute_to_point_vector: A vector containing one bitset for each attribute generated.
                              Each bitset contains the points at which the attribute evaluates
                              to true.
   labelling_to_point_vector: A vector containing one bitset for each term (label) generated.
                              Each bitset contains the points at which the term (label) works,
                              i.e., the points at which the term satisfies the specification.
 */
const DecisionTreeNodeBase*
learn_decision_tree_for_multi_labelled_data(const std::vector<const BitSet*>& attribute_to_point_vector,
                                            const std::vector<const BitSet*>& labelling_to_point_vector)
{
    detail_::check_dt_learning_inputs(attribute_to_point_vector,
                                      labelling_to_point_vector);
    // std::cout << "MultiLabelDecisionTreeLearner: Transposing bitsets..." << std::endl;
    auto point_to_attribute_vector = detail_::transpose_bitset_vector(attribute_to_point_vector);
    auto point_to_labelling_vector = detail_::transpose_bitset_vector(labelling_to_point_vector);
    // std::cout << "MultiLabelDecisionTreeLearner: Done Transposing bitsets!" << std::endl;
    BitSet sample_point_filter(attribute_to_point_vector[0]->get_size_of_universe(), true);

    auto retval = detail_::learn_dt_for_ml_data(attribute_to_point_vector,
                                                labelling_to_point_vector,
                                                point_to_attribute_vector,
                                                point_to_labelling_vector,
                                                sample_point_filter);
    detail_::free_ptr_vector(point_to_attribute_vector);
    detail_::free_ptr_vector(point_to_labelling_vector);
    detail_::entropy_cache.clear();
    // std::cout << "MultiLabelDecisionTreeLearner: returning decision tree:" << std::endl
    //           << retval->to_string() << std::endl;
    return retval;
}

#undef EUSOLVER_DEBUG_DT_CHECK_INPUTS_

} /* end namespace multilabel_decision_tree_learner */
} /* end namespace eusolver */

//
// MultiLabelDecisionTreeLearner.cpp ends here
