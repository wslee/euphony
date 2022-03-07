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
(constraint (= (f #x805D0DB181387D09) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x6540BCAE174E2072) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x472F064D903267A6) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xEC70CFD02C201337) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xEE09CEA4138CCEB0) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x0000000000010001) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000010000) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x09F0BA8BBF67D1B4) #x000009F0BA8BBF67))
(constraint (= (f #x09E271D10E5D292E) #x000009E271D10E5D))
(constraint (= (f #x35948055E0212D47) #x000035948055E021))
(constraint (= (f #x5CDD2D2FD197D59C) #x00005CDD2D2FD197))
(constraint (= (f #x83407F3439E3EF5B) #x000083407F3439E3))
(constraint (= (f #x000000000001D950) #x0000000000000003))
(constraint (= (f #x000000000001A980) #x0000000000000003))
(constraint (= (f #x0000000000015253) #x0000000000000003))
(constraint (= (f #x00000000000127C3) #x0000000000000003))
(constraint (= (f #x0000000000016A41) #x0000000000000003))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x000000000000000c x) #x0000000000000000) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (ite (= (bvshl #x0000000000000010 #x000000000000000c) x) (bvnot #x0000000000000001) #x0000000000000003) (ite (= (bvor #x0000000000000001 x) x) (bvnot #x0000000000000000) (bvnot #x0000000000000001))) (ite (= (bvsrem x #x000000000000000b) #x0000000000000000) (ite (= (bvor #x0000000000000001 x) x) (bvnot #x0000000000000000) (bvnot #x0000000000000001)) (ite (= (bvand #x0000000000000003 x) #x0000000000000001) (bvnot #x0000000000000000) (bvlshr x #x0000000000000010)))))
