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
(constraint (= (f #xaeb7c6a4cce5da7d) #xf3d84bed552e6e87))
(constraint (= (f #xa58be9d4ac5e9755) #xee9c3a7df4e3b9ff))
(constraint (= (f #x8072c4019611c34e) #x778813be608e2081))
(constraint (= (f #xbde1560090759e33) #x4000a89f6688200c))
(constraint (= (f #x1c3de1da08aaa0cc) #x2446226e19ffe154))
(constraint (= (f #x900791e23e66e404) #xb008b22642ab2c0c))
(constraint (= (f #xb320361a529cebb3) #x44cdc88408421044))
(constraint (= (f #xbb3185ce299caac4) #xcd528e527aa5ff4c))
(constraint (= (f #xd5eaccdcc1e076e0) #x7e3f556542209b20))
(constraint (= (f #x6edbe9b1c8bac512) #x91000044234412ac))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (bvnot (bvor (bvudiv x #x0000000000000010) x)) (bvxor (bvadd x x) x)))
