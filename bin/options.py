from enum import IntEnum

class SolverID(IntEnum):
    EUSOLVER = 0
    EUPHONY = 1

# Solver
solver = SolverID.EUSOLVER
# with PHOG, compute ranking of final solution
get_rank = False
# indistinguishability
noindis = False
# incremental search (when using PHOG)
inc = False
# give all examples at once (in PBE)
allex = False
# use sphog?
sphog = True
# print stat?
stat = False
# heuristic?
noheuristic = False

def set_solver(arg):
    global solver
    if arg == 'eusolver':
        # print('Solver : EUSolver')
        solver = SolverID.EUSOLVER
    else:
        # print('Solver : EUSolver + PHOG')
        solver = SolverID.EUPHONY

def use_eusolver():
    return (solver == SolverID.EUSOLVER)

def use_phog():
    return (solver == SolverID.EUPHONY)

def use_sphog():
    return sphog
