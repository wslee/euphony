// DecisionTree.hpp ---
//
// Filename: DecisionTree.hpp
// Author: Abhishek Udupa
// Created: Mon Oct  5 11:57:12 2015 (-0400)
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

#if !defined EUSOLVER_DECISION_TREE_HPP_
#define EUSOLVER_DECISION_TREE_HPP_

#include <type_traits>
#include <string>
#include "EUSolverTypes.h"
#include "BitSet.hpp"

namespace eusolver {

class DecisionTreeNodeBase
{
private:
    mutable i64 m_reference_count;

public:
    DecisionTreeNodeBase();
    virtual ~DecisionTreeNodeBase();

    void inc_ref_count() const;
    void dec_ref_count() const;

    template <typename T>
    inline T* as()
    {
        static_assert(std::is_convertible<T*, DecisionTreeNodeBase*>::value,
                      "Bad static/dynamic cast!");
        return dynamic_cast<T*>(this);
    }

    template <typename T>
    inline const T* as() const
    {
        static_assert(std::is_convertible<T*, DecisionTreeNodeBase*>::value,
                      "Bad static/dynamic cast!");
        return dynamic_cast<const T*>(this);
    }

    template <typename T>
    inline T* sas()
    {
        static_assert(std::is_convertible<T*, DecisionTreeNodeBase*>::value,
                      "Bad static/dynamic cast!");
        return static_cast<T*>(this);
    }

    template <typename T>
    inline const T* sas() const
    {
        static_assert(std::is_convertible<T*, DecisionTreeNodeBase*>::value,
                      "Bad static/dynamic cast!");
        return static_cast<const T*>(this);
    }

    virtual std::string to_indented_string(u32 indent_level) const = 0;
    virtual std::string to_string() const = 0;
};

class DecisionTreeSplitNode : public DecisionTreeNodeBase
{
private:
    u64 m_split_attribute_id;
    const DecisionTreeNodeBase* m_positive_child;
    const DecisionTreeNodeBase* m_negative_child;

public:
    DecisionTreeSplitNode(u64 split_attribute_id,
                          const DecisionTreeNodeBase* positive_child,
                          const DecisionTreeNodeBase* negative_child);
    virtual ~DecisionTreeSplitNode();

    const DecisionTreeNodeBase* get_positive_child() const;
    const DecisionTreeNodeBase* get_negative_child() const;
    u64 get_split_attribute_id() const;

    virtual std::string to_indented_string(u32 indent_level) const override;
    virtual std::string to_string() const override;
};

class DecisionTreeLeafNode : public DecisionTreeNodeBase
{
private:
    const BitSet* m_labels;

public:
    DecisionTreeLeafNode(const BitSet& labels);
    virtual ~DecisionTreeLeafNode();

    u64 get_label_id() const;
    const BitSet* get_all_label_ids() const;

    virtual std::string to_indented_string(u32 indent_level) const override;
    virtual std::string to_string() const override;
};

} /* end namespace eusolver */

#endif /* EUSOLVER_DECISION_TREE_HPP_ */

//
// DecisionTree.hpp ends here
