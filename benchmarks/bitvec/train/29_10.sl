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
(constraint (= (f #x246e88986924c323) #x48dd1130d2498648))
(constraint (= (f #x48b162101680916a) #x9162c4202d0122d6))
(constraint (= (f #x8e2c34ba355ce1e5) #x1c5869746ab9c3cc))
(constraint (= (f #x81b8d8e7a57e8d92) #x0371b1cf4afd1b26))
(constraint (= (f #x3e12ddba88d0a20d) #x7c25bb7511a1441c))
(constraint (= (f #x6dcb0ed0130d3248) #xdb961da0261a6492))
(constraint (= (f #x88e48dab89a09c10) #x11c91b5713413822))
(constraint (= (f #x0b1999ed2c83e58d) #xffffffffffffffff))
(constraint (= (f #xd94e40238de02d8c) #xb29c80471bc05b1a))
(constraint (= (f #x27abd6c58a26630e) #x4f57ad8b144cc61e))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000005 x) x) (ite (= (bvashr x x) #x0000000000000000) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (bvxor (bvadd x x) #x0000000000000006) (bvnot #x0000000000000000)) (bvxor (bvadd x x) #x0000000000000006)) (ite (= (bvor #x0000000000000001 x) x) (bvxor (bvadd x x) #x000000000000000e) (bvxor (bvadd x x) #x0000000000000002))))
