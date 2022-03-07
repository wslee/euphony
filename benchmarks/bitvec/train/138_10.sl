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
(constraint (= (f #x8dd35cbd49233180) #x8dd35cbd49233181))
(constraint (= (f #x366bbea1de6b0bee) #x00006cd77d43bcd6))
(constraint (= (f #x4dd2c3b4e846eb22) #x4dd2c3b4e846eb23))
(constraint (= (f #xd843c1e3007309c2) #xd843c1e3007309c3))
(constraint (= (f #xaea0e94c2ece11c5) #x00005d41d2985d9c))
(constraint (= (f #x52e5d4ab78c94e93) #x52e5d4ab78c94e94))
(constraint (= (f #x284b29584e931890) #x284b29584e931891))
(constraint (= (f #xe0a89468735e7bed) #x0000c15128d0e6bc))
(constraint (= (f #xe85e5eeed078618a) #xe85e5eeed078618b))
(constraint (= (f #x8ee1303e8a504039) #x8ee1303e8a50403a))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000004 x) x) (bvlshr (bvadd x x) #x0000000000000010) (bvneg (bvnot x))))
