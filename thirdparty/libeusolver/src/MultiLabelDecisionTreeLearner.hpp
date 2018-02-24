// MultiLabelDecisionTreeLearner.hpp ---
//
// Filename: MultiLabelDecisionTreeLearner.hpp
// Author: Abhishek Udupa
// Created: Mon Oct  5 12:41:13 2015 (-0400)
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

#if !defined EUSOLVER_MULTI_LABEL_DECISION_TREE_LEARNER_HPP_
#define EUSOLVER_MULTI_LABEL_DECISION_TREE_LEARNER_HPP_

#include <vector>

#include "BitSet.hpp"
#include "DecisionTree.hpp"

namespace eusolver {
namespace multilabel_decision_tree_learner {

class DecisionTreeException : public std::exception
{
private:
    std::string m_exception_info;

public:
    DecisionTreeException() noexcept;
    DecisionTreeException(const std::string& exception_info) noexcept;
    DecisionTreeException(const DecisionTreeException& other) noexcept;
    DecisionTreeException(DecisionTreeException&& other) noexcept;
    virtual ~DecisionTreeException() noexcept;

    DecisionTreeException& operator = (const DecisionTreeException& other) noexcept;
    DecisionTreeException& operator = (DecisionTreeException&& other) noexcept;
    const std::string& get_exception_info() const noexcept;
    virtual const char* what() const noexcept override;
};

const DecisionTreeNodeBase*
learn_decision_tree_for_multi_labelled_data(const std::vector<const BitSet*>& attribute_vector,
                                            const std::vector<const BitSet*>& labelling_vector);

} /* end namespace multilabel_decision_tree_learner */
} /* end namespace eusolver */

#endif /* EUSOLVER_MULTI_LABEL_DECISION_TREE_LEARNER_HPP_ */
//
// MultiLabelDecisionTreeLearner.hpp ends here
