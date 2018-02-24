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
(constraint (= (f #x0e710eaca45caeeb) #xf18ef1535ba35114))
(constraint (= (f #xb322271bee6a4318) #xe6998aac34c136b7))
(constraint (= (f #x76eed95b6b4a1db8) #x9b3373edbe21a6d7))
(constraint (= (f #x3a8023d138c8387e) #x507f948c55a75685))
(constraint (= (f #x7998de93b53a88b6) #x93356444e05065dd))
(constraint (= (f #x288bc73657059770) #x865caa5cfaef39af))
(constraint (= (f #x3c91a460d8c7c338) #x4a4b12dd75a8b657))
(constraint (= (f #xd19e4e31274048ea) #x8b25156c8a3f2541))
(constraint (= (f #x4b76c459eed41be9) #xb4893ba6112be416))
(constraint (= (f #xb82a693d190cadce) #xd780c448b4d9f695))
(check-synth)
