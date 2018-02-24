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
(constraint (= (f #x20856be98e1e206e) #x0df7a941671e1df9))
(constraint (= (f #x376dc13e5ced3bc3) #x376dc13e5ced3bc5))
(constraint (= (f #x840b9c61ea141aa4) #x07bf4639e15ebe55))
(constraint (= (f #x2917d19e25873672) #x0d6e82e61da78c98))
(constraint (= (f #xe1ec806bc484ec45) #xe1ec806bc484ec47))
(constraint (= (f #x7e84ab45de6d6a17) #x7e84ab45de6d6a19))
(constraint (= (f #x12d16e5646e7b8d0) #x0ed2e91a9b918472))
(constraint (= (f #x309166c4cd400648) #x0cf6e993b32bff9b))
(constraint (= (f #xc6bc306c1296379a) #x03943cf93ed69c86))
(constraint (= (f #x45c450e90de32b65) #x45c450e90de32b67))
(check-synth)
