#!/usr/bin/env python3
# grammars.py ---
#
# Filename: grammars.py
# Author: Arjun Radhakrishna
# Created: Wed, 01 Jun 2016 10:10:59 -0400
#
#
# Copyright (c) 2015, Arjun Radhakrishna, University of Pennsylvania
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
import itertools
from exprs import exprtypes
from semantics import semantics_types
import random
from exprs import exprs
from enumerators import enumerators

def _nt_to_generator_name(nt):
    return nt + '_Generator'

class RewriteBase(object):
    def __init__(self, type):
        self.type = type

    def to_template_expr(self):
        raise basetypes.AbstractMethodError('RewriteBase.to_template_expr()')

    def rename_nt(self, old_name, new_name):
        raise basetypes.AbstractMethodError('RewriteBase.rename_nt()')

    def substitute_expr(self, old, new):
        raise basetypes.AbstractMethodError('RewriteBase.substitute_expr()')

    def str(self):
        raise basetypes.AbstractMethodError('RewriteBase.str()')

    def __str__(self):
        return self.str()

    def __hash__(self):
        return hash(self.str())


class ExpressionRewrite(RewriteBase):
    def __init__(self, expr):
        super().__init__(exprs.get_expression_type(expr))
        self.expr = expr

    def str(self):
        return exprs.expression_to_string(self.expr)

    def to_template_expr(self):
        return [], [], self.expr

    def rename_nt(self, old_name, new_name):
        return self

    def __eq__(self, other):
        if isinstance(other, ExpressionRewrite):
            return other.expr == self.expr
        return False

    def __hash__(self):
        return hash(self.expr)

    def substitute_expr(self, old, new):
        self.expr = exprs.substitute(self.expr, old, new)

class NTRewrite(RewriteBase):
    counter = 0
    def __init__(self, non_terminal, nt_type):
        super().__init__(nt_type)
        self.non_terminal = non_terminal

    def str(self):
        return self.non_terminal

    def to_template_expr(self):
        import random
        name = self.non_terminal + '_ph_' + str(NTRewrite.counter)# str(random.randint(1, 1000000))
        NTRewrite.counter += 1
        ph_var = exprs.VariableExpression(exprs.VariableInfo(self.type, name))
        return [ph_var], [self.non_terminal], ph_var

    def rename_nt(self, old_name, new_name):
        if self.non_terminal == old_name:
            return NTRewrite(new_name, self.type)
        else:
            return self

    def __eq__(self, other):
        if isinstance(other, NTRewrite):
            return other.non_terminal == self.non_terminal
        return False

    def __hash__(self):
        return hash(self.str())

    def substitute_expr(self, old, new):
        pass

class FunctionRewrite(RewriteBase):
    def __init__(self, function_info, *children):
        super().__init__(function_info.range_type)
        self.function_info = function_info
        self.children = children

    def str(self):
        return '(' + self.function_info.function_name + ' ' + \
            ' '.join([ x.str() for x in self.children ]) + ')'

    def to_template_expr(self):
        ph_vars = []
        nts = []
        child_exprs = []
        for child in self.children:
            curr_ph_vars, curr_nts, child_expr = child.to_template_expr()
            ph_vars.extend(curr_ph_vars)
            nts.extend(curr_nts)
            child_exprs.append(child_expr)
        expr_template = exprs.FunctionExpression(self.function_info, tuple(child_exprs))
        return ph_vars, nts, expr_template

    def __eq__(self, other):
        if isinstance(other, FunctionRewrite):
            return (other.function_info == self.function_info and
                    all(c1 == c2 for (c1, c2) in zip(self.children, other.children)))
        return False

    def substitute_expr(self, old, new):
        for child in self.children:
            child.substitute_expr(old, new)

    def to_generator(self, place_holders):
        ph_vars, nts, expr_template = self.to_template_expr()
        if len(ph_vars) == 0:
            return enumerators.LeafGenerator([expr_template])
        sub_gens = [ place_holders[_nt_to_generator_name(nt)] for nt in nts ]
        
        # Try some pruning rules
        if (len(self.children) == 2 and
                self.function_info.commutative and
                self.children[0] == self.children[1]):
            good_size_tuple = enumerators.commutative_good_size_tuple
        else:
            good_size_tuple = enumerators.default_good_size_tuple
        return enumerators.ExpressionTemplateGenerator(expr_template, ph_vars, sub_gens, good_size_tuple=good_size_tuple)

    def rename_nt(self, old_name, new_name):
        new_children = [ child.rename_nt(old_name, new_name) 
                for child in self.children ]
        return FunctionRewrite(self.function_info, *new_children)

    def __hash__(self):
        return hash(self.str())


def expr_template_to_rewrite(expr_template, ph_var_nt_map, grammar):
    if expr_template in ph_var_nt_map:
        nt = ph_var_nt_map[expr_template]
        nt_type = grammar.nt_type[nt]
        return NTRewrite(nt, nt_type)
    elif exprs.is_function_expression(expr_template):
        children = [ expr_template_to_rewrite(child, ph_var_nt_map, grammar) 
                for child in expr_template.children ]
        return FunctionRewrite(expr_template.function_info, *children)
    else:
        return ExpressionRewrite(expr_template)

def make_default_grammar(syn_ctx, theory, return_type, args):
    int_type = exprtypes.IntType()
    bool_type = exprtypes.BoolType()
    if theory == 'LIA':
        [ start, start_bool, const ] = [ 'Start', 'StartBool', 'ConstantIntegerType' ]
        nts = [ start, start_bool, const ]
        nt_type = { start:int_type, start_bool:bool_type,
                const:int_type }
        rules = { start:[], start_bool:[], const:[] }

        ntr_start = NTRewrite(start, int_type)
        ntr_startbool = NTRewrite(start_bool, bool_type)
        ntr_const = NTRewrite(const, int_type)

        [ add_func, sub_func, mul_func, div_func, mod_func ] = \
                [ syn_ctx.make_function(name, int_type, int_type)
                        for name in [ 'add', 'sub', 'mul', 'div', 'mod' ] ]
        ite_func = syn_ctx.make_function('ite', bool_type, int_type, int_type)

        [ and_func, or_func ] = \
                [ syn_ctx.make_function(name, bool_type, bool_type)
                        for name in [ 'and', 'or' ] ]
        not_func = syn_ctx.make_function('not', bool_type) 

        [ eq_func, ne_func, le_func, lt_func, ge_func, gt_func ] = \
                [ syn_ctx.make_function(name, int_type, int_type)
                        for name in [ '=', 'ne', '<=', '<', '>=', '>' ] ]

        # Start rules:
        # Args 
        for arg in args:
            if exprs.get_expression_type(arg) == int_type:
                rules[start].append(ExpressionRewrite(arg))
            elif exprs.get_expression_type(arg) == bool_type:
                rules[start_bool].append(ExpressionRewrite(arg))

        # Constants
        rules[start].append(ExpressionRewrite(exprs.ConstantExpression(exprs.Value(1, int_type))))
        rules[start].append(ExpressionRewrite(exprs.ConstantExpression(exprs.Value(0, int_type))))
        rules[start].append(ntr_const)
        # Start + Start, Start - Start,
        rules[start].append(FunctionRewrite(add_func, ntr_start, ntr_start))
        rules[start].append(FunctionRewrite(sub_func, ntr_start, ntr_start))
        # Start * Constant, Start / Constant, Start mod Constant
        rules[start].append(FunctionRewrite(mul_func, ntr_start, ntr_start))
        rules[start].append(FunctionRewrite(div_func, ntr_start, ntr_start))
        rules[start].append(FunctionRewrite(mod_func, ntr_start, ntr_start))
        # ITE
        rules[start].append(FunctionRewrite(ite_func, ntr_startbool, ntr_start, ntr_start))

        # Start bool rules
        # And, or, not
        rules[start_bool].append(ExpressionRewrite(exprs.ConstantExpression(exprs.Value(False, bool_type))))
        rules[start_bool].append(ExpressionRewrite(exprs.ConstantExpression(exprs.Value(True, bool_type))))
        rules[start_bool].append(FunctionRewrite(and_func, ntr_startbool, ntr_startbool))
        rules[start_bool].append(FunctionRewrite(or_func, ntr_startbool, ntr_startbool))
        rules[start_bool].append(FunctionRewrite(not_func, ntr_startbool))
        # comparison ops
        rules[start_bool].append(FunctionRewrite(eq_func, ntr_start, ntr_start))
        rules[start_bool].append(FunctionRewrite(ne_func, ntr_start, ntr_start))
        rules[start_bool].append(FunctionRewrite(le_func, ntr_start, ntr_start))
        rules[start_bool].append(FunctionRewrite(lt_func, ntr_start, ntr_start))
        rules[start_bool].append(FunctionRewrite(ge_func, ntr_start, ntr_start))
        rules[start_bool].append(FunctionRewrite(gt_func, ntr_start, ntr_start))

        # Constant rules 
        rules[const].append(ExpressionRewrite(exprs.ConstantExpression(exprs.Value(1, int_type))))
        rules[const].append(ExpressionRewrite(exprs.ConstantExpression(exprs.Value(0, int_type))))
        rules[const].append(FunctionRewrite(add_func, ntr_const, ntr_const))
        rules[const].append(FunctionRewrite(add_func, ntr_const, ntr_const))
        rules[const].append(FunctionRewrite(sub_func, ntr_const, ntr_const))

        if return_type == int_type:
            ret = Grammar(nts, nt_type, rules, start)
        elif return_type == bool_type:
            ret = Grammar(nts, nt_type, rules, start_bool)
        else:
            raise NotImplementedError
        ret.from_default = True
        return ret
    elif theory == 'BV':
        from semantics import semantics_bv
        from semantics import semantics_core
        print("ARSAYS: Default bit-vec grammar shouldn't be used!")
        (start, start_bool) = ('Start', 'StartBool')
        bv_size = 64
        nts = [ start, start_bool ]
        (bv_type, bool_type) = (exprtypes.BitVectorType(bv_size), exprtypes.BoolType())
        nt_type = { start:bv_type, start_bool:bool_type }
        rules = { start:[], start_bool:[] }

        ntr_start = NTRewrite(start, bv_type)
        ntr_start_bool = NTRewrite(start_bool, bool_type)

        rules[start].extend(map(
            lambda x: ExpressionRewrite(exprs.ConstantExpression(exprs.Value(x, bv_type))),
            [0, 1]))

        for func in [
                semantics_bv.BVNot(bv_size),
                semantics_bv.BVAdd(bv_size),
                semantics_bv.BVAnd(bv_size),
                semantics_bv.BVOr(bv_size),
                semantics_bv.BVNeg(bv_size),
                semantics_bv.BVAdd(bv_size),
                semantics_bv.BVMul(bv_size),
                semantics_bv.BVSub(bv_size),
                semantics_bv.BVUDiv(bv_size),
                semantics_bv.BVSDiv(bv_size),
                semantics_bv.BVSRem(bv_size),
                semantics_bv.BVURem(bv_size),
                semantics_bv.BVShl(bv_size),
                semantics_bv.BVLShR(bv_size),
                semantics_bv.BVAShR(bv_size),
                semantics_bv.BVUlt(bv_size),
                semantics_bv.BVUle(bv_size),
                semantics_bv.BVUge(bv_size),
                semantics_bv.BVUgt(bv_size),
                semantics_bv.BVSle(bv_size),
                semantics_bv.BVSlt(bv_size),
                semantics_bv.BVSge(bv_size),
                semantics_bv.BVSgt(bv_size),
                semantics_bv.BVXor(bv_size),
                semantics_bv.BVXNor(bv_size),
                semantics_bv.BVNand(bv_size),
                semantics_bv.BVNor(bv_size),
                # semantics_bv.BVComp(bv_size)
                semantics_core.EqFunction(bv_type)
                ]:
            assert all([ t == bv_type for t in func.domain_types ])
            args = [ ntr_start ] * len(func.domain_types)

            if func.range_type == bv_type:
                rules[start].append(FunctionRewrite(func, *args))
            elif func.range_type == bool_type:
                rules[start_bool].append(FunctionRewrite(func, *args))
            else:
                assert False
        ite_func = semantics_core.IteFunction(bv_type)
        rules[start].append(FunctionRewrite(ite_func, ntr_start_bool, ntr_start, ntr_start))

        if return_type == bv_type:
            ret = Grammar(nts, nt_type, rules, start)
        elif return_type == bool_type:
            ret = Grammar(nts, nt_type, rules, start_bool)
        else:
            raise NotImplementedError
        ret.from_default = True
        return ret
    elif theory == 'SLIA':
        raise NotImplementedError
    else:
        raise NotImplementedError

def identify_lia_grammars(synth_fun, grammar):
    # We want to identify difference bounds, octogons, and full linear arithmetic

    # We check the following:
    # Start rewrites to variables, at least 0,1, Start + Start, Start - Start, ite (Cond) Start Start
    # Cond rewrites to Start <= Start, Start < Start, etc
    
    start = grammar.start
    # Can start rewrite to all arguments?
    expr_rewrites = []
    func_rewrites = []
    for rewrite in grammar.rules[start]:
        if type(rewrite) == ExpressionRewrite:
            expr_rewrites.append(rewrite)
        elif type(rewrite) == FunctionRewrite:
            func_rewrites.append(rewrite)
        else:
            # We really should be doing this transitively
            pass

    formal_params = set()
    consts = set()
    for er in expr_rewrites:
        expr = er.expr
        if exprs.is_formal_parameter_expression(expr):
            formal_params.add(expr)
        elif exprs.is_constant_expression(expr):
            consts.add(expr.value_object.value_object)
    if len(formal_params) != len(synth_fun.domain_types):
        return None
    if not (0 in consts) or not (1 in consts):
        return None

    funcs = set()
    has_ite = False
    ite_cond_nt = False
    for fr in func_rewrites:
        if ( len(fr.children) == 2 and
                all( [ type(c) == NTRewrite for c in fr.children ]) and
                all( [ c.non_terminal == start for c in fr.children ])):
            funcs.add(fr.function_info.function_name)

        if ( fr.function_info.function_name == 'ite' and 
                all( [ type(c) == NTRewrite for c in fr.children ]) and
                all( [ c.non_terminal == start for c in fr.children[1:] ])):
            has_ite = True
            ite_cond_nt = fr.children[0].non_terminal

    if ('+' not in funcs or not has_ite):
        return None

    comparators = set()
    combination_funcs = set()
    for r in grammar.rules[ite_cond_nt]:
        if type(r) != FunctionRewrite:
            continue
        if (r.function_info.function_name in [ 'and', 'or', 'not' ] and
                all([ type(c) == NTRewrite for c in r.children ]) and
                all([ c.non_terminal == ite_cond_nt for c in r.children])):
            combination_funcs.add(r.function_info.function_name)
        if (r.function_info.function_name in [ '<=', '<', '>=', '>', '=' ] and
                all([ type(c) == NTRewrite for c in r.children ]) and
                all([ c.non_terminal == start for c in r.children])):
            comparators.add(r.function_info.function_name)
    if '<=' not in comparators and '<' not in comparators:
        return None

    # Term stuff
    boolean_combs = ('and' in combination_funcs) and ('or' in combination_funcs) and ('not' in combination_funcs)
    negatives = ('-' in funcs)
    constant_multiplication = ('*' in funcs)
    div = ('div' in funcs) 
    mod = ('mod' in funcs)

    return (boolean_combs, comparators, consts, negatives, constant_multiplication, div, mod)






class Grammar(object):
    def __init__(self, non_terminals, nt_type, rules, start='Start'):
        self.non_terminals = non_terminals
        self.nt_type = nt_type
        self.rules = rules
        self.start = start
        self.from_default = False
        self.compute_rule_to_nt_addrs()


    # for PHOG guided search
    def compute_rule_to_nt_addrs(self):
        def ntaddrs_of_rewrite(rewrite, curr_addr):
            if type(rewrite) == NTRewrite:
                return [curr_addr]
            elif type(rewrite) == FunctionRewrite:
                result = []
                for i,child in enumerate(rewrite.children):
                    result.extend(ntaddrs_of_rewrite(child, curr_addr + [i]))
                return result
            else:
                return []

        self.rule_to_nt_addrs = {}
        for nt, rules in self.rules.items():
            self.rule_to_nt_addrs[nt] = []
            for rule in rules:
                nt_addrs = ntaddrs_of_rewrite(rule, [])
                # print(str(rule), ' ', nt_addrs)
                self.rule_to_nt_addrs[nt].append(nt_addrs)

    # for prioritizing enumeration
    # return : list of rewrites
    # for a given grammar S -> 0 | 1,
    # input : 0 S S -> output : [(S -> 0, 0 0 S), (S -> 1, 0 1 S)]
    # def one_step_expand(self, rewrite):
    #     if type(rewrite) == ExpressionRewrite:
    #         return [(rewrite, rewrite)]
    #     elif type(rewrite) == NTRewrite:
    #         nt = rewrite.non_terminal
    #         return [(rule, rule) for rule in self.rules[nt]]
    #     elif type(rewrite) == FunctionRewrite:
    #         left_most_child_index = 0
    #         for child in rewrite.children:
    #             ph_vars, nts, expr_template = child.to_template_expr()
    #             if len(nts) > 0: break
    #             else: left_most_child_index += 1
    #         # already fully expanded
    #         if (left_most_child_index == len(rewrite.children)): return [(rewrite, rewrite)]
    #         else:
    #             result = []
    #             for rule, expanded_child in self.one_step_expand(rewrite.children[left_most_child_index]):
    #                 children = list(rewrite.children)
    #                 children[left_most_child_index] = expanded_child
    #                 result.append((rule, FunctionRewrite(rewrite.function_info, *children)))
    #             return result
    #     else:
    #         raise Exception('Unknown rewrite type: %s' % str(type(rewrite)))

    # for a given grammar S -> 0 | 1 (+ S S),
    # input : (+ S S), [0]
    # output : [<(S -> (+ (+ S S) S), [0,0]> , <(S -> (+ 0 S), []>, , <(S -> (+ 1 S), []>]
    # inpur : addr of leftmost nt symbol -> output : addrs of nt symbols generated by expansion of the leftmost symbol.
    def one_step_expand(self, rewrite, leftmost_nt_addr):
        # print(rewrite, ' ', leftmost_nt_addr)
        if type(rewrite) == ExpressionRewrite:
            return [(rewrite, rewrite, [])]
        elif type(rewrite) == NTRewrite:
            result = []
            nt = rewrite.non_terminal
            for i, rule in enumerate(self.rules[nt]):
                # print(nt, ' ', str(rule))
                # print(self.rule_to_nt_addrs[nt][i])
                generated_nts_addrs = [leftmost_nt_addr + nt_addrs for nt_addrs in self.rule_to_nt_addrs[nt][i]]
                # print(generated_nts_addrs)
                result.append((rule, rule, generated_nts_addrs))
            return result
        elif type(rewrite) == FunctionRewrite:
            # already fully expanded
            if (len(leftmost_nt_addr) == 0): return [(rewrite, rewrite, [])]
            else:
                result = []
                left_most_child_index = leftmost_nt_addr[0]
                for rule, expanded_child, generated_nts_addrs in self.one_step_expand(rewrite.children[left_most_child_index], leftmost_nt_addr[1:]):
                    # print(generated_nts_addrs)
                    children = list(rewrite.children)
                    children[left_most_child_index] = expanded_child
                    generated_nts_addrs = [[left_most_child_index] + generated_nts_addr for generated_nts_addr in generated_nts_addrs]
                    result.append((rule, FunctionRewrite(rewrite.function_info, *children), generated_nts_addrs))
                return result
        else:
            raise Exception('Unknown rewrite type: %s' % str(type(rewrite)))

    def add_constant_rules(self, constant_rewrites):
        for const_rewrite in constant_rewrites:
            typ = const_rewrite.type
            nt = 'Constant' + str(typ)
            if nt not in self.non_terminals:
                self.non_terminals.append(nt)
                self.nt_type[nt] = typ
                self.rules[nt] = [ const_rewrite ]
            else:
                self.rules[nt].append(const_rewrite)
        # update rule_to_nt_addrs because the rules has been changed.
        self.compute_rule_to_nt_addrs()

    def __str__(self):
        return self.str()

    def str(self):
        ret = ""
        for nt in self.non_terminals:
            ret = ret + nt + "[" + str(self.nt_type[nt]) + "] ->\n"
            for rule in self.rules[nt]:
                ph_vars, nts, expr_template = rule.to_template_expr()
                ret = ret + "\t" + exprs.expression_to_string(expr_template) + "\n"
        return ret


    def add_prefix(self, prefix):
        def transform_rewrite(r):
            for nt in self.non_terminals:
                r = r.rename_nt(nt, prefix + nt)
            return r
        new_nts = [ prefix + nt for nt in self.non_terminals ]
        new_rules = {}
        for nt, rewrites in self.rules.items():
            new_rewrites = [ transform_rewrite(r) for r in rewrites ]
            new_rules[prefix + nt] = new_rewrites
        new_nt_type = {}
        for nt, typ in self.nt_type.items():
            new_nt_type[prefix + nt] = typ
        new_start = prefix + self.start
        return Grammar(new_nts, new_nt_type, new_rules, new_start)

    def to_generator(self, generator_factory=None):
        if generator_factory == None:
            generator_factory = enumerators.RecursiveGeneratorFactory()
        for nt in self.non_terminals:
            if not generator_factory.has_placeholder(_nt_to_generator_name(nt)):
                generator_factory.make_placeholder(_nt_to_generator_name(nt))
        place_holders = generator_factory.generator_map
        ret = None
        for nt in self.non_terminals:
            generators = []
            leaves = []
            for rewrite in self.rules[nt]:
                if type(rewrite) == ExpressionRewrite:
                    leaves.append(rewrite.expr)
                elif type(rewrite) == NTRewrite:
                    generators.append(place_holders[_nt_to_generator_name(rewrite.non_terminal)])
                elif type(rewrite) == FunctionRewrite:
                    generators.append(rewrite.to_generator(place_holders))
                else:
                    raise Exception('Unknown rewrite type: %s' % str(type(rewrite)))
            leaf_generator = enumerators.LeafGenerator(leaves)
            nt_generator = generator_factory.make_generator(_nt_to_generator_name(nt),
                    enumerators.AlternativesGenerator,
                            ([ leaf_generator ] + generators ,))
            if nt == self.start:
                ret = nt_generator
        return ret

    def copy_with_nt_rename(self, old_nt_name, new_nt_name):
        new_nts = [ nt if nt != old_nt_name else new_nt_name 
                for nt in self.non_terminals ]

        new_nt_type = self.nt_type.copy()
        type = new_nt_type.pop(old_nt_name)
        new_nt_type[new_nt_name] = type

        new_rules = {}
        for nt in self.non_terminals:
            rewrites = self.rules[nt]
            new_nt = nt if nt != old_nt_name else new_nt_name
            new_rules[new_nt] = [ rew.rename_nt(old_nt_name, new_nt_name)
                    for rew in rewrites ]
        return Grammar(new_nts, new_nt_type, new_rules)

    # Quick and dirty for now
    def decompose(self, macro_instantiator):
        start_nt = self.start
        reverse_mapping = []

        term_productions = []
        pred_productions = []
        for rewrite in self.rules[start_nt]:
            ph_vars, nts, orig_expr_template = rewrite.to_template_expr()
            ph_var_nt_map = dict(zip(ph_vars, nts))
            expr_template = macro_instantiator.instantiate_all(orig_expr_template)
            ifs = exprs.find_all_applications(expr_template, 'ite')

            # Either there are no ifs or it is an concrete expression
            if len(ifs) == 0 or len(nts) == 0:
                term_productions.append(rewrite)
                continue
            elif len(ifs) > 1 and ifs[0] != expr_template:
                return None

            [cond, thent, elset] = ifs[0].children
            cond_ph_vars = exprs.get_all_variables(cond) & set(ph_vars)
            then_ph_vars = exprs.get_all_variables(thent) & set(ph_vars)
            else_ph_vars = exprs.get_all_variables(elset) & set(ph_vars)
            if (
                    len(cond_ph_vars & then_ph_vars) > 0 or
                    len(cond_ph_vars & else_ph_vars) > 0 or
                    len(else_ph_vars & then_ph_vars) > 0):
                return None

            if (
                    thent not in ph_vars or \
                    elset not in ph_vars or \
                    ph_var_nt_map[thent] != start_nt or \
                    ph_var_nt_map[elset] != start_nt):
                return None

            cond_rewrite = expr_template_to_rewrite(cond, ph_var_nt_map, self)

            # Make dummy function to recognize predicate
            arg_var = exprs.VariableExpression(exprs.VariableInfo(exprtypes.BoolType(), 'd', 0))
            dummy_macro_func = semantics_types.MacroFunction(
                    'dummy_pred_id_' + str(random.randint(1, 1000000)), 1, (exprtypes.BoolType(),),
                    exprtypes.BoolType(), arg_var, [arg_var])
            pred_production = FunctionRewrite(dummy_macro_func, cond_rewrite)
            pred_productions.append(pred_production)
            
            reverse_mapping.append((dummy_macro_func, cond, orig_expr_template, expr_template))

        if len(pred_productions) == 0:
            return None

        # Non-terminals
        [ term_start, pred_start ] = [ x + start_nt for x in  [ 'Term', 'Pred' ] ]
        [ term_nts, pred_nts ] = [ self.non_terminals + [ x ] 
                for x in [ term_start, pred_start ]  ]
        term_nts.remove(start_nt)
        pred_nts.remove(start_nt)

        # Non-terminal types
        term_nt_type, pred_nt_type = self.nt_type.copy(), self.nt_type.copy()
        term_nt_type.pop(start_nt)
        term_nt_type[term_start] = self.nt_type[start_nt]
        pred_nt_type.pop(start_nt)
        pred_nt_type[pred_start] = exprtypes.BoolType()

        # Rules
        term_rules = {}
        term_rules[term_start] = [ rew.rename_nt(start_nt, term_start)
                for rew in term_productions ]
        for nt in self.non_terminals:
            if nt != start_nt:
                term_rules[nt] = [ rew.rename_nt(start_nt, term_start)
                for rew in self.rules[nt] ]

        pred_rules = {}
        pred_rules[pred_start] = [ rew.rename_nt(start_nt, term_start)
                for rew in pred_productions ]
        for nt in self.non_terminals:
            if nt != start_nt:
                pred_rules[nt] = [ rew.rename_nt(start_nt, term_start)
                for rew in self.rules[nt] ]
        # pred_rules[term_start] = term_rules[term_start]
        # pred_nt_type[term_start] = term_nt_type[term_start]
        pred_rules = {**term_rules, **pred_rules}
        pred_nt_type = {**term_nt_type, **pred_nt_type}
        term_grammar = Grammar(term_nts, term_nt_type, term_rules, term_start)
        pred_grammar = Grammar(pred_nts + [term_start], pred_nt_type, pred_rules, pred_start)
        # print(pred_grammar)
        return term_grammar, pred_grammar, reverse_mapping

# Tests:
