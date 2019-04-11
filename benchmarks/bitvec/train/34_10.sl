(set-logic BV)
(synth-fun f ( (x (BitVec 64)) ) (BitVec 64)
((Start (BitVec 64)
((bvnot Start)
(bvxor Start Start)
(bvand Start Start)
(bvor Start Start)
(bvneg Start)
(bvadd Start Start)
(bvmul Start Start)
(bvudiv Start Start)
(bvurem Start Start)
(bvlshr Start Start)
(bvashr Start Start)
(bvshl Start Start)
(bvsdiv Start Start)
(bvsrem Start Start)
(bvsub Start Start)
x
#x0000000000000000
#x0000000000000001
#x0000000000000002
#x0000000000000003
#x0000000000000004
#x0000000000000005
#x0000000000000006
#x0000000000000007
#x0000000000000008
#x0000000000000009
#x0000000000000009
#x0000000000000009
#x000000000000000A
#x000000000000000B
#x000000000000000C
#x000000000000000D
#x000000000000000E
#x000000000000000F
#x0000000000000010
(ite StartBool Start Start)
))
(StartBool Bool
((= Start Start)
(not StartBool)
(and StartBool StartBool)
(or StartBool StartBool)
))))
(constraint (= (f #x096053b430bb426d) #xf096053b430bb426))
(constraint (= (f #x2532d1c56d0acae9) #xf2532d1c56d0acae))
(constraint (= (f #x6c707ecc6451d705) #xf6c707ecc6451d70))
(constraint (= (f #x46d1e968eaea1754) #xb92e16971515e8ab))
(constraint (= (f #xc6e990ec5458e96e) #x39166f13aba71691))
(constraint (= (f #xa6d713b00ce037de) #x5928ec4ff31fc821))
(constraint (= (f #x920c8c1eeec7d93c) #x6df373e1113826c3))
(constraint (= (f #x401dd7bb4a1e5470) #xbfe22844b5e1ab8f))
(constraint (= (f #x300782ebccd1272d) #xf300782ebccd1272))
(constraint (= (f #x87e60eccd4aa0b93) #x7819f1332b55f46d))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (bvor (bvnot x) #x0000000000000001) (ite (= (bvor #x0000000000000001 x) x) (bvnot (bvudiv (bvnot x) #x0000000000000010)) (bvnot x))))
