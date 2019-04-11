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
(constraint (= (f #xe037be6b4e8b9a78) #x701bdf35a745cd3c))
(constraint (= (f #x2a8b7c5be7d117b4) #x1545be2df3e88bda))
(constraint (= (f #x6a0b469313010a20) #x3505a34989808510))
(constraint (= (f #x89480e7d5361277c) #x44a4073ea9b093be))
(constraint (= (f #x22da0d08a693cd1b) #x116d06845349e68d))
(constraint (= (f #xd7b0e6a3b081207e) #x6bd87351d840903f))
(constraint (= (f #x201027ad1948b188) #xeff7ec29735ba73b))
(constraint (= (f #x83e0ce570116d363) #xbe0f98d47f74964e))
(constraint (= (f #x33bd43ee87c9b3d1) #x19dea1f743e4d9e8))
(constraint (= (f #x7ae36a145e676d42) #x3d71b50a2f33b6a1))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000010 x) x) (bvudiv x #x0000000000000002) (ite (= (bvor #x0000000000000003 x) x) (bvnot (bvudiv x #x0000000000000002)) (ite (= (bvor #x0000000000000008 x) x) (bvnot (bvudiv x #x0000000000000002)) (bvudiv x #x0000000000000002)))))
