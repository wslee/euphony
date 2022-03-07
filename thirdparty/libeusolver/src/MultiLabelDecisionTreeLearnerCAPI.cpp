// MultiLabelDecisionTreeLearnerCAPI.cpp ---
//
// Filename: MultiLabelDecisionTreeLearnerCAPI.cpp
// Author: Abhishek Udupa
// Created: Mon Oct 19 12:20:16 2015 (-0400)
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

#include <vector>

#include "MultiLabelDecisionTreeLearner.hpp"
#include "LibEUSolverInternal.hpp"

const void* eus_learn_decision_tree_for_ml_data(void** pred_signatures,
                                                void** term_signatures,
                                                u64 num_preds,
                                                u64 num_terms)
{
    using eusolver::multilabel_decision_tree_learner::learn_decision_tree_for_multi_labelled_data;
    std::vector<const eusolver::BitSet*> attribute_vector(num_preds, nullptr);
    std::vector<const eusolver::BitSet*> labelling_vector(num_terms, nullptr);

    for (u64 i = 0; i < num_preds; ++i) {
        attribute_vector[i] = static_cast<eusolver::BitSet*>(pred_signatures[i]);
    }
    for (u64 i = 0; i < num_terms; ++i) {
        labelling_vector[i] = static_cast<eusolver::BitSet*>(term_signatures[i]);
    }

    EUS_BEGIN_CHECKED_BLOCK_;
    return learn_decision_tree_for_multi_labelled_data(attribute_vector,
                                                       labelling_vector);
    EUS_END_CHECKED_BLOCK_;
    return nullptr;
}

//
// MultiLabelDecisionTreeLearnerCAPI.cpp ends here
