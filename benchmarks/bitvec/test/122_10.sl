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
(constraint (= (f #xebe5824b78c14870) #x000041208020a420))
(constraint (= (f #xcb475e2ecc79224e) #x0000250326140024))
(constraint (= (f #x5e4cd698331aea5e) #x00002b04090c110d))
(constraint (= (f #x3207d55929cbe707) #x640faab25397ce0e))
(constraint (= (f #xe09e922b84d0bb0c) #x0000400540004000))
(constraint (= (f #x7d6edeaa19d3ece3) #xfaddbd5433a7d9c6))
(constraint (= (f #xdebe3b485a26576e) #x00000d040d002913))
(constraint (= (f #x2d5d4e59ed4e33ec) #x0000062ca62410a6))
(constraint (= (f #x1d59ee5b7e3ea36e) #x0000062cb70d1117))
(constraint (= (f #x37e14126a2914aa0) #x0000009000000140))
(check-synth)
