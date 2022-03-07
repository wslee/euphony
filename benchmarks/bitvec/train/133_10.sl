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
(constraint (= (f #x9932c15ebaeb4269) #x9932c15ebaeb4268))
(constraint (= (f #x8a5e2b8e6262b9bc) #x8a5e2b8e6262b9bc))
(constraint (= (f #x5b3578d17e645464) #x5b3578d17e645464))
(constraint (= (f #x6355a7b4e2a7c28e) #x6355a7b4e2a7c28e))
(constraint (= (f #x02c1a60948c6ae37) #x0000000000000001))
(constraint (= (f #x73c46e35cb448e1d) #x0000000000000001))
(constraint (= (f #xedc3d723c6c90eea) #xedc3d723c6c90eea))
(constraint (= (f #x1c5246ed346ba5d4) #x1c5246ed346ba5d4))
(constraint (= (f #xe4c081bb2a2eea78) #xe4c081bb2a2eea78))
(constraint (= (f #xc2d8e4ed35bde115) #x0000000000000001))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000004 x) x) #x0000000000000001 (bvnot (bvneg x))) x))
