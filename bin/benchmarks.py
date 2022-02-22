#!/usr/bin/env python3
# benchmarks.py ---
#
# Filename: benchmarks.py
# Author: Arjun Radhakrishna
# Created: Wed, 01 Jun 2016 11:27:20 -0400
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

from parsers import parser
from exprs import expr_transforms
from verifiers import verifiers
from termsolvers import termsolvers
from utils import lia_massager
from utils import utils
from termsolvers import termsolvers_lia
from core import specifications
from unifiers import unifiers
from unifiers import unifiers_lia
from core import solvers
from exprs import exprs
from enumerators import enumerators
from exprs import exprtypes
from semantics import semantics_core
from core import grammars
from phogs import phog
import options
from phogs.phog import Phog
from sphogs.sphog import SPhog
#from phogs import rcfg
import pickle


def get_pbe_valuations(constraints, synth_fun):
    # valuations : ConstantExpression tuple * ConstantExpression (= inputs * output)
    valuations = []
    for constraint in constraints:
        if not exprs.is_application_of(constraint, 'eq') and \
                not exprs.is_application_of(constraint, '='):
            return None
        if len(exprs.get_all_variables(constraint)) > 0:
            return None
        arg_func, arg_other = None, None
        for a in constraint.children:
            if exprs.is_application_of(a, synth_fun):
                arg_func = a
            else:
                arg_other = a
        if arg_func is None or arg_other is None:
            return None
        valuations.append((arg_func.children, arg_other))
    return valuations

def massage_constraints(syn_ctx, macro_instantiator, uf_instantiator, theory, constraints):
    # Instantiate all macro functions
    constraints = [ macro_instantiator.instantiate_all(c)
            for c in constraints ]

    # for c in constraints:
    #     print(exprs.expression_to_string(c))
    # print('Ackermann Reduction')
    constraints = expr_transforms.AckermannReduction.apply(constraints, uf_instantiator, syn_ctx)
    # for c in constraints:
    #     print(exprs.expression_to_string(c))
    # print('let flattener')
    constraints = expr_transforms.LetFlattener.apply(constraints, syn_ctx)
    # for c in constraints:
    #     print(exprs.expression_to_string(c))
    # print('Rewrite ite')
    constraints = expr_transforms.RewriteITE.apply(constraints, syn_ctx)
    # for c in constraints:
    #     print(exprs.expression_to_string(c))
    # constraints, full_constraint_expr = expr_transforms.to_cnf(constraints, theory, syn_ctx)

    # Rewrite ITE?
    return constraints


def rewrite_solution(synth_funs, solution, reverse_mapping):
    # Rewrite any predicates introduced in grammar decomposition
    if reverse_mapping is not None:
        for function_info, cond, orig_expr_template, expr_template in reverse_mapping:
            while True:
                app = exprs.find_application(solution, function_info.function_name)
                if app is None:
                    break
                assert exprs.is_application_of(expr_template, 'ite')

                ite = exprs.parent_of(solution, app)
                ite_without_dummy = exprs.FunctionExpression(ite.function_info, (app.children[0], ite.children[1], ite.children[2]))
                var_mapping = exprs.match(expr_template, ite_without_dummy)
                new_ite = exprs.substitute_all(orig_expr_template, var_mapping.items())
                solution = exprs.substitute(solution, ite, new_ite)

    # Rewrite back into formal parameters
    if len(synth_funs) == 1:
        sols = [solution]
    else:
        # The solution will be a comma operator combination of solution 
        # to each function
        sols = solution.children

    rewritten_solutions = []
    for sol, synth_fun in zip(sols, synth_funs):
        variables = exprs.get_all_formal_parameters(sol)
        substitute_pairs = []
        orig_vars = synth_fun.get_named_vars()
        for v in variables:
            substitute_pairs.append((v, orig_vars[v.parameter_position]))
        sol = exprs.substitute_all(sol, substitute_pairs)
        rewritten_solutions.append(sol)

    return rewritten_solutions


def _merge_grammars(sf_grammar_list):
    start = "MergedStart"
    nts = [start]
    nt_type = {}
    rules = {}
    starts = []
    for sf_name, sf_obj, grammar in sf_grammar_list:
        renamed_grammar = grammar.add_prefix(sf_name)
        nts.extend(renamed_grammar.non_terminals)
        nt_type.update(renamed_grammar.nt_type)
        rules.update(renamed_grammar.rules)
        starts.append(renamed_grammar.start)
    comma_function = semantics_core.CommaFunction([ nt_type[s] for s in starts ])
    rules[start] = [ grammars.FunctionRewrite(comma_function,
            *tuple([ grammars.NTRewrite(s, nt_type[s]) for s in starts ])) ]
    nt_type[start] = None
    merged_grammar = grammars.Grammar(nts, nt_type, rules, start)

    return merged_grammar


def make_specification(synth_funs, theory, syn_ctx, constraints):
    # constraints : exprs.exprs.FunctionExpression list
    # XXX : cnf converter and lia converter are the bottlenecks.
    # temporary treatment for now : does not convert to CNF
    # XXX : cannot solve STR without cnf conversion. I reverted it. 
    if not expr_transforms.is_single_invocation(constraints, theory, syn_ctx):
        specification = specifications.MultiPointSpec(syn_ctx.make_function_expr('and', *constraints),
                syn_ctx, synth_funs)
        syn_ctx.set_synth_funs(synth_funs)
        verifier = verifiers.MultiPointVerifier(syn_ctx, specification)
    elif len(synth_funs) == 1 and get_pbe_valuations(constraints, synth_funs[0]) is not None:
        synth_fun = synth_funs[0]
        valuations = get_pbe_valuations(constraints, synth_fun)
        specification = specifications.PBESpec(valuations, synth_fun, theory)
        syn_ctx.set_synth_funs(synth_funs)
        verifier = verifiers.PBEVerifier(syn_ctx, specification)
    else:
        spec_expr = constraints[0] if len(constraints) == 1 \
                else syn_ctx.make_function_expr('and', *constraints)
        # pdb.set_trace()
        specification = specifications.StandardSpec(spec_expr, syn_ctx, synth_funs, theory)
        syn_ctx.set_synth_funs(synth_funs)
        verifier = verifiers.StdVerifier(syn_ctx, specification)
    return specification, verifier


def full_lia_grammars(grammar_map):
    massaging = {}
    for sf, grammar in grammar_map.items():
        full = False
        if grammar.from_default:
            full = True
        else:
            ans = grammars.identify_lia_grammars(sf, grammar)
            if ans is None:
                full = False
            else:
                massaging[sf] = ans
                full = True
        if not full:
            return False, None
    return True, massaging


class UnsuitableSolverException(Exception):
    def __init__(self, message):
        self.message = message

    def __str__(self):
        return "[ERROR]: UnsuitableSolverException %s" % self.message


def lia_unification_solver(theory, syn_ctx, synth_funs, grammar_map, specification, verifier, phog_file):
    if theory != 'LIA':
        raise UnsuitableSolverException('LIA Unification Solver: Not LIA theory')
    if any([sf.range_type != exprtypes.IntType() for sf in synth_funs ]):
        raise UnsuitableSolverException('LIA Unification Solver: Cannot handle bool return values yet')
    if not specification.is_pointwise():
        raise UnsuitableSolverException('LIA Unification Solver: Not pointwise spec')

    okay, massaging = full_lia_grammars(grammar_map) 
    if not okay:
        raise UnsuitableSolverException('LIA Unification Solver: Could not get LIA full grammar')

    term_solver = termsolvers_lia.SpecAwareLIATermSolver(specification.term_signature, specification)
    unifier = unifiers_lia.SpecAwareLIAUnifier(None, term_solver, synth_funs, syn_ctx, specification)
    solver = solvers.Solver(syn_ctx)
    solutions = solver.solve(
            enumerators.NullGeneratorFactory(),
            term_solver,
            unifier,
            verifier,
            verify_term_solve=False
            )
    solution = next(solutions)
    final_solution = rewrite_solution(synth_funs, solution, reverse_mapping=None)
    final_solution = lia_massager.massage_full_lia_solution(syn_ctx, synth_funs, final_solution, massaging)
    if final_solution is None:
        raise UnsuitableSolverException('LIA Unification Solver: Could not massage back solution')  
    return final_solution


def std_unification_solver(theory, syn_ctx, synth_funs, grammar_map, specification, verifier, phog_file):
    if len(synth_funs) > 1:
        raise UnsuitableSolverException("DT Unification Solver: Multi-function unification not supported")
    if specification.is_multipoint:
        raise UnsuitableSolverException("Multi point specification")

    synth_fun = synth_funs[0]
    grammar = grammar_map[synth_fun]

    decomposed_grammar = grammar.decompose(syn_ctx.macro_instantiator)
    if decomposed_grammar == None:
        raise UnsuitableSolverException("DT Unification Solver: Unable to decompose grammar")
    term_grammar, pred_grammar, reverse_mapping = decomposed_grammar
    generator_factory = enumerators.PointDistinctGeneratorFactory(specification)
    term_generator = term_grammar.to_generator(generator_factory)
    pred_generator = pred_grammar.to_generator(generator_factory)
    solver = solvers.Solver(syn_ctx)
    term_phog = SPhog(term_grammar, phog_file, synth_fun.range_type, specification, for_eusolver=True, for_pred_exprs=False) if options.use_sphog() else \
        Phog(term_grammar, phog_file, synth_fun.range_type, for_eusolver=True, for_pred_exprs=False)
    pred_phog = SPhog(pred_grammar, phog_file, synth_fun.range_type, specification, for_eusolver=True, for_pred_exprs=True, ref_grammar=term_grammar) if options.use_sphog() else \
        Phog(pred_grammar, phog_file, synth_fun.range_type, for_eusolver=True, for_pred_exprs=True)

    if term_phog.stat_map is None:
        print('No model available for this problem. We use the classic EUSolver ...')
        term_phog = None
        pred_phog = None
    if pred_phog is not None and pred_phog.stat_map is None:
        pred_phog = None

    term_solver = termsolvers.PointDistinctTermSolver(specification.term_signature, term_generator, stat_model=term_phog)
    unifier = unifiers.PointDistinctDTUnifier(pred_generator, term_solver, synth_fun, syn_ctx, stat_model=pred_phog)
    solver = solvers.Solver(syn_ctx)
    solutions = solver.solve(
            generator_factory,
            term_solver,
            unifier,
            verifier,
            verify_term_solve=True
            )
    solution = next(solutions)
    final_solution = rewrite_solution([synth_fun], solution, reverse_mapping)
    return final_solution


# transform the original grammar into a RCFG
def augment_grammar(grammar, rcfg_file):

    def get_corresponding_rule(nt, deriv_seq):
        if not nt in grammar.non_terminals:
            return None

        start = grammars.NTRewrite(nt, grammar.nt_type[nt])
        current = start
        nts_addrs = [[]]
        result = None
        for next_sentential in deriv_seq[1:]:
            changed = False
            for (rule, next_rewrite, generated_nts_addrs) in grammar.one_step_expand(current, nts_addrs[0]):
                if str(next_rewrite) == next_sentential:
                    nts_addrs = nts_addrs[1:] if len(generated_nts_addrs) == 0 else generated_nts_addrs + nts_addrs[1:]
                    current = next_rewrite
                    result = next_rewrite
                    changed = True
                    break
            if not changed:
                return None
        return result


    # NT -> sentential form
    new_rules = {}
    n_added_rules = 0
    ratio = 1.0

    for nt in grammar.non_terminals:
        new_rules[nt] = []

    try:
        rcfgFile = open(rcfg_file, 'rb')
        rewrite2seq = pickle.load(rcfgFile)
    except:
        print('RCFG file not found: %s... We use the original grammar.' % rcfg_file)
        return grammar

    for sentential, (cnt, deriv_seq) in rewrite2seq.items():
        assert (len(deriv_seq) > 1)
        nt = deriv_seq[0]
        rule = get_corresponding_rule(nt, deriv_seq)
        if rule is not None:
            new_rules[nt].append((rule, cnt))

    for nt, rules_cnt in new_rules.items():
        # leaving only top X%
        rules_cnt.sort(key=lambda x: x[1], reverse=True)
        for i, (rule, _) in enumerate(rules_cnt):
            if (i / len(rules_cnt) < ratio):
                grammar.rules[nt].append(rule)
                n_added_rules += 1

    print(str(grammar))
    print('%d out of %d rules are applicable.' % (n_added_rules, len(rewrite2seq)))
    rcfgFile.close()
    return grammar



def classic_esolver(theory, syn_ctx, synth_funs, grammar_map, specification, verifier, phog_file):
    if len(synth_funs) != 1:
        raise UnsuitableSolverException("Classic esolver for multi-function disable due to bugs")
    assert len(synth_funs) == 1
    try:
        generator_factory = enumerators.PointDistinctGeneratorFactory(specification)
    except:
        raise UnsuitableSolverException("Enumerator problems")
    TermSolver = termsolvers.PointDistinctTermSolver
    grammar = grammar_map[synth_funs[0]]
    term_generator = grammar.to_generator(generator_factory)

    # init for using PHOG
    phog = SPhog(grammar, phog_file, synth_funs[0].range_type, specification) if options.use_sphog() else \
        Phog(grammar, phog_file, synth_funs[0].range_type)
    print(phog.stat_map) # !!!
    if phog.stat_map is None:
        print('No model available for this problem. We use the classic ESolver ...')
        phog = None

    term_solver = TermSolver(specification.term_signature, term_generator, stat_model=phog)
    term_solver.stopping_condition = termsolvers.StoppingCondition.one_term_sufficiency
    unifier = unifiers.NullUnifier(None, term_solver, synth_funs, syn_ctx, specification)

    solver = solvers.Solver(syn_ctx)
    solutions = solver.solve(
        generator_factory,
        term_solver,
        unifier,
        verifier,
        verify_term_solve=False
    )
    print(solver.points);
    try:
        solution = next(solutions)
    except StopIteration:
        return "NO SOLUTION"
    rewritten_solutions = rewrite_solution(synth_funs, solution, reverse_mapping=None)
    return rewritten_solutions


def memoryless_esolver(theory, syn_ctx, synth_funs, grammar_map, specification, verifier, phog_file, rcfg_file):
    generator_factory = enumerators.RecursiveGeneratorFactory()
    TermSolver = termsolvers.PointlessTermSolver

    if len(synth_funs) > 1:
        sf_list = [ (synth_fun.function_name, synth_fun, grammar_map[synth_fun])
            for synth_fun in synth_funs ]
        grammar = _merge_grammars(sf_list)
    else:
        grammar = grammar_map[synth_funs[0]]

    term_generator = grammar.to_generator(generator_factory)

    term_solver = TermSolver(specification.term_signature, term_generator)
    term_solver.stopping_condition = termsolvers.StoppingCondition.one_term_sufficiency
    unifier = unifiers.NullUnifier(None, term_solver, synth_funs, syn_ctx, specification)

    print(syn_ctx)
    solver = solvers.Solver(syn_ctx)
    solutions = solver.solve(
            generator_factory,
            term_solver,
            unifier,
            verifier,
            verify_term_solve=False
            )
    solution = next(solutions)
    rewritten_solutions = rewrite_solution(synth_funs, solution, reverse_mapping=None)
    return rewritten_solutions


def get_specification(file_sexp):
    benchmark_tuple = parser.extract_benchmark(file_sexp)
    (
        theories,
        syn_ctx,
        synth_instantiator,
        macro_instantiator,
        uf_instantiator,
        constraints,
        grammar_map,
        forall_vars_map,
        default_grammar_sfs
    ) = benchmark_tuple
    assert len(theories) == 1
    theory = theories[0]

    # XXX : to avoid getting stuck in massaging constraints
    # rewritten_constraints = utils.timeout(
    #     massage_constraints,
    #     (syn_ctx, macro_instantiator, uf_instantiator, theory, constraints),
    #     {},
    #     timeout_duration=120,
    #     default=None
    # )
    # constraints = rewritten_constraints
    synth_funs = list(synth_instantiator.get_functions().values())
    specification, _ = make_specification(synth_funs, theory, syn_ctx, constraints)
    return specification


def make_solver(file_sexp, phog_file, rcfg_file):
    benchmark_tuple = parser.extract_benchmark(file_sexp)
    (
            theories,
            syn_ctx,
            synth_instantiator,
            macro_instantiator,
            uf_instantiator,
            constraints,
            grammar_map,
            forall_vars_map,
            default_grammar_sfs
            ) = benchmark_tuple
    assert len(theories) == 1
    theory = theories[0]
    solvers = [ ("LIA Unification", lia_unification_solver),
                ("STD Unification", std_unification_solver),
                ("Classic Esolver", classic_esolver),
                ("Memoryless Esolver", memoryless_esolver) ]

    # for constraint in constraints:
    #     inputs = constraint.children[0].children
    #     output = constraint.children[1]
    #     print('%s\t%s' % (' '.join([exprs.expression_to_string(input) for input in inputs]), exprs.expression_to_string(output)))
    #
    # exit(0)
    rewritten_constraints = utils.timeout(
            massage_constraints,
            (syn_ctx, macro_instantiator, uf_instantiator, theory, constraints),
            {},
            timeout_duration=120,
            default=None
            )
    if rewritten_constraints is not None:
        constraints = rewritten_constraints
    else:
        solvers = [
            # ("LIA Unification", lia_unification_solver),
            ("Memoryless Esolver", memoryless_esolver)
            ]

    # add constant rules + add nt addrs (for PHOG)
    # for sf in grammar_map.keys():
    #     if sf in default_grammar_sfs:
    #         grammar_map[sf].add_constant_rules(phog.collect_constants_from_phog(phog_file, sf.range_type))


    # RCFG
    for sf in grammar_map.keys():
        if not sf in default_grammar_sfs:
            grammar_map[sf] = grammar_map[sf] if rcfg_file == '' else augment_grammar(grammar_map[sf], rcfg_file)
            grammar_map[sf].compute_rule_to_nt_addrs()

    synth_funs = list(synth_instantiator.get_functions().values())
    specification, verifier = make_specification(synth_funs, theory, syn_ctx, constraints)

    solver_args = (
            theory,
            syn_ctx,
            synth_funs,
            grammar_map,
            specification,
            verifier,
            phog_file
            )

    for solver_name, solver in solvers:
        try:
            print("Trying solver:", solver_name)
            final_solutions = solver(*solver_args)
            if final_solutions == "NO SOLUTION":
                print("(fail)")
            else:
                print_solutions(synth_funs, final_solutions)
            break
        except UnsuitableSolverException as exception:
            pass #print(exception)
    else:
        print("Unable to solve!")


def print_solutions(synth_funs, final_solutions):
    for sf, sol in zip(synth_funs, final_solutions):
        fp_infos = []
        for v in sf.get_named_vars():
            v_name = v.variable_info.variable_name 
            v_type = v.variable_info.variable_type.print_string()
            fp_infos.append((v_name, v_type))
        fp_infos_strings = [ '(%s %s)' % (n, t) for (n, t) in fp_infos ]
        fp_string = ' '.join(fp_infos_strings)

        print('(define-fun %s (%s) %s %s)' %
                (sf.function_name,
                    fp_string,
                    sf.range_type.print_string(),
                    exprs.expression_to_string(sol)
                ),
                flush=True)


def test_make_solver(benchmark_files, phog_file, rcfg_file):
    for benchmark_file in benchmark_files:
        file_sexp = parser.sexpFromFile(benchmark_file)
        make_solver(file_sexp, phog_file, rcfg_file)


# input format : sygus instance + solution
def print_stat(benchmark_files, phog_file):
    from os.path import basename
    for benchmark_file in benchmark_files:
        # print('loading: ', benchmark_file)
        file_sexp = parser.sexpFromFile(benchmark_file)
        benchmark_tuple = parser.extract_benchmark(file_sexp)
        (
            theories,
            syn_ctx,
            synth_instantiator,
            macro_instantiator,
            uf_instantiator,
            constraints,
            grammar_map,
            forall_vars_map,
            default_grammar_sfs
        ) = benchmark_tuple
        assert len(theories) == 1
        theory = theories[0]
        specification = get_specification(file_sexp)
        synth_funs = list(synth_instantiator.get_functions().values())
        grammar = grammar_map[synth_funs[0]]

        phog = SPhog(grammar, phog_file, synth_funs[0].range_type, specification) if options.use_sphog() else \
            Phog(grammar, phog_file, synth_funs[0].range_type)

        defs, _ = parser.filter_sexp_for('define-fun', file_sexp)
        if defs is None or len(defs) == 0:
            print('cannot find a solution!')
            exit(0)
        [name, args_data, ret_type_data, interpretation] = defs[-1]

        ((arg_vars, arg_types, arg_var_map), return_type) = parser._process_function_defintion(args_data,
                                                                                               ret_type_data)
        expr = parser.sexp_to_expr(interpretation, syn_ctx, arg_var_map)
        i = 0
        subs_pairs = []
        for (var_expr, ty) in zip(arg_vars, arg_types):
            param_expr = exprs.FormalParameterExpression(None, ty, i)
            subs_pairs.append((var_expr, param_expr))
            i += 1
        expr = exprs.substitute_all(expr, subs_pairs)

        score = phog.get_score(expr)
        print(basename(benchmark_file), ' \t', score)


if __name__ == "__main__":
    import argparse
    import sys
    sys.setrecursionlimit(10000)

    argparser = argparse.ArgumentParser(description='Run ESolver with PHOG')
    argparser.add_argument('-phog', type=str, default='')
    argparser.add_argument('-sphog', type=str, default='')
    argparser.add_argument('-rcfg', type=str, default='')
    argparser.add_argument('-allex', action='store_true')
    argparser.add_argument('-noindis', action='store_true')
    argparser.add_argument('-noheuristic', action='store_true')
    argparser.add_argument('-inc', action='store_true')
    argparser.add_argument('-stat', action='store_true')
    argparser.add_argument('bench', nargs=argparse.REMAINDER)

    if len(sys.argv) < 2:
        argparser.print_usage()
        exit(-1)

    args = argparser.parse_args()

    if args.phog == '' and args.sphog == '':
        options.set_solver('eusolver')
    else:
        options.set_solver('euphony')

    benchmark_files = args.bench
    phog_file = args.phog
    sphog_file = args.sphog
    rcfg_file = args.rcfg
    options.noindis = args.noindis
    options.inc = args.inc
    options.allex = args.allex
    options.stat = args.stat
    options.noheuristic = args.noheuristic

    options.sphog = (len(sphog_file) > 0)
    if options.stat:
        print_stat(benchmark_files, phog_file if sphog_file == '' else sphog_file)
    else:
        test_make_solver(benchmark_files, phog_file if sphog_file == '' else sphog_file, rcfg_file)
    exit(0)
