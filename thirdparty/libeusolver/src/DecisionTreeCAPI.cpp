// DecisionTreeCAPI.cpp ---
//
// Filename: DecisionTreeCAPI.cpp
// Author: Abhishek Udupa
// Created: Fri Oct 16 12:40:29 2015 (-0400)
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

#include <exception>
#include "DecisionTree.hpp"
#include "LibEUSolverInternal.hpp"

static std::string s_dt_c_api_output_buffer_;

static inline eusolver::DecisionTreeNodeBase* as_dt(void* ptr)
{
    return static_cast<eusolver::DecisionTreeNodeBase*>(ptr);
}

static inline const eusolver::DecisionTreeNodeBase* as_dt(const void* ptr)
{
    return static_cast<const eusolver::DecisionTreeNodeBase*>(ptr);
}

static inline eusolver::DecisionTreeLeafNode* as_leaf_dt(void* ptr)
{
    auto retval = as_dt(ptr)->as<eusolver::DecisionTreeLeafNode>();
    if (retval == nullptr) {
        eusolver::detail_::g_libeusolver_c_api_error_buffer_ =
            "Decision tree node is not a leaf node.";
    }
    return retval;
}

static inline const eusolver::DecisionTreeLeafNode* as_leaf_dt(const void* ptr)
{
    auto retval = as_dt(ptr)->as<eusolver::DecisionTreeLeafNode>();
    if (retval == nullptr) {
        eusolver::detail_::g_libeusolver_c_api_error_buffer_ =
            "Decision tree node is not a leaf node.";
    }
    return retval;
}

static inline eusolver::DecisionTreeLeafNode* sas_leaf_dt(void* ptr)
{
    return as_dt(ptr)->sas<eusolver::DecisionTreeLeafNode>();
}

static inline const eusolver::DecisionTreeLeafNode* sas_leaf_dt(const void* ptr)
{
    return as_dt(ptr)->sas<eusolver::DecisionTreeLeafNode>();
}

static inline eusolver::DecisionTreeSplitNode* as_split_dt(void* ptr)
{
    auto retval = as_dt(ptr)->as<eusolver::DecisionTreeSplitNode>();
    if (retval == nullptr) {
        eusolver::detail_::g_libeusolver_c_api_error_buffer_ =
            "Decision tree node is not a split node.";
    }
    return retval;
}

static inline const eusolver::DecisionTreeSplitNode* as_split_dt(const void* ptr)
{
    auto retval = as_dt(ptr)->as<eusolver::DecisionTreeSplitNode>();
    if (retval == nullptr) {
        eusolver::detail_::g_libeusolver_c_api_error_buffer_ =
            "Decision tree node is not a split node.";
    }
    return retval;
}

static inline eusolver::DecisionTreeSplitNode* sas_split_dt(void* ptr)
{
    return as_dt(ptr)->sas<eusolver::DecisionTreeSplitNode>();
}

static inline const eusolver::DecisionTreeSplitNode* sas_split_dt(const void* ptr)
{
    return as_dt(ptr)->sas<eusolver::DecisionTreeSplitNode>();
}

bool eus_decision_tree_is_split_node(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    return (dynamic_cast<const eusolver::DecisionTreeSplitNode*>
            (static_cast<const eusolver::DecisionTreeNodeBase*>(node)) != nullptr);
}

bool eus_decision_tree_is_leaf_node(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    return (dynamic_cast<const eusolver::DecisionTreeLeafNode*>
            (static_cast<const eusolver::DecisionTreeNodeBase*>(node)) != nullptr);
}

void eus_decision_tree_inc_ref(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    as_dt(node)->inc_ref_count();
}

void eus_decision_tree_dec_ref(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    as_dt(node)->dec_ref_count();
}

const void* eus_decision_tree_get_positive_child(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    return as_split_dt(node)->get_positive_child();
}

const void* eus_decision_tree_get_negative_child(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    return as_split_dt(node)->get_negative_child();
}

u64 eus_decision_tree_get_split_attribute_id(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    return as_split_dt(node)->get_split_attribute_id();
}

u64 eus_decision_tree_get_label_id(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    return as_leaf_dt(node)->get_label_id();
}

const void* eus_decision_tree_get_all_label_ids(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    return as_leaf_dt(node)->get_all_label_ids();
}

const char* eus_decision_tree_to_string(const void* node)
{
    eusolver::detail_::g_libeusolver_c_api_error_buffer_.clear();
    s_dt_c_api_output_buffer_ = as_dt(node)->to_string();
    return s_dt_c_api_output_buffer_.c_str();
}

//
// DecisionTreeCAPI.cpp ends here
