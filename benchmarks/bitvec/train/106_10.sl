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
(constraint (= (f #xd294433703509ebe) #x0000000000000001))
(constraint (= (f #x3a3bedc07eed85c2) #x0223acc006ec8040))
(constraint (= (f #x56e47683a3048407) #x0464460022000000))
(constraint (= (f #x0d1c0dc1a60067e9) #x0000000000000000))
(constraint (= (f #xc376beca2c4543cc) #x0000000000000001))
(constraint (= (f #x5e28869a0431dea4) #x0420800800011ca0))
(constraint (= (f #xed6e301cc30c8297) #x0c462000c0008001))
(constraint (= (f #x48e4d74b57acd410) #x008445401528c400))
(constraint (= (f #x2939610db8da9e01) #x0011000098888800))
(constraint (= (f #x14a2ea25d992879c) #x0000000000000001))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000008 x) x) (ite (= (bvor #x0000000000000004 x) x) #x0000000000000001 #x0000000000000000) (bvand (bvudiv x #x0000000000000010) x)))
