#!/usr/bin/env python3
# enumerators.py ---
#
# Filename: enumerators.py
# Author: Abhishek Udupa
# Created: Tue Aug 25 11:44:38 2015 (-0400)
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

from utils import utils
from exprs import evaluation
from utils import basetypes
import itertools
from exprs import exprs
from exprs import exprtypes
import time

# if __name__ == '__main__':
#     utils.print_module_misuse_and_exit()

def commutative_good_size_tuple(sizes):
    return sizes[0] >= sizes[1]

def default_good_size_tuple(sizes):
    return True

def cartesian_product_of_generators(*generators):
    """A generator that produces the cartesian product of the input
    "sub-generators."""
    tuple_size = len(generators)
    if (tuple_size == 1):
        for elem in generators[0].generate():
            yield (elem, )

    else:
        for sub_tuple in cartesian_product_of_generators(*generators[1:]):
            for elem in generators[0].generate():
                yield (elem, ) + sub_tuple


class GeneratorBase(object):
    object_counter = 0

    def __init__(self, name = None):
        if (name != None or name != ''):
            self.name = name
        else:
            self.name = 'AnonymousGenerator_%d' % self.object_counter
        self.object_counter += 1

    def generate(self):
        raise basetypes.AbstractMethodError('GeneratorBase.generate()')

    def set_size(self, new_size):
        raise basetypes.AbstractMethodError('GeneratorBase.set_size()')

    def clone(self):
        raise basetypes.AbstractMethodError('GeneratorBase.clone()')


class LeafGenerator(GeneratorBase):
    """A generator for leaf objects.
    Variables, constants and the likes."""

    def __init__(self, leaf_objects, name = None):
        super().__init__(name)
        self.leaf_objects = list(leaf_objects)
        self.iterable_size = len(self.leaf_objects)
        self.allowed_size = 0

    def generate(self):
        current_position = 0
        if (self.allowed_size != 1):
            return

        while (current_position < self.iterable_size):
            retval = self.leaf_objects[current_position]
            current_position += 1
            yield retval

    def set_size(self, new_size):
        self.allowed_size = new_size

    def clone(self):
        return LeafGenerator(self.leaf_objects, self.name)

class NonLeafGenerator(GeneratorBase):
    """A generator with sub generators."""

    def __init__(self, sub_generators, name=None):
        super().__init__(name)
        self.sub_generators = [x.clone() for x in sub_generators]
        self.arity = len(sub_generators)
        self.allowed_size = 0
        assert self.arity > 0
        self.good_size_tuple = default_good_size_tuple

    def set_size(self, new_size):
        self.allowed_size = new_size

    def _set_sub_generator_sizes(self, partition):
        assert (len(partition) == self.arity)

        for i in range(self.arity):
            self.sub_generators[i].set_size(partition[i])
        return

    def _instantiate(self, sub_exprs):
        raise basetypes.AbstractMethodError('NonLeafGenerator._instantiate()')

    def generate(self):
        if (self.allowed_size - 1 < self.arity):
            return

        for partition in utils.partitions(self.allowed_size - 1, self.arity):
            if not self.good_size_tuple(partition):
                continue
            self._set_sub_generator_sizes(partition)
            for product_tuple in cartesian_product_of_generators(*self.sub_generators):
                yield self._instantiate(product_tuple)


class ExpressionTemplateGenerator(NonLeafGenerator):
    """A generator for expressions with placeholders."""

    def __init__(self, expr_template, place_holder_vars, sub_generators, good_size_tuple, name=None):
        super().__init__(sub_generators, name)
        self.expr_template = expr_template
        self.place_holder_vars = place_holder_vars
        assert len(place_holder_vars) == len(sub_generators)
        if good_size_tuple is not None:
            self.good_size_tuple = good_size_tuple

    def _instantiate(self, sub_exprs):
        # print('TEMPLATE:', exprs.expression_to_string(self.expr_template))
        # print('PHS:', [ exprs.expression_to_string(p) for p in self.place_holder_vars ])
        # print('SUBS:', [ exprs.expression_to_string(s) for s in sub_exprs ])
        ret = exprs.substitute_all(self.expr_template, list(zip(self.place_holder_vars, sub_exprs)))
        # print('RES:', exprs.expression_to_string(ret))
        return ret

    def clone(self):
        return ExpressionTemplateGenerator(
                self.expr_template,
                self.place_holder_vars,
                [x.clone() for x in self.sub_generators],
                self.good_size_tuple,
                self.name)

class FunctionalGenerator(NonLeafGenerator):
    """A generator for function objects.
    Accepts a function symbol and a list of "sub-generators"
    and builds expressions rooted with the function symbol, where
    the arguments to the function are the expressions generated by
    the "sub-generators".
    The "sub-generators and function symbol can be changed after construction,
    this is useful in the case of recursive generators."""

    def __init__(self, function_descriptor, sub_generators, name = None):
        super().__init__(sub_generators,  name)
        assert function_descriptor is not None
        self.function_descriptor = function_descriptor

    def _instantiate(self, sub_exprs):
        return exprs.FunctionExpression(self.function_descriptor, sub_exprs)

    def clone(self):
        return FunctionalGenerator(self.function_descriptor,
                                   [x.clone() for x in self.sub_generators],
                                   self.name)


class AlternativesGenerator(GeneratorBase):
    """A generator that accepts multiple "sub-generators" and
    generates a sequence that is equivalent to the concatenation of
    the sequences generated by the sub-generators."""
    def __init__(self, sub_generators, name = None):
        # assert (len(sub_generators) > 1)
        super().__init__(name)
        self.sub_generators = [x.clone() for x in sub_generators]

    def set_size(self, new_size):
        self.allowed_size = new_size

        for sub_generator in self.sub_generators:
            sub_generator.set_size(new_size)

    def generate(self):
        for sub_generator in self.sub_generators:
            yield from sub_generator.generate()
            # # audupa: comment out above and uncomment below for python3 < 3.3
            # for obj in sub_generator.generate():
            #     yield obj

    def clone(self):
        return AlternativesGenerator([x.clone() for x in self.sub_generators],
                                     self.name)


class _RecursiveGeneratorPlaceholder(GeneratorBase):
    """A type for placeholders for recursive generators.
    Really just a wrapper around a string."""

    def __init__(self, factory, identifier):
        self.identifier = identifier
        self.factory = factory

    def __eq__(self, other):
        return (self.identifier == other.identifier)

    def __ne__(self, other):
        return (not self.__eq__(other))

    def set_size(self, new_size):
        if (new_size > 0):
            self.actual_generator = self.factory._instantiate_placeholder(self)
            self.actual_generator.set_size(new_size)
        else:
            self.actual_generator = None

    def generate(self):
        if (self.actual_generator == None):
            return
        else:
            yield from self.actual_generator.generate()
            # # audupa: comment out above and uncomment below for python3 < 3.3
            # for obj in self.actual_generator.generate():
            #     yield obj

    def clone(self):
        return _RecursiveGeneratorPlaceholder(self.factory, self.identifier)

class GeneratorFactoryBase(object):
    """A factory for creating recursive generators
    (possibly mutually recursive as well). We associate names with
    generator objects, and also allow these names to be used as placeholders.
    In the end, we actually create the generator object, when :set_size(): is called
    on the returned generator objects."""

    def __init__(self):
        self.generator_map = {}
        self.generator_constructors = {}

    def add_points(self, points):
        raise basetypes.AbstractMethodError('GeneratorFactoryBase.add_points()')

    def make_placeholder(self, identifier):
        if (identifier in self.generator_map):
            raise basetypes.ArgumentError('Identifier already used as placeholder!')
        retval = _RecursiveGeneratorPlaceholder(self, identifier)
        self.generator_map[identifier] = retval
        return retval

    def make_generator(self, generator_name, generator_constructor,
                       arg_tuple_to_constructor):
        self.generator_constructors[generator_name] = (generator_constructor, arg_tuple_to_constructor)
        return self.generator_map[generator_name]

    def has_placeholder(self, identifier):
        return identifier in self.generator_map

    def _instantiate_placeholder(self, placeholder):
        raise basetypes.AbstractMethodError('GeneratorFactoryBase._instantiate_placeholder()')

class NullGeneratorFactory(GeneratorFactoryBase):
    def __init__(self):
        super().__init__()

    def add_points(self, points):
        pass

class RecursiveGeneratorFactory(GeneratorFactoryBase):
    def __init__(self):
        super().__init__() 

    def add_points(self, points):
        pass

    def _instantiate_placeholder(self, placeholder):
        assert (placeholder.factory is self)
        (constructor, arg_tuple) = self.generator_constructors[placeholder.identifier]
        return constructor(*arg_tuple)


class PointDistinctGenerator(GeneratorBase):
    def __init__(self, placeholder, factory):
        super().__init__()
        self.factory = factory
        self.size = None
        self.generated = 0
        self.placeholder = placeholder

    def generate(self):
        self.generated = 0
        while True:
            ret = self.factory.get_from(self.placeholder, self.size, self.generated)
            if ret is None:
                break
            yield ret
            self.generated += 1

    def set_size(self, new_size):
        self.size = new_size
        self.generated = 0

    def clone(self):
        raise basetypes.UnhandledCaseError('PointDistinctGenerator.clone()')


class PointDistinctGeneratorFactory(GeneratorFactoryBase):
    def __init__(self, spec):
        super().__init__()
        self.points = []
        self.signatures = {}
        self.cache = {}
        self.base_generators = {}
        self.finished_generators = {}
        self.eval_ctx = evaluation.EvaluationContext()

        if spec.is_multipoint:
            assert len(spec.synth_funs) == 1
            self.applications = spec.get_applications()[spec.synth_funs[0]]
            for app in self.applications:
                for child in app.children:
                    if exprs.find_application(child, spec.synth_funs[0].function_name) is not None:
                        raise Exception("Unable to form point out of forall variables")
            self.point_profiles = []
        else:
            self.applications = None
            self.point_profiles = None

    def clear_caches(self):
        # self.print_caches()
        self.cache = {}
        self.signatures = {}
        self.base_generators = {}
        self.finished_generators = {}

    def print_caches(self):
        print('++++++++++++')
        for placeholder, size in self.cache:
            print(placeholder, size, '->')
            # pass
            for term in self.cache[(placeholder, size)]:
                print(exprs.expression_to_string(term))
        print('++++++++++++')

    def add_points(self, points):
        self.points.extend(points)
        if self.applications is not None:
            for point in points:
                self.eval_ctx.set_valuation_map(point)
                point_profile = []
                for app in self.applications:
                    profile = tuple([ evaluation.evaluate_expression(c, self.eval_ctx) for c in app.children ])
                    point_profile.append(profile)
                self.point_profiles.append(point_profile)
        self.clear_caches()

    def _initialize_base_generator(self, placeholder, size):
        self.cache[(placeholder, size)] = []
        if placeholder not in self.signatures:
            self.signatures[placeholder] = []
        (constructor, arg_tuple) = self.generator_constructors[placeholder]
        generator = constructor(*arg_tuple)
        generator.set_size(size)
        self.base_generators[(placeholder, size)] = generator.generate()
        self.finished_generators[(placeholder, size)] = False

    def _compute_signature(self, expr):
        if self.applications is None:
            # Single invocation (not multifunction)
            points = self.points
            res = [ None ] * len(points)
            for i in range(len(points)):
                # Assumes introvars are at the beginning of the point
                self.eval_ctx.set_valuation_map(points[i])
                res[i] = evaluation.evaluate_expression_raw(expr, self.eval_ctx)
            return res
        else:
            points = self.points
            res = [ None ] * len(points)
            for i in range(len(points)):
                sig = []
                for profile in self.point_profiles[i]:
                    self.eval_ctx.set_valuation_map(profile)
                    sig.append(evaluation.evaluate_expression_raw(expr, self.eval_ctx))
                res[i] = sig
            return res

    def get_from(self, placeholder, size, position):
        # self.print_caches()
        placeholder = placeholder.identifier

        # Have not started generation
        if (placeholder, size) not in self.cache:
            self._initialize_base_generator(placeholder, size)

        cached_exprs = self.cache[(placeholder, size)]
        assert position <= len(cached_exprs)

        # Have already generated required expression
        if position < len(cached_exprs):
            return cached_exprs[position]

        # Have finished generation
        if self.finished_generators[(placeholder, size)]:
            return None

        # In the middle of generation
        while True:
            next_expr = next(self.base_generators[(placeholder, size)])
            if next_expr is None:
                self.finished_generators[(placeholder, size)] = True
                return None
            try:
                signature = self._compute_signature(next_expr)
                if signature not in self.signatures[placeholder]:
                    cached_exprs.append(next_expr)
                    self.signatures[placeholder].append(signature)
                    # print('Generated', placeholder, size, ':', exprs.expression_to_string(next_expr),
                    #         'with signature', signature)
                    return next_expr 
                else:
                    pass
                    # print('Eliminated', placeholder, size, ':', exprs.expression_to_string(next_expr),
                    #         'with signature', signature)
            except (basetypes.PartialFunctionError, basetypes.UnboundLetVariableError):
                # print('Undefined', placeholder, size, ':', exprs.expression_to_string(next_expr))
                pass

    def _instantiate_placeholder(self, placeholder):
        return PointDistinctGenerator(placeholder, self)

class FilteredGenerator(GeneratorBase):
    """A class for implementing a filtered generator."""
    def __init__(self, filter_object, generator_object, name = None):
        super().__init__(name)
        self.filter_object = filter_object
        self.generator_object = generator_object

    def generate(self):
        for obj in self.generator_object.generate():
            if (self.filter_object.check(obj)):
                yield obj

    def set_size(self, new_size):
        self.generator_object.set_size(new_size)

    def clone(self):
        return FilteredGenerator(self.filter_object, self.generator_object.clone(), self.name)


class BunchedGenerator(GeneratorBase):
    """A wrapper for a generator that generates objects in bunches"""
    def __init__(self, generator_object, max_size, bunch_size = 16, name = None):
        super().__init__(name)
        self.generator_object = generator_object
        self.bunch_size = bunch_size
        self.max_size = max_size
        self.generator_state = None
        self.current_object_size = 0

    def generate(self):
        current_size = 1
        max_size = self.max_size
        sub_generator_object = self.generator_object
        bunch_size = self.bunch_size
        sub_generator_object.set_size(current_size)
        sub_generator_state = sub_generator_object.generate()
        finished = False

        while(True):
            retval = [None] * bunch_size
            current_index = 0
            while (current_index < bunch_size):
                try:
                    retval[current_index] = next(sub_generator_state)
                except StopIteration:
                    # can be bump up the subgenerator size?
                    if (current_size < max_size):
                        current_size += 1
                        # print(current_size, time.time())
                        sub_generator_object.set_size(current_size)
                        sub_generator_state = sub_generator_object.generate()
                        continue
                    elif (not finished):
                        finished = True
                        self.current_object_size = current_size
                        yield retval[:current_index]
                    else:
                        return
                current_index += 1
            self.current_object_size = current_size
            if all(map(lambda f: f is None, retval)):
                return
            else:
                yield retval


    def set_size(self, new_bunch_size):
        """selects a new bunch size"""
        self.bunch_size = new_bunch_size

    def clone(self):
        return BunchedGenerator(self.generator_object.clone(), self.bunch_size, self.name)

class StreamGenerator(GeneratorBase):
    """A wrapper for a generator that seamlessly generates objects of size [1, max_size]"""
    def __init__(self, generator_object, enable_logging = False, max_size = (1 << 20), name = None):
        super().__init__(name)
        self.generator_object = generator_object
        self.max_size = max_size
        self.generator_state = None
        self.enable_logging = enable_logging

    def generate(self):
        current_size = 1
        # total_exps = 0
        # logging_enabled = self.enable_logging
        # if (logging_enabled):
        #     generation_start_time = time.clock()

        max_size = self.max_size
        sub_generator_object = self.generator_object

        while (current_size <= max_size):
            total_of_current_size = 0
            sub_generator_object.set_size(current_size)
            # if (logging_enabled):
            #     current_size_start_time = time.clock()

            sub_generator_state = sub_generator_object.generate()
            while (True):
                try:
                    retval = next(sub_generator_state)
                    total_of_current_size += 1
                    yield retval
                except StopIteration:
                    # if (logging_enabled):
                    #     current_size_end_time = time.clock()
                    #     current_size_time = current_size_end_time - current_size_start_time
                    #     cumulative_size_time = current_size_end_time - generation_start_time
                    #     total_exps += total_of_current_size

                    current_size += 1
                    break
        return

    def set_size(self, new_max_size):
        self.max_size = new_max_size

    def clone(self):
        return StreamGenerator(self.generator_object.clone(), self.bunch_size, self.name)


############################################################
# TEST CASES and utils for other test cases.
############################################################
def _generate_test_generators():
    from core import synthesis_context
    from semantics import semantics_core
    from semantics import semantics_lia

    syn_ctx = synthesis_context.SynthesisContext(semantics_core.CoreInstantiator(),
                                                  semantics_lia.LIAInstantiator())

    var_a_info = syn_ctx.make_variable(exprtypes.IntType(), 'varA', 0)
    var_b_info = syn_ctx.make_variable(exprtypes.IntType(), 'varB', 1)
    var_c_info = syn_ctx.make_variable(exprtypes.IntType(), 'varC', 2)

    var_a = exprs.VariableExpression(var_a_info)
    var_b = exprs.VariableExpression(var_b_info)
    var_c = exprs.VariableExpression(var_c_info)

    zero_value = exprs.Value(0, exprtypes.IntType())
    one_value = exprs.Value(1, exprtypes.IntType())
    zero_exp = exprs.ConstantExpression(zero_value)
    one_exp = exprs.ConstantExpression(one_value)

    var_generator = LeafGenerator([var_a, var_b, var_c], 'Variable Generator')
    const_generator = LeafGenerator([zero_exp, one_exp], 'Constant Generator')
    leaf_generator = AlternativesGenerator([var_generator, const_generator],
                                           'Leaf Term Generator')
    generator_factory = RecursiveGeneratorFactory()
    start_generator_ph = generator_factory.make_placeholder('Start')
    start_bool_generator_ph = generator_factory.make_placeholder('StartBool')


    add_fun = syn_ctx.make_function('add', exprtypes.IntType(), exprtypes.IntType())
    sub_fun = syn_ctx.make_function('sub', exprtypes.IntType(), exprtypes.IntType())
    ite_fun = syn_ctx.make_function('ite', exprtypes.BoolType(),
                                               exprtypes.IntType(), exprtypes.IntType())
    and_fun = syn_ctx.make_function('and', exprtypes.BoolType(), exprtypes.BoolType())
    or_fun = syn_ctx.make_function('or', exprtypes.BoolType(), exprtypes.BoolType())
    not_fun = syn_ctx.make_function('not', exprtypes.BoolType())
    le_fun = syn_ctx.make_function('le', exprtypes.IntType(), exprtypes.IntType())
    ge_fun = syn_ctx.make_function('ge', exprtypes.IntType(), exprtypes.IntType())
    eq_fun = syn_ctx.make_function('eq', exprtypes.IntType(), exprtypes.IntType())

    start_generator = \
    generator_factory.make_generator('Start',
                                     AlternativesGenerator,
                                     ([leaf_generator] +
                                      [FunctionalGenerator(add_fun,
                                                           [start_generator_ph,
                                                            start_generator_ph]),
                                       FunctionalGenerator(sub_fun,
                                                           [start_generator_ph,
                                                            start_generator_ph]),
                                       FunctionalGenerator(ite_fun,
                                                           [start_bool_generator_ph,
                                                            start_generator_ph,
                                                            start_generator_ph])],))

    generator_factory.make_generator('StartBool',
                                     AlternativesGenerator,
                                     ([FunctionalGenerator(and_fun,
                                                           [start_bool_generator_ph,
                                                            start_bool_generator_ph]),
                                       FunctionalGenerator(or_fun,
                                                           [start_bool_generator_ph,
                                                            start_bool_generator_ph]),
                                       FunctionalGenerator(not_fun,
                                                           [start_bool_generator_ph]),
                                       FunctionalGenerator(le_fun,
                                                           [start_generator_ph,
                                                            start_generator_ph]),
                                       FunctionalGenerator(eq_fun,
                                                           [start_generator_ph,
                                                            start_generator_ph]),
                                       FunctionalGenerator(ge_fun,
                                                           [start_generator_ph,
                                                            start_generator_ph])],))
    return start_generator

def test_generators():
    start_generator = _generate_test_generators()
    start_generator.set_size(5)
    for exp in start_generator.generate():
        print(exprs.expression_to_string(exp))

    # tests for bunched generators
    print('Testing bunched generators....')
    bunch_generator = BunchedGenerator(start_generator, 10, 5)
    for bunch in bunch_generator.generate():
        print('Bunch:')
        for exp in bunch:
            print('    %s' % exprs.expression_to_string(exp))

if __name__ == '__main__':
    test_generators()

#
# enumerators.py ends here
