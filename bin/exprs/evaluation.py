#!/usr/bin/env python3
# evaluation.py ---
#
# Filename: evaluation.py
# Author: Abhishek Udupa
# Created: Mon Aug 31 16:29:35 2015 (-0400)
#
#
# Copyright (c) 2015, Abhishek Udupa, University of Pennsylvania
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#    This product includes software developed by The University of Pennsylvania
# 4. Neither the name of the University of Pennsylvania nor the
#    names of its contributors may be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# Code:
import copy

from utils import utils
from exprs import exprs
from utils import basetypes
from utils.utils import static_var

# if __name__ == '__main__':
#     utils.print_module_misuse_and_exit()

_variable_expression = exprs.ExpressionKinds.variable_expression
_constant_expression = exprs.ExpressionKinds.constant_expression
_function_expression = exprs.ExpressionKinds.function_expression
_formal_parameter_expression = exprs.ExpressionKinds.formal_parameter_expression

def evaluate_term_raw(expr_object, eval_context):
    return evaluate_expression_raw(expr_object, eval_context)

def evaluate_pred_raw(expr_object, eval_context):
    return evaluate_expression_raw(expr_object, eval_context)


@static_var("cache", {})
def evaluate_expression_on_stack(expr_object, eval_context):
    # print('Evaluating:', exprs.expression_to_string(expr_object))
    old_stack_size = eval_context.eval_stack_top
    # if expr_object is not None and eval_context.valuation_map is not None and eval_context.interpretation_map is not None:
    #     key = (exprs.expression_to_string(expr_object), tuple([exprs.value_to_string(v) for v in eval_context.valuation_map]),
    #             tuple(eval_context.interpretation_map.items()))
    # else:
    #     key = None
    # key = None
    kind = expr_object.expr_kind
    # if key in evaluate_expression_on_stack.cache and (kind != _function_expression):
        # print('cached')
        # eval_context.push(evaluate_expression_on_stack.cache[key])
    # else:
    if (kind == _variable_expression):
        o = expr_object.variable_info.variable_eval_offset
        if o == exprs.VariableInfo._undefined_offset:
            value = eval_context.lookup_let_variable(expr_object)
            if value is not None:
                eval_context.push(value)
            else:
                raise basetypes.UnboundLetVariableError()
        else:
            eval_context.push(eval_context.valuation_map[o].value_object)
    elif (kind == _formal_parameter_expression):
        o = expr_object.parameter_position
        eval_context.push(eval_context.valuation_map[o].value_object)
    elif (kind == _constant_expression):
        eval_context.push(expr_object.value_object.value_object)
    elif (kind == _function_expression):
        fun_info = expr_object.function_info
        fun_info.evaluate(expr_object, eval_context)
    else:
        raise basetypes.UnhandledCaseError('Odd expression kind: %s' % kind)

    # if key is not None and key not in evaluate_expression_on_stack.cache:
    #     evaluate_expression_on_stack.cache[key] = eval_context.peek()
    assert old_stack_size == eval_context.eval_stack_top - 1
    # print(exprs.expression_to_string(expr_object), 'evaluated to', eval_context.peek())


def evaluate_expression_raw(expr_object, eval_context):
    # print('Trying to evaluate', exprs.expression_to_string(expr_object))
    # for f, i in eval_context.interpretation_map.items():
    #     print('\t', exprs.expression_to_string(i))
    try:
        evaluate_expression_on_stack(expr_object, eval_context)
        retval = eval_context.peek()
        eval_context.pop()
        '''
        print(
                exprs.expression_to_string(expr_object),
                'evaluated to',
                retval,
                'on',
                [ p.value_object for p in eval_context.valuation_map],
                ' and ',
                [ exprs.expression_to_string(t) for fid, t in eval_context.interpretation_map.items() ]
            )
        '''
        ret = retval
    except:
        # reset the stack
        eval_context.eval_stack_top = 0
        raise
    return ret

def evaluate_expression(expr_object, eval_context):
    retval = evaluate_expression_raw(expr_object, eval_context)
    retval = exprs.Value(retval, exprs.get_expression_type(expr_object))
    return retval

class EvaluationContext(object):
    def __init__(self, eval_stack_size = 131072):
        self.eval_stack = [int(0)] * eval_stack_size
        self.eval_stack_size = eval_stack_size
        self.eval_stack_top = 0
        self.valuation_map = None
        self.interpretation_map = {}
        self.let_variable_stack = []

    def push_let_variables(self, bindings):
        self.let_variable_stack.append(bindings)

    def pop_let_variables(self):
        self.let_variable_stack.pop()

    def peek_let_variables(self):
        if len(self.let_variable_stack) == 0:
            return {}
        return self.let_variable_stack[-1]

    def lookup_let_variable(self, let_variable):
        for bindings in reversed(self.let_variable_stack):
            if let_variable in bindings:
                return bindings[let_variable]
        return None

    def peek(self, peek_depth = 0):
        return self.eval_stack[self.eval_stack_top - 1 - peek_depth]

    def peek_items(self, peek_depth = 1):
        return self.eval_stack[(self.eval_stack_top - peek_depth):self.eval_stack_top]

    def pop(self, num_elems = 1):
        self.eval_stack_top -= num_elems

    def push(self, value_object):
        try:
            self.eval_stack[self.eval_stack_top] = value_object
            self.eval_stack_top += 1
        except:
            raise

    def set_valuation_map(self, valuation_map):
        if len(valuation_map) > 0 and type(valuation_map[0]) != exprs.Value:
            raise Exception
        self.valuation_map = valuation_map

    def clear_valuation_map(self):
        self.valuation_map = None

    def set_interpretation(self, unknown_function_or_unknown_function_id, interpretation):
        if type(unknown_function_or_unknown_function_id) != int:
            unknown_function_id = unknown_function_or_unknown_function_id.unknown_function_id
        else:
            unknown_function_id = unknown_function_or_unknown_function_id
        self.interpretation_map[unknown_function_id] = interpretation


def test_evaluation():
    from enumerators import enumerators
    generator = enumerators._generate_test_generators()
    generator.set_size(8)
    points = [(1, 2, 3), (2, 5, 6), (6, 1, 3), (10, 4, 6), (7, 1, 5)]
    eval_context = EvaluationContext()
    for expr in generator.generate():
        cur_sig = [None] * len(points)
        for i in range(len(points)):
            eval_context.set_valuation_map(points[i])
            cur_sig[i] = evaluate_expression_raw(expr, eval_context)
        # print((exprs.expression_to_string(expr), tuple(cur_sig)))

if __name__ == '__main__':
    test_evaluation()

#
# evaluation.py ends here
