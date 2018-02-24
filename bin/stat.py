from exprs import exprs
from parsers import parser
from semantics import semantics_core
from semantics import semantics_types
from core import synthesis_context
from utils.utils import *
from os.path import basename
# import statistics
# import functools
# import datetime


def get_running_time_info(logFilename):
    try:
        logFile = open(logFilename, 'r')
    except:
        print('File not found: %s' % logFilename)
        return None
    lines = [line.strip() for line in logFile]
    prog2runtime = {}
    for line in lines:
        tokens = line.split(' \t')
        assert (len(tokens) == 2)
        progname = tokens[0].strip()
        runtime = float(tokens[1].strip())
        prog2runtime[progname] = runtime
    return prog2runtime


if __name__ == "__main__":

    if (len(sys.argv) < 2):
        print('usage: %s [input-file-with-a-function]' % sys.argv[0])
        exit(0)

    benchmark_file = sys.argv[1]
    # cvc_log_file = sys.argv[2]
    # log_file = sys.argv[3]
    #
    # prog2runtime = get_running_time_info(log_file)
    # cvc_prog2runtime = get_running_time_info(cvc_log_file)
    # max = 21600.0
    # min = 600.0
    # solved = [pgm for pgm, runtime in prog2runtime.items() if runtime < max and runtime > min and cvc_prog2runtime[pgm] > 600.0]
    # print('# solved: ', len(solved))
    # print('sum: ', datetime.timedelta(seconds=functools.reduce(lambda x,y: x + y, solved, 0.0)))
    # print('mean: ', datetime.timedelta(seconds=statistics.mean(solved)))
    # print('median: ', datetime.timedelta(seconds=statistics.median(solved)))
    # exit(0)

    core_instantiator = semantics_core.CoreInstantiator()
    theory_instantiators = [parser.get_theory_instantiator(theory) for theory in parser._known_theories]

    macro_instantiator = semantics_core.MacroInstantiator()
    uf_instantiator = semantics_core.UninterpretedFunctionInstantiator()
    synth_instantiator = semantics_core.SynthFunctionInstantiator()

    syn_ctx = synthesis_context.SynthesisContext(
        core_instantiator,
        *theory_instantiators,
        macro_instantiator,
        uf_instantiator,
        synth_instantiator)


    file_sexp = parser.sexpFromFile(benchmark_file)
    defs, _ = parser.filter_sexp_for('define-fun', file_sexp)
    if defs is None or len(defs) == 0:
        print('No function can be found!')
        exit(0)

    [name, args_data, ret_type_data, interpretation] = defs[-1]
    ((arg_vars, arg_types, arg_var_map), return_type) = parser._process_function_defintion(args_data, ret_type_data)
    expr = parser.sexp_to_expr(interpretation, syn_ctx, arg_var_map)
    # if basename(benchmark_file) in solved:
    print(exprs.get_expression_size(expr))
    # print(exprs.get_expression_size(expr), '\t', prog2runtime[basename(benchmark_file)])


