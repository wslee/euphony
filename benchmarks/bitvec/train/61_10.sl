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
(constraint (= (f #xedee2a48b7853845) #xedee2a48b7853845))
(constraint (= (f #x064d2ba44438e16e) #x064d2ba44438e16f))
(constraint (= (f #x8ceed2803c300ae6) #x8ceed2803c300ae7))
(constraint (= (f #xa4410e00e3a0abca) #xa4410e00e3a0abcb))
(constraint (= (f #xa5c2e52b88ad5a44) #x000014b85ca57115))
(constraint (= (f #x36d8137e3eb0a2a1) #x36d8137e3eb0a2a1))
(constraint (= (f #x068d0a456788c03b) #x000000d1a148acf1))
(constraint (= (f #xc9e2c45e256664b3) #x0000193c588bc4ac))
(constraint (= (f #x930e85d58d8ea100) #x00001261d0bab1b1))
(constraint (= (f #x3b96bb9033aa2bed) #x3b96bb9033aa2bed))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000001 x) x) (bvudiv (bvlshr x #x0000000000000010) #x0000000000000008) (bvxor #x0000000000000001 x)) (ite (= (bvor #x0000000000000001 x) x) x (bvudiv (bvlshr x #x0000000000000010) #x0000000000000008))))
