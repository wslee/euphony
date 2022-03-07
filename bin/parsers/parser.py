# Author: Garvit Juniwal (garvitjuniwal@eecs.berkeley.edu)

from parsers.sexp import sexp as sexpParser
from exprs import exprs
from core import grammars
from semantics import semantics_core
from semantics import semantics_lia
from semantics import semantics_bv
from semantics import semantics_slia
from semantics import semantics_types
from core import synthesis_context
from exprs import exprtypes
from utils.bitvectors import BitVector

def stripComments(bmFile):
    noComments = '('
    for line in bmFile:
        line = line.split(';', 1)[0]
        noComments += line
    return noComments + ')'


def sexpFromFile(benchmarkFileName):
    try:
        benchmarkFile = open(benchmarkFileName)
    except:
        # print('File not found: %s' % benchmarkFileName)
        return None

    bm = stripComments(benchmarkFile)
    bmExpr = sexpParser.parseString(bm, parseAll=True).asList()[0]
    benchmarkFile.close()
    return bmExpr

def parse_bitvec(bv_exp):
    if len(bv_exp) != 2:
        return None
    type_, value = bv_exp[0], bv_exp[1]
    if (
            len(type_) != 2 or
            type_[0] != 'BitVec' or
            len(type_[1]) != 2 or
            type_[1][0] != 'Int'):
        return None
    length = int(type_[1][1])
    if length != 64:
        return None
    return BitVector(value, length)

def filter_sexp_for(head, file_sexp):
    curr = []
    rest = []
    for sexp in file_sexp:
        if sexp[0] == head:
            curr.append(sexp[1:])
        else:
            rest.append(sexp)
    return curr, rest

def sexp_to_value(sexp):
    (type_sexp, value_exp) = sexp
    value_type = sexp_to_type(type_sexp)
    if value_type.type_code == exprtypes.TypeCodes.integer_type:
        value = int(value_exp)
    elif value_type.type_code == exprtypes.TypeCodes.boolean_type:
        assert value_exp == 'true' or value_exp == 'false'
        value = True if value_exp == 'true' else False
    elif value_type.type_code == exprtypes.TypeCodes.bit_vector_type:
        value = BitVector(int(str(value_exp)), value_type.size)
    elif value_type.type_code == exprtypes.TypeCodes.string_type:
        value = value_exp
    else:
        raise Exception('Unknown type: %s' % value_type)
    return exprs.Value(value, value_type)

def sexp_to_type(sexp):
    if type(sexp) == list and sexp[0] == 'BitVec':
        assert type(sexp[1]) == tuple and sexp[1][0] == 'Int'
        length = sexp[1][1]
        return exprtypes.BitVectorType(length)
    elif sexp == 'Int':
        return exprtypes.IntType()
    elif sexp == 'Bool':
        return exprtypes.BoolType()
    elif sexp == 'String':
        return exprtypes.StringType()
    else:
        raise Exception("Unknown type: %s" % str(sexp))

def sexp_to_let(sexp, syn_ctx, child_processing_func, get_return_type, arg_var_map):
    assert sexp[0] == 'let'
    bindings_data = sexp[1]
    in_data = sexp[2]

    binding_vars, binding_names, binding_types, bound_exprs = [], [], [], []
    binding_var_map = {}
    for binding_data in bindings_data:
        # var_name = "_let_bound_" + binding_data[0]
        var_name = binding_data[0]
        var_type = sexp_to_type(binding_data[1])
        binding_names.append(binding_data[0])
        binding_var = syn_ctx.make_variable_expr(var_type, var_name)
        binding_vars.append(binding_var)
        binding_types.append(var_type)
        binding_var_map[binding_data[0]] = binding_var

        expr = child_processing_func(binding_data[2], syn_ctx, arg_var_map)
        bound_exprs.append(expr)

    new_arg_var_map = {}
    new_arg_var_map.update(arg_var_map)
    new_arg_var_map.update(binding_var_map) 

    in_expr = child_processing_func(in_data, syn_ctx, new_arg_var_map)
    in_expr_type = get_return_type(in_expr) # exprs.get_expression_type(in_expr)

    let_function = semantics_core.LetFunction(binding_names, binding_vars, binding_types, in_expr_type)
    children = bound_exprs + [ in_expr ]
    return let_function, children

def sexp_to_expr(sexp, syn_ctx, arg_var_map):
    # Must be a value
    if type(sexp) == tuple:
        value = sexp_to_value(sexp)
        return exprs.ConstantExpression(value)
    elif type(sexp) == str:
        if sexp in arg_var_map:
            return arg_var_map[sexp]
        else: # Could be a zero-argument function
            return syn_ctx.make_function_expr(sexp)
    elif type(sexp) == list:
        if sexp[0] != 'let':
            func = sexp[0]
            children = [ sexp_to_expr(child, syn_ctx, arg_var_map) for child in sexp[1:] ]
        else:
            func, children = sexp_to_let(sexp, syn_ctx, sexp_to_expr, exprs.get_expression_type, arg_var_map)
        return syn_ctx.make_function_expr(func, *children)
    else:
        raise Exception('Unknown sexp type: %s', str(sexp))

def _process_function_defintion(args_data, ret_type_data):
    return_type = sexp_to_type(ret_type_data)

    arg_vars = []
    arg_var_map = {}
    arg_types = []
    for (offset, (arg_name, arg_type_sexp)) in enumerate(args_data):
        arg_type = sexp_to_type(arg_type_sexp)
        arg_types.append(arg_type)
        arg_var = exprs.VariableExpression(
                exprs.VariableInfo(arg_type, arg_name))
        arg_vars.append(arg_var)
        arg_var_map[arg_name] = arg_var
    return ((arg_vars, arg_types, arg_var_map), return_type)

def process_definitions(defs, syn_ctx, macro_instantiator):
    for [name, args_data, ret_type_data, interpretation] in defs:
        ((arg_vars, arg_types, arg_var_map), return_type) = _process_function_defintion(args_data, ret_type_data)

        expr = sexp_to_expr(interpretation, syn_ctx, arg_var_map)
        macro_func = semantics_types.MacroFunction(name, len(arg_vars), tuple(arg_types), return_type, expr, arg_vars)
        macro_instantiator.add_function(name, macro_func)

def process_synth_funcs(synth_funs_data, synth_instantiator, syn_ctx):
    ret = []
    for synth_fun_data in synth_funs_data:
        if len(synth_fun_data) == 4:
            [name, args_data, ret_type_data, grammar_data] = synth_fun_data
        else:
            [name, args_data, ret_type_data] = synth_fun_data
            grammar_data = 'Default grammar'
        ((arg_vars, arg_types, arg_var_map), return_type) = _process_function_defintion(args_data, ret_type_data)

        synth_fun = syn_ctx.make_synth_function(name, tuple(arg_types), return_type)
        synth_fun.set_named_vars(arg_vars)

        synth_instantiator.add_function(name, synth_fun)
        ret.append((synth_fun, arg_vars, grammar_data))
    return ret

def process_synth_invs(synth_invs_data, synth_instantiator, syn_ctx):
    ret = []
    for synth_inv_data in synth_invs_data:
        if len(synth_inv_data) == 3:
            [name, args_data, grammar_data] = synth_inv_data
        else:
            [name, args_data] = synth_inv_data
            grammar_data = 'Default grammar'
        ret_type_data = 'Bool'
        ((arg_vars, arg_types, arg_var_map), return_type) = _process_function_defintion(args_data, ret_type_data)

        synth_inv = syn_ctx.make_synth_function(name, tuple(arg_types), return_type)
        synth_inv.set_named_vars(arg_vars)

        synth_instantiator.add_function(name, synth_inv)
        ret.append((synth_inv, arg_var_map, grammar_data))
    return ret


def _process_rule(non_terminals, nt_type, syn_ctx, arg_vars, var_map, synth_fun, rule_data):
    ph_let_bound_vars, let_bound_vars = [], []
    if type(rule_data) == tuple:
        value = sexp_to_value(rule_data)
        ret = grammars.ExpressionRewrite(exprs.ConstantExpression(value))
    elif rule_data[0] == 'Constant':
        typ = sexp_to_type(rule_data[1])
        ret = grammars.NTRewrite('Constant' + str(typ), typ)
    elif rule_data[0] in [ 'Variable', 'InputVariable', 'LocalVariable' ]:
        raise NotImplementedError('Variable rules in grammars')
    elif type(rule_data) == str:
        if rule_data in [ a.variable_info.variable_name for a in arg_vars ]:
            (parameter_position, variable) = next((i, x) for (i, x) in enumerate(arg_vars)
                    if x.variable_info.variable_name == rule_data)
            expr = exprs.FormalParameterExpression(synth_fun,
                    variable.variable_info.variable_type,
                    parameter_position)
            ret = grammars.ExpressionRewrite(expr)
        elif rule_data in non_terminals:
            ret = grammars.NTRewrite(rule_data, nt_type[rule_data])
        elif rule_data in var_map:
            ret = grammars.ExpressionRewrite(var_map[rule_data])
        else:
            # Could be a 0 arity function
            func = syn_ctx.make_function(rule_data)
            if func != None:
                ret = grammars.ExpressionRewrite(syn_ctx.make_function_expr(rule_data))
            else:
                # Could be a let bound variable
                bound_var_ph = exprs.VariableExpression(exprs.VariableInfo(exprtypes.BoolType(), 'ph_' + rule_data))
                ph_let_bound_vars.append(bound_var_ph)
                ret = grammars.ExpressionRewrite(bound_var_ph)
    elif type(rule_data) == list:
        function_name = rule_data[0]
        if function_name != 'let':
            function_args = []
            for child in rule_data[1:]:
                ph_lbv, lbv, arg = _process_rule(non_terminals, nt_type, syn_ctx, arg_vars, var_map, synth_fun, child)
                ph_let_bound_vars.extend(ph_lbv)
                let_bound_vars.extend(lbv)
                function_args.append(arg)
            function_arg_types = tuple([ x.type for x in function_args ])
            function = syn_ctx.make_function(function_name, *function_arg_types)
        else:
            def child_processing_func(rd, syn_ctx, new_var_map):
                ph_lbv, lbv, a = _process_rule(non_terminals, nt_type, syn_ctx, arg_vars, new_var_map, synth_fun, rd)
                ph_let_bound_vars.extend(ph_lbv)
                let_bound_vars.extend(lbv)
                return a
            def get_return_type(r):
                return r.type
            function, function_args = sexp_to_let(rule_data, syn_ctx, child_processing_func, get_return_type, var_map)
            let_bound_vars.extend(function.binding_vars)
        assert function is not None
        ret =  grammars.FunctionRewrite(function, *function_args)
    else:
        raise Exception('Unknown right hand side: %s' % rule_data)
    return ph_let_bound_vars, let_bound_vars, ret

def _process_forall_vars(forall_vars_data, syn_ctx):
    forall_var_map = {}
    for [variable_name, var_type_data] in forall_vars_data:
        variable_type = sexp_to_type(var_type_data)
        variable = syn_ctx.make_variable_expr(variable_type, variable_name)
        forall_var_map[variable_name] = variable
    return forall_var_map

def _process_forall_primed_vars(forall_primed_data, syn_ctx):
    forall_primed_vars_map = {}
    for [variable_name, var_type_data] in forall_primed_data:
        primed_variable_name = variable_name + '!'
        variable_type = sexp_to_type(var_type_data)
        for name in [ variable_name, primed_variable_name ]:
            variable = syn_ctx.make_variable_expr(variable_type, name)
            forall_primed_vars_map[name] = variable
    return forall_primed_vars_map


def process_constraints(constraints_data, syn_ctx, forall_var_map):
    constraints = []
    for [constraint_data] in constraints_data:
        constraint = sexp_to_expr(constraint_data, syn_ctx, forall_var_map)
        constraints.append(constraint)
    return constraints

def process_inv_constraints(inv_constraints_data, synth_instantiator, syn_ctx, forall_var_map):
    constraints = []
    for [inv_name, pre_name, trans_name, post_name] in inv_constraints_data:
        inv_func = synth_instantiator.functions[inv_name]
        primed_vars, unprimed_vars = [], []
        for name in [ v.variable_info.variable_name for v in inv_func.get_named_vars() ]:
            unprimed_vars.append(syn_ctx.get_variable_expr(name))
            primed_vars.append(syn_ctx.get_variable_expr(name + '!'))

        inv = syn_ctx.make_function_expr(inv_func, *unprimed_vars)
        invp = syn_ctx.make_function_expr(inv_func, *primed_vars)
        pre = syn_ctx.make_function_expr(pre_name, *unprimed_vars)
        post = syn_ctx.make_function_expr(post_name, *unprimed_vars)
        trans = syn_ctx.make_function_expr(trans_name, *(unprimed_vars + primed_vars))

        constraints.append(syn_ctx.make_function_expr('=>', pre, inv))
        constraints.append(syn_ctx.make_function_expr('=>', syn_ctx.make_function_expr('and', inv, trans), invp))
        constraints.append(syn_ctx.make_function_expr('=>', inv, post))
    return constraints


def sexp_to_grammar(arg_vars, grammar_sexp, synth_fun, syn_ctx):
    non_terminals = [ t[0] for t in grammar_sexp ]
    nt_type = { nt:sexp_to_type(nt_type_data) for nt, nt_type_data, rules_data in grammar_sexp }
    rules = {}
    for nt, nt_type_data, rules_data in grammar_sexp:
        ph_let_bound_vars, let_bound_vars = [], []
        rewrites = []
        for rule_data in rules_data:
            ph_lbvs, lbvs, rewrite =\
                    _process_rule(non_terminals, nt_type, syn_ctx, arg_vars, {}, synth_fun, rule_data)
            rewrites.append(rewrite)
            ph_let_bound_vars.extend(ph_lbvs)
            let_bound_vars.extend(lbvs)

        for phlb in ph_let_bound_vars:
            lvs = [ v for v in let_bound_vars if 'ph_' + v.variable_info.variable_name == phlb.variable_info.variable_name ]
            assert len(lvs) > 0
            for rewrite in rewrites:
                rewrite.substitute_expr(phlb, lvs[0])
        rules[nt] = rewrites
    return grammars.Grammar(non_terminals, nt_type, rules)

_known_theories = [ "LIA", "BV", "SLIA" ]

def _process_uninterpreted_funcs(uninterpreted_funcs_data, syn_ctx, uf_instantiator):
    for [ name, arg_types_data, ret_type_data] in uninterpreted_funcs_data:
        arg_types = tuple([ sexp_to_type(arg_type_data) for arg_type_data in arg_types_data ])
        ret_type = sexp_to_type(ret_type_data)
        func = semantics_types.UninterpretedFunction(name, len(arg_types), arg_types, ret_type) 
        uf_instantiator.add_function(name, func)

def make_constant_rules(constraints):
    constants = set()
    for constraint in constraints:
        constants |= exprs.get_all_constants(constraint)

    constants.add(exprs.ConstantExpression(exprs.Value(1, exprtypes.IntType())))
    constants.add(exprs.ConstantExpression(exprs.Value(0, exprtypes.IntType())))

    const_templates = []
    for const in constants:
        const_template = grammars.ExpressionRewrite(const)
        const_templates.append(const_template)
    return const_templates

def extract_benchmark(file_sexp):
    core_instantiator = semantics_core.CoreInstantiator()

    theories, file_sexp = filter_sexp_for('set-logic', file_sexp)
    theories = [ x[0] for x in theories ]
    assert all([theory in _known_theories for theory in theories])
    assert len(theories) == 1
    theory = theories[0]

    if len(theories) == 0:
        theories = _known_theories
    theory_instantiators = [ get_theory_instantiator(theory) for theory in theories ]

    macro_instantiator = semantics_core.MacroInstantiator()
    uf_instantiator = semantics_core.UninterpretedFunctionInstantiator()
    synth_instantiator = semantics_core.SynthFunctionInstantiator()

    syn_ctx = synthesis_context.SynthesisContext(
            core_instantiator,
            *theory_instantiators,
            macro_instantiator,
            uf_instantiator,
            synth_instantiator)
    syn_ctx.set_macro_instantiator(macro_instantiator)

    defs, file_sexp = filter_sexp_for('define-fun', file_sexp)
    process_definitions(defs, syn_ctx, macro_instantiator)

    ufuncs_data, file_sexp = filter_sexp_for('declare-fun', file_sexp)
    _process_uninterpreted_funcs(ufuncs_data, syn_ctx, uf_instantiator)

    # Synthesis functions and synthesis invariants
    synth_funs_data, file_sexp = filter_sexp_for('synth-fun', file_sexp)
    if len(synth_funs_data) == 0:
        synth_funs_data, file_sexp = filter_sexp_for('synth-inv', file_sexp)
        synth_funs_grammar_data = process_synth_invs(synth_funs_data, synth_instantiator, syn_ctx)
    else:
        synth_funs_grammar_data = process_synth_funcs(synth_funs_data, synth_instantiator, syn_ctx)

    # Grammars
    grammar_map = {}
    for synth_fun, arg_vars, grammar_data in synth_funs_grammar_data:
        if grammar_data == 'Default grammar':
            grammar_map[synth_fun] = grammar_data
        else:
            grammar_map[synth_fun] = sexp_to_grammar(arg_vars, grammar_data, synth_fun, syn_ctx)
            # print(grammar_map[synth_fun])
        
    # Universally quantified variables
    forall_vars_data, file_sexp = filter_sexp_for('declare-var', file_sexp)
    forall_vars_map = _process_forall_vars(forall_vars_data, syn_ctx)

    forall_primed_data, file_sexp = filter_sexp_for('declare-primed-var', file_sexp)
    forall_primed_vars_map = _process_forall_primed_vars(forall_primed_data, syn_ctx)
    forall_vars_map.update(forall_primed_vars_map)

    # Constraints
    constraints_data, file_sexp = filter_sexp_for('constraint', file_sexp)
    constraints = process_constraints(constraints_data, syn_ctx, forall_vars_map)
    inv_constraints_data, file_sexp = filter_sexp_for('inv-constraint', file_sexp)
    inv_constraints = process_inv_constraints(inv_constraints_data, synth_instantiator, syn_ctx, forall_vars_map)
    constraints.extend(inv_constraints)

    default_grammar_sfs = []
    for sf in grammar_map.keys():
        if grammar_map[sf] == 'Default grammar':
            default_grammar_sfs.append(sf)
            grammar_map[sf] = grammars.make_default_grammar(syn_ctx, theory, sf.range_type, sf.formal_parameters)
            grammar_map[sf].add_constant_rules(make_constant_rules(constraints))

    check_sats, file_sexp = filter_sexp_for('check-synth', file_sexp)

    options_data, file_sexp = filter_sexp_for('set-options', file_sexp)

    assert check_sats == [[]]
    assert file_sexp == []

    return theories, syn_ctx, synth_instantiator, macro_instantiator, uf_instantiator, constraints, grammar_map, forall_vars_map, default_grammar_sfs

def get_theory_instantiator(theory):
    if theory == "LIA":
        return semantics_lia.LIAInstantiator()
    elif theory == "BV":
        return semantics_bv.BVInstantiator()
    elif theory == "SLIA":
        return semantics_slia.SLIAInstantiator()
    else:
        raise Exception("Unknown theory")

