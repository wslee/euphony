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
(constraint (= (f #x0CE1A890FFD1BC81) #x0CEDE9B8FFFFFDBD))
(constraint (= (f #xF443197D724EFFFF) #xF4F75B7D7F7EFFFF))
(constraint (= (f #x5B32B80C4D09D378) #x5B7BBABC4D4DDBFB))
(constraint (= (f #xC76939EB8945E497) #xC7EF79FBEBCDE5F7))
(constraint (= (f #x2AE77F1CF187B935) #x2AEFFF7FFDF7BFBD))
(constraint (= (f #xFFFFFFFFFFFFFFFE) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xBE3D9EAB43751F47) #xBEBFBFBFEB777F5F))
(constraint (= (f #xA4A9110548290DB3) #xA4ADB9154D692DBF))
(constraint (= (f #x0B2ECDFA63411926) #x0B2FEFFFFB63593F))
(constraint (= (f #x0831557BF4493BF8) #x0839757FFFFD7BFB))
(constraint (= (f #xEA2D762448D336E7) #xEAEF7F766CDBF7F7))
(constraint (= (f #xFB5165A85C4AA604) #xF6A2CB50B8954C0B))
(constraint (= (f #x6470011AEAD6F6F8) #xC8E00235D5ADEDF3))
(constraint (= (f #x495207AE5BA6DE44) #x92A40F5CB74DBC8B))
(constraint (= (f #x5A760CA210AEEAA5) #xB4EC1944215DD54D))
(constraint (= (f #xA1959BFD324BFFFF) #x432B37FA64980001))
(constraint (= (f #x88A63A89ABB42CA0) #x114C751357685943))
(constraint (= (f #x208D44805ED654EB) #x411A8900BDACA9D9))
(constraint (= (f #x5CA460A8CA0A43EE) #xB948C151941487DF))
(constraint (= (f #x7D5627A1CCDA1407) #xFAAC4F4399B42811))
(constraint (= (f #xC14B69A0471A361A) #x8296D3408E346C37))
(constraint (= (f #x00000000000001CE) #x000000000000039D))
(constraint (= (f #x0000000000000177) #x00000000000002EF))
(constraint (= (f #x0000000000000164) #x00000000000002C9))
(constraint (= (f #x0000000000000102) #x0000000000000205))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvlshr x #x0000000000000009) #x0000000000000000) (bvsub x (bvnot x)) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvsrem x #x000000000000000b) #x0000000000000000) (bvadd (bvadd #x0000000000000003 x) x) (ite (= (bvsrem x #x0000000000000005) #x0000000000000000) (bvor (bvlshr x #x0000000000000008) x) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvor #x0000000000000007 x) x) (ite (= (bvurem x #x000000000000000b) #x0000000000000000) (bvor (bvlshr x #x0000000000000008) x) (bvadd (bvadd #x0000000000000003 x) x)) (bvor (bvlshr x #x0000000000000008) x)) (bvadd (bvadd #x0000000000000003 x) x)))) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (ite (= (bvand #x000000000000000a x) #x0000000000000000) (bvxor (bvadd x x) #x0000000000000003) (bvor (bvlshr x #x0000000000000008) x)) (bvxor (bvadd x x) #x0000000000000003)))))
