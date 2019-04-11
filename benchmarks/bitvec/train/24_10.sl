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
(constraint (= (f #xa043199d86d9bdca) #x2810c66761b66f72))
(constraint (= (f #xd0157656939e52c5) #x0000000000000001))
(constraint (= (f #x4b12ae416b7aab37) #x4b12ae416b7aab37))
(constraint (= (f #x6edc862e43e27be5) #x6edc862e43e27be5))
(constraint (= (f #xeee46e8ee3ebb086) #x3bb91ba3b8faec21))
(constraint (= (f #x1352b8171e6e0b23) #x1352b8171e6e0b23))
(constraint (= (f #x753a24cda205c03b) #x0000000000000001))
(constraint (= (f #x773d5d96782e178a) #x0000000000000001))
(constraint (= (f #xa91e181ed0922d7a) #x0000000000000001))
(constraint (= (f #x3d46d2228186d5da) #x0f51b488a061b576))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (ite (= (bvor #x0000000000000004 x) x) x #x0000000000000001) #x0000000000000001) (ite (= (bvor #x0000000000000003 x) x) x (bvudiv x #x0000000000000004))))
