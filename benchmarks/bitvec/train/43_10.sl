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
(constraint (= (f #xd1e68781115390b4) #x20fb1006dd973640))
(constraint (= (f #xe78c6924e1e3c089) #xcf18d249c3c78113))
(constraint (= (f #x9e8d6ae31d83eaed) #x3d1ad5c63b07d5db))
(constraint (= (f #x1d106ede55242139) #x3a20ddbcaa484273))
(constraint (= (f #x440c0dd3548626b6) #x88181ba6a90c4d6d))
(constraint (= (f #x2ee717ce0ccbee64) #xce2a76b5126752b5))
(constraint (= (f #x2be2ee8b4e68c9c9) #x57c5dd169cd19393))
(constraint (= (f #xdbadae1c6867de6a) #x16977701d111a3af))
(constraint (= (f #x84eb789a226b07c5) #x09d6f13444d60f8b))
(constraint (= (f #x0973ae7b780b3c5b) #x12e75cf6f01678b7))
(check-synth)
