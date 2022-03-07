// DecisionTree.cpp ---
//
// Filename: DecisionTree.cpp
// Author: Abhishek Udupa
// Created: Mon Oct  5 12:19:02 2015 (-0400)
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

#include <sstream>
#include "DecisionTree.hpp"

namespace eusolver {

DecisionTreeNodeBase::DecisionTreeNodeBase()
    : m_reference_count(0)
{
    // Nothing here
}

DecisionTreeNodeBase::~DecisionTreeNodeBase()
{
    // Nothing here
}

void DecisionTreeNodeBase::inc_ref_count() const
{
    ++m_reference_count;
}

void DecisionTreeNodeBase::dec_ref_count() const
{
    --m_reference_count;
    if (m_reference_count <= 0) {
        delete this;
    }
}

DecisionTreeSplitNode::DecisionTreeSplitNode(u64 split_attribute_id,
                                             const DecisionTreeNodeBase* positive_child,
                                             const DecisionTreeNodeBase* negative_child)
    : DecisionTreeNodeBase(), m_split_attribute_id(split_attribute_id),
      m_positive_child(positive_child), m_negative_child(negative_child)
{
    if (m_positive_child != nullptr) {
        m_positive_child->inc_ref_count();
    }
    if (m_negative_child != nullptr) {
        m_negative_child->inc_ref_count();
    }
}

DecisionTreeSplitNode::~DecisionTreeSplitNode()
{
    if (m_positive_child != nullptr) {
        m_positive_child->dec_ref_count();
    }
    if (m_negative_child != nullptr) {
        m_negative_child->dec_ref_count();
    }
}

const DecisionTreeNodeBase* DecisionTreeSplitNode::get_positive_child() const
{
    return m_positive_child;
}

const DecisionTreeNodeBase* DecisionTreeSplitNode::get_negative_child() const
{
    return m_negative_child;
}

u64 DecisionTreeSplitNode::get_split_attribute_id() const
{
    return m_split_attribute_id;
}

std::string DecisionTreeSplitNode::to_indented_string(u32 indent_level) const
{
    std::ostringstream sstr;
    const std::string indent_string(indent_level * 2, ' ');
    auto pos_str = m_positive_child->to_indented_string(indent_level + 1);
    auto neg_str = m_negative_child->to_indented_string(indent_level + 1);
    sstr << indent_string << "if split(" << m_split_attribute_id << ")" << std::endl
         << pos_str << std::endl
         << indent_string << "else" << std::endl
         << neg_str;
    return sstr.str();
}

std::string DecisionTreeSplitNode::to_string() const
{
    return to_indented_string(0);
}

DecisionTreeLeafNode::DecisionTreeLeafNode(const BitSet& labels)
    : DecisionTreeNodeBase(), m_labels(labels.clone())
{
    // Nothing here
}

DecisionTreeLeafNode::~DecisionTreeLeafNode()
{
    delete m_labels;
}

u64 DecisionTreeLeafNode::get_label_id() const
{
    return m_labels->get_next_element_greater_than_or_equal_to(0);
}

const BitSet* DecisionTreeLeafNode::get_all_label_ids() const
{
    return m_labels;
}

std::string DecisionTreeLeafNode::to_indented_string(u32 indent_level) const
{
    const std::string indent_string(indent_level * 2, ' ');
    return indent_string + "-> labels(" + m_labels->to_string() + ")";
}

std::string DecisionTreeLeafNode::to_string() const
{
    return to_indented_string(0);
}

} /* end namespace eusolver */

//
// DecisionTree.cpp ends here
