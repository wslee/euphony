#!/usr/bin/env python3
# expr_transforms.py ---
#
# Filename: expr_transforms.py
# Author: Abhishek Udupa
# Created: Wed Sep  2 18:19:39 2015 (-0400)
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

from utils import basetypes
from exprs import exprs
from exprs import exprtypes
from semantics import semantics_types
import itertools

_expr_to_str = exprs.expression_to_string

class ExprTransformerBase(object):
    def __init__(self, transform_name):
        self.transform_name = transform_name
        self.expr_stack = []

    def _matches_expression_any(self, expr_object, *fun_names):
        fun_name_set = set(fun_names)
        if (expr_object.expr_kind != exprs.ExpressionKinds.function_expression):
            return False
        return (expr_object.function_info.function_name in fun_name_set)

class LetFlattener(ExprTransformerBase):
    def __init__(self):
        super().__init__('LetFlattener')

    def _do_transform(expr, syn_ctx):
        if not exprs.is_function_expression(expr):
            return expr

        new_children = [ LetFlattener._do_transform(child, syn_ctx) 
                for child in expr.children ]
        if exprs.is_application_of(expr, 'let'):
            in_expr = new_children[-1]
            sub_pairs = list(zip(expr.function_info.binding_vars, new_children[:-1]))
            return exprs.substitute_all(in_expr, sub_pairs)
        else:
            return exprs.FunctionExpression(expr.function_info, tuple(new_children))

    def apply(constraints, syn_ctx):
        return [ LetFlattener._do_transform(constraint, syn_ctx) for constraint in constraints ]

# Assumes NNF
class LIAFlattener(ExprTransformerBase):
    def __init__(self):
        super().__init__('LIAFlattening')

    def _do_transform(self, expr_object, syn_ctx):
        neg = {
                '<=':'>',
                '<':'>=',
                '>=':'<',
                '>':'<=',
                '=':'ne',
                'ne':'=',
                }
        if not exprs.is_function_expression(expr_object):
            return expr_object

        function_info = expr_object.function_info
        function_name = function_info.function_name

        if function_name in [ 'and', 'or' ]:
            children = [ self._do_transform(child, syn_ctx) for child in expr_object.children ]
            return exprs.FunctionExpression(function_info, tuple(children))
        elif function_name in [ '<=', '>=', '<', '>', '=', 'eq', 'ne' ]:
            children = [ self._do_transform(child, syn_ctx) for child in expr_object.children ]
            return syn_ctx.make_function_expr(function_name, *children)
        elif (
                function_name in [ 'not' ] and 
                exprs.is_function_expression(expr_object.children[0]) and
                expr_object.children[0].function_info.function_name in [ '<=', '>=', '<', '>', '=', 'eq', 'ne' ]
                ):
            child = expr_object.children[0]
            child_func_name = child.function_info.function_name
            ret_func_name = neg[child_func_name]
            return syn_ctx.make_function_expr(ret_func_name, *child.children)
        elif function_name in [ 'add' ]:
            children = [ self._do_transform(child, syn_ctx) for child in expr_object.children ]
            new_children = []
            for child in children:
                if exprs.is_function_expression(child) and child.function_info.function_name == 'add':
                    new_children.extend(child.children)
                else:
                    new_children.append(child)
            return syn_ctx.make_function_expr('add', *new_children)
        elif function_name in [ 'sub', 'mul', '-' ]:
            children = [ self._do_transform(child, syn_ctx) for child in expr_object.children ]
            return syn_ctx.make_function_expr(function_name, *children)
        else:
            return expr_object
            # raise NotImplementedError("Function %s" % function_name)

    def apply(self, *args):
        if (len(args) != 2):
            raise basetypes.ArgumentError('LIAFlattener.apply() must be called with an ' +
                                          'expression object and a synthesis context object')
        return self._do_transform(args[0], args[1])

class AckermannReduction(ExprTransformerBase):
    def __init__(self):
        super().__init__('AckermannReduction')

    # Eliminate the uninterpreted functions by adding more universal variables
    def apply(constraints, uf_instantiator, syn_ctx):
        import random
        conds = []
        all_apps = set()
        for uf_name, uf_info in uf_instantiator.get_functions().items():
            uf_apps = set()
            for c in constraints:
                uf_apps |= set(exprs.find_all_applications(c, uf_name))
            all_apps |= uf_apps

            while len(uf_apps) > 0:
                uf_app1 = uf_apps.pop()
                for uf_app2 in uf_apps:
                    app1_args, app2_args = uf_app1.children, uf_app2.children
                    args_eq_expr = [ syn_ctx.make_function_expr('=', a1, a2)
                            for (a1, a2) in zip(app1_args, app2_args) ]
                    output_neq_expr = syn_ctx.make_function_expr('ne', uf_app1, uf_app2)
                    cond = syn_ctx.make_function_expr('and', output_neq_expr, *args_eq_expr)
                    conds.append(cond)

        if len(conds) > 0:
            constraints = [ syn_ctx.make_function_expr('or', *conds, constraint)
                    for constraint in constraints ]
        for app in sorted(all_apps, key=exprs.get_expression_size):
            var = syn_ctx.make_variable_expr(app.function_info.range_type,
                    'ufcall_' + app.function_info.function_name + '_' + str(random.randint(1, 1000000)))
            constraints = [ exprs.substitute(constraint, app, var)
                    for constraint in constraints ]
        return constraints

class RewriteITE(ExprTransformerBase):
    def apply(constraints, syn_ctx):
        new_constraints = []
        found_one = False
        for constraint in constraints:
            ite = exprs.find_application(constraint, 'ite')
            if ite is None:
                new_constraints.append(constraint)
                continue
            else:
                found_one = True
                cond, tt, ff = ite.children
                tc = syn_ctx.make_function_expr('or', exprs.substitute(constraint, ite, tt), syn_ctx.make_function_expr('not', cond))
                fc = syn_ctx.make_function_expr('or', exprs.substitute(constraint, ite, ff), cond)
                new_constraints.append(tc)
                new_constraints.append(fc)
        if found_one:
            return RewriteITE.apply(new_constraints, syn_ctx)
        else:
            return new_constraints


class NNFConverter(ExprTransformerBase):
    def __init__(self):
        super().__init__('NNFConverter')

    def _eliminate_complex(self, expr_object, syn_ctx):
        kind = expr_object.expr_kind
        if (kind != exprs.ExpressionKinds.function_expression):
            return expr_object
        elif (not self._matches_expression_any(expr_object, 'and', 'or',
                                               'implies', '=>', 'iff', 'xor',
                                               'not')):
            return expr_object
        else:
            function_info = expr_object.function_info
            function_name = function_info.function_name
            transformed_children = [self._eliminate_complex(x, syn_ctx)
                                    for x in expr_object.children]
            if (function_name in [ '=>', 'implies' ]):
                c1 = syn_ctx.make_function_expr('not', transformed_children[0])
                return syn_ctx.make_ac_function_expr('or', c1, transformed_children[1])
            elif (function_name == 'iff'):
                c1 = transformed_children[0]
                c2 = transformed_children[1]
                not_c1 = syn_ctx.make_function_expr('not', c1)
                not_c2 = syn_ctx.make_function_expr('not', c2)
                c1_implies_c2 = syn_ctx.make_ac_function_expr('or', not_c1, c2)
                c2_implies_c1 = syn_ctx.make_ac_function_expr('or', not_c2, c1)
                return syn_ctx.make_ac_function_expr('and', c1_implies_c2, c2_implies_c1)
            elif (function_name == 'xor'):
                c1 = transformed_children[0]
                c2 = transformed_children[1]
                not_c1 = syn_ctx.make_function_expr('not', c1)
                not_c2 = syn_ctx.make_function_expr('not', c2)
                c1_and_not_c2 = syn_ctx.make_ac_function_expr('and', c1, not_c2)
                c2_and_not_c1 = syn_ctx.make_ac_function_expr('and', c2, not_c1)
                return syn_ctx.make_ac_function_expr('or', c1_and_not_c2, c2_and_not_c1)
            else:
                return syn_ctx.make_function_expr(function_name, *transformed_children)


    def _do_transform(self, expr_object, syn_ctx, polarity):
        kind = expr_object.expr_kind
        if (kind != exprs.ExpressionKinds.function_expression):
            if (polarity):
                ret = expr_object
            else:
                ret = syn_ctx.make_function_expr('not', expr_object)

        elif (not self._matches_expression_any(expr_object, 'and', 'or', 'not')):
            if (polarity):
                ret = expr_object
            else:
                ret = syn_ctx.make_function_expr('not', expr_object)

        else:
            function_info = expr_object.function_info
            function_name = function_info.function_name
            if (function_name == 'not'):
                child_polarity = (not polarity)
            else:
                child_polarity = polarity

            transformed_children = [self._do_transform(x, syn_ctx, child_polarity)
                                    for x in expr_object.children]

            if (function_name == 'and'):
                if (polarity):
                    ret = syn_ctx.make_ac_function_expr('and', *transformed_children)
                else:
                    ret = syn_ctx.make_ac_function_expr('or', *transformed_children)
            elif (function_name == 'or'):
                if (polarity):
                    ret = syn_ctx.make_ac_function_expr('or', *transformed_children)
                else:
                    ret = syn_ctx.make_ac_function_expr('and', *transformed_children)
            elif (function_name == 'not'):
                ret = transformed_children[0]
            else:
                assert False
        return ret


    def apply(self, *args):
        if (len(args) != 2):
            raise basetypes.ArgumentError('NNFConverter.apply() must be called with an ' +
                                          'expression object and a synthesis context object')
        simple_expr = self._eliminate_complex(args[0], args[1])
        return self._do_transform(simple_expr, args[1], True)

class CNFConverter(ExprTransformerBase):
    def __init__(self):
        super().__init__('CNFConverter')

    def _flatten_and_or(self, expr_object, syn_ctx):
        kind = expr_object.expr_kind
        if (kind != exprs.ExpressionKinds.function_expression):
            return expr_object
        elif (not self._matches_expression_any(expr_object, 'and', 'or')):
            return expr_object
        else:
            func = expr_object.function_info
            new_children = []
            for child in expr_object.children:
                if not exprs.is_application_of(child, func):
                    new_children.append(self._flatten_and_or(child, syn_ctx))
                else:
                    childp = self._flatten_and_or(child, syn_ctx)
                    new_children.extend(childp.children)
            return syn_ctx.make_function_expr(func, *new_children)

    def _do_transform(self, expr_object, syn_ctx):
        """Requires: expression is in NNF."""

        kind = expr_object.expr_kind
        if (kind != exprs.ExpressionKinds.function_expression):
            return [expr_object]
        elif (not self._matches_expression_any(expr_object, 'and', 'or')):
            return [expr_object]
        else:
            function_info = expr_object.function_info
            num_children = len(expr_object.children)
            if (function_info.function_name == 'and'):
                clauses = []
                for i in range(num_children):
                    child = expr_object.children[i]
                    clauses.extend(self._do_transform(child, syn_ctx))
                return clauses
            elif (function_info.function_name == 'or'):
                transformed_children = []
                for i in range(num_children):
                    child = expr_object.children[i]
                    transformed_children.append(self._do_transform(child, syn_ctx))

                clauses = []
                for prod_tuple in itertools.product(*transformed_children):
                    clause = syn_ctx.make_ac_function_expr('or', *prod_tuple)
                    clause = self._flatten_and_or(clause, syn_ctx)
                    clauses.append(clause)
                return clauses

    def apply(self, *args):
        # arg0 : expr, arg1 : syn_ctx
        if (len(args) != 2):
            raise basetypes.ArgumentError('CNFConverter.apply() must be called with ' +
                                          'an expression and a synthesis context object')
        nnf_converter = NNFConverter()
        nnf_expr = nnf_converter.apply(args[0], args[1])
        flatted_nnf_expr = self._flatten_and_or(nnf_expr, args[1])
        clauses = self._do_transform(flatted_nnf_expr, args[1])
        return (clauses, args[1].make_ac_function_expr('and', *clauses))
        # return ([args[0]], args[0])

def check_expr_binding_to_context(expr, syn_ctx):
    kind = expr.expr_kind
    if (kind == exprs.ExpressionKinds.variable_expression):
        if (not syn_ctx.validate_variable(expr.variable_info)):
            raise TypeError(('Expression %s was not formed using the given ' +
                             'context!') % exprs.expression_to_string(expr))
    elif (kind == exprs.ExpressionKinds.function_expression):
        if (not syn_ctx.validate_function(expr.function_info)):
            raise TypeError(('Expression %s was not formed using the given ' +
                             'context!') % exprs.expression_to_string(expr))
        for child in expr.children:
            check_expr_binding_to_context(child, syn_ctx)
    elif (kind == exprs.ExpressionKinds.formal_parameter_expression):
        raise TypeError(('Expression %s contains a formal parameter! Specifications ' +
                         'are not allowed to contain formal ' +
                         'parameters!') % (exprs.expression_to_string(expr)))
    else:
        return

def _get_synth_function_invocation_args(expr):
    kind = expr.expr_kind
    retval = set()
    if (kind == exprs.ExpressionKinds.function_expression):
        if (expr.function_info.function_kind == semantics_types.FunctionKinds.synth_function):
            retval.add(expr.children)
        for child in expr.children:
            retval = retval | _get_synth_function_invocation_args(child)
    return retval


def check_single_invocation_property(expr, syn_ctx):
    """Checks if the expression has only one synth function, and also
    that the expression satisfies the single invocation property, i.e.,
    the synth function appears only in one syntactic form in the expression."""
    if (not isinstance(expr, list)):
        synth_function_set = gather_synth_functions(expr)
    else:
        synth_function_set = set()
        for clause in expr:
            synth_function_set = synth_function_set | gather_synth_functions(clause)

    if (len(synth_function_set) > 1):
        domain_types_set = set([ sf.domain_types for sf in synth_function_set ])
        if len(domain_types_set) > 1:
            return False

    if (not isinstance(expr, list)):
        cnf_converter = CNFConverter()
        (clauses, cnf_expr) = cnf_converter.apply(expr, syn_ctx)
    else:
        clauses = expr

    for clause in clauses:
        fun_arg_tuples = _get_synth_function_invocation_args(clause)
        if (len(fun_arg_tuples) > 1):
            return False

    return True

def _gather_variables(expr, accumulator, bound_vars):
    kind = expr.expr_kind
    if (kind == exprs.ExpressionKinds.variable_expression):
        if expr not in bound_vars:
            accumulator.add(expr)
    elif (kind == exprs.ExpressionKinds.function_expression):
        if expr.function_info.function_name == 'let':
            bound_vars = bound_vars | set(expr.function_info.binding_vars)
        for child in expr.children:
            _gather_variables(child, accumulator, bound_vars)

def gather_variables(expr):
    """Gets the set of variable expressions present in the expr."""
    var_set = set()
    _gather_variables(expr, var_set, set())
    return var_set

def _gather_synth_functions(expr, fun_set):
    kind = expr.expr_kind
    if (kind == exprs.ExpressionKinds.function_expression):
        if (isinstance(expr.function_info, semantics_types.SynthFunction)):
            fun_set.add(expr.function_info)
        for child in expr.children:
            _gather_synth_functions(child, fun_set)

def gather_synth_functions(expr):
    fun_set = set()
    _gather_synth_functions(expr, fun_set)
    return fun_set

def _intro_new_universal_vars(clauses, syn_ctx, uf_info):
    intro_vars = [syn_ctx.make_variable_expr(uf_info.domain_types[i], '_intro_var_%d' % i)
                  for i in range(len(uf_info.domain_types))]
    retval = []
    for clause in clauses:
        arg_tuples = _get_synth_function_invocation_args(clause)
        if len(arg_tuples) == 0:
            continue
        arg_tuple = arg_tuples.pop()
        eq_constraints = []
        for i in range(len(arg_tuple)):
            arg = arg_tuple[i]
            var = intro_vars[i]
            eq_constraints.append(syn_ctx.make_function_expr('ne', arg, var))
        if (clause.expr_kind == exprs.ExpressionKinds.function_expression and
            clause.function_info.function_name == 'or'):
            clause_disjuncts = clause.children
        else:
            clause_disjuncts = [clause]

        for i in range(len(arg_tuple)):
            clause_disjuncts = [exprs.substitute(c, arg_tuple[i], intro_vars[i])
                                for c in clause_disjuncts]
        eq_constraints.extend(clause_disjuncts)
        retval.append(syn_ctx.make_ac_function_expr('or', *eq_constraints))
    return (retval, intro_vars)

def canonicalize_multipoint_specification(expr, syn_ctx):
    orig_variable_set = gather_variables(expr)
    orig_variable_list = [x.variable_info for x in orig_variable_set]

    variable_list = orig_variable_list
    for i, v in enumerate(variable_list):
        v.variable_eval_offset = i

    return (variable_list, expr)

def to_cnf(expr, theory, syn_ctx):
    cnf_converter = CNFConverter()
    clauses, cnf_expr = cnf_converter.apply(expr, syn_ctx)

    if theory == 'LIA': 
        lia_flattener = LIAFlattener()
        cnf_expr = lia_flattener.apply(cnf_expr, syn_ctx)
        clauses = [ lia_flattener.apply(c, syn_ctx) for c in clauses ]

    return clauses, cnf_expr

def is_single_invocation(constraints, theory, syn_ctx):
    expr = syn_ctx.make_function_expr('and', *constraints)
    clauses, _ = to_cnf(expr, theory, syn_ctx)
    return check_single_invocation_property(clauses, syn_ctx)

def canonicalize_specification(expr, syn_ctx, theory):
    """Performs a bunch of operations:
    1. Checks that the expr is "well-bound" to the syn_ctx object.
    2. Checks that the specification has the single-invocation property.
    3. Gathers the set of synth functions (should be only one).
    4. Gathers the variables used in the specification.
    5. Converts the specification to CNF (as part of the single-invocation test)
    6. Given that the spec is single invocation, rewrites the CNF spec (preserving and sat)
       by introducing new variables that correspond to a uniform way of invoking the
       (single) synth function

    Returns a tuple containing:
    1. A list of 'variable_info' objects corresponding to the variables used in the spec
    2. A list of synth functions (should be a singleton list)
    3. A list of clauses corresponding to the CNF specification
    4. A list of NEGATED clauses
    5. A list containing the set of formal parameters that all appearances of the synth
       functions are invoked with.
    """
    check_expr_binding_to_context(expr, syn_ctx)
    clauses, cnf_expr = to_cnf(expr, theory, syn_ctx)

    synth_function_set = gather_synth_functions(expr)
    synth_function_list = list(synth_function_set)
    num_funs = len(synth_function_list)

    orig_variable_set = gather_variables(expr)
    orig_variable_list = [x.variable_info for x in orig_variable_set]
    orig_variable_list.sort(key=lambda x: x.variable_name)

    # check single invocation/separability properties
    if (not check_single_invocation_property(clauses, syn_ctx)):
        raise basetypes.ArgumentError('Spec:\n%s\nis not single-invocation!' %
                                      exprs.expression_to_string(expr))

    (intro_clauses, intro_vars) = _intro_new_universal_vars(clauses, syn_ctx,
                                                            synth_function_list[0])

    # ensure that the intro_vars at the head of the list
    # Arjun: Why? Most likely not necessary
    variable_list = [x.variable_info for x in intro_vars] + orig_variable_list
    num_vars = len(variable_list)
    for i in range(num_vars):
        variable_list[i].variable_eval_offset = i
    num_funs = len(synth_function_list)
    for i in range(num_funs):
        synth_function_list[i].synth_function_id = i

    if len(intro_clauses) == 1:
        canon_spec = intro_clauses[0]
    else:
        canon_spec = syn_ctx.make_function_expr('and', *intro_clauses)

    canon_clauses = []
    for ic in intro_clauses:
        if exprs.is_application_of(ic, 'or'):
            disjuncts = ic.children
        else:
            disjuncts = [ic]
        canon_clauses.append(disjuncts)

    return (variable_list, synth_function_list, canon_spec,
            canon_clauses, intro_vars)

#######################################################################
# TEST CASES
#######################################################################

def test_cnf_conversion():
    from core import synthesis_context
    from semantics import semantics_core
    from semantics import semantics_lia

    syn_ctx = synthesis_context.SynthesisContext(semantics_core.CoreInstantiator(),
                                                 semantics_lia.LIAInstantiator())
    var_exprs = [syn_ctx.make_variable_expr(exprtypes.IntType(), 'x%d' % i) for i in range(10)]
    max_fun = syn_ctx.make_synth_function('max', [exprtypes.IntType()] * 10,
                                            exprtypes.IntType())
    max_app = syn_ctx.make_function_expr(max_fun, *var_exprs)
    max_ge_vars = [syn_ctx.make_function_expr('ge', max_app, var_expr) for var_expr in var_exprs]
    max_eq_vars = [syn_ctx.make_function_expr('eq', max_app, var_expr) for var_expr in var_exprs]
    formula1 = syn_ctx.make_ac_function_expr('or', *max_eq_vars)
    formula2 = syn_ctx.make_ac_function_expr('and', *max_ge_vars)
    formula = syn_ctx.make_ac_function_expr('and', formula1, formula2)

    cnf_converter = CNFConverter()
    cnf_clauses, cnf_expr = cnf_converter.apply(formula, syn_ctx)
    # print(exprs.expression_to_string(cnf_expr))
    # print([exprs.expression_to_string(cnf_clause) for cnf_clause in cnf_clauses])

    # print(check_single_invocation_property(formula, syn_ctx))
    binary_max = syn_ctx.make_synth_function('max2', [exprtypes.IntType(),
                                                        exprtypes.IntType()],
                                               exprtypes.IntType())
    binary_max_app = syn_ctx.make_function_expr(binary_max, var_exprs[0], var_exprs[1])
    binary_max_app_rev = syn_ctx.make_function_expr(binary_max, var_exprs[1], var_exprs[0])
    # non_separable = syn_ctx.make_function_expr('eq', binary_max_app, binary_max_app_rev)
    # print(check_single_invocation_property(non_separable, syn_ctx))

    # max_rec = syn_ctx.make_function_expr(binary_max, binary_max_app, binary_max_app)
    # non_separable2 = syn_ctx.make_function_expr('eq', max_rec, binary_max_app)
    # print(check_single_invocation_property(non_separable2, syn_ctx))

    canonicalize_specification(formula, syn_ctx)

    separable1 = syn_ctx.make_function_expr('ge', binary_max_app, var_exprs[0])
    separable2 = syn_ctx.make_function_expr('ge', binary_max_app_rev, var_exprs[0])
    separable3 = syn_ctx.make_ac_function_expr('or',
                                               syn_ctx.make_function_expr('eq',
                                                                          binary_max_app,
                                                                          var_exprs[0]),
                                               syn_ctx.make_function_expr('eq',
                                                                          binary_max_app,
                                                                          var_exprs[1]))
    separable = syn_ctx.make_ac_function_expr('and', separable1, separable2, separable3)
    # print(check_single_invocation_property(separable, syn_ctx))
    canonicalize_specification(separable, syn_ctx)

if __name__ == '__main__':
    test_cnf_conversion()

#
# expr_transforms.py ends here
