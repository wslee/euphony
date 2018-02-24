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
(constraint (= (f #x782311ce9a01e21a) #x0fb9dc62cbfc3bca))
(constraint (= (f #xee68c1a59be2955e) #x232e7cb4c83ad542))
(constraint (= (f #x723ba7e585e8282a) #x0000222185e00028))
(constraint (= (f #x758010363b8956ed) #x0000100010001289))
(constraint (= (f #x52ab23ada6e98b72) #x5aa9b8a4b22ce91a))
(constraint (= (f #xde942ad776a2655b) #x42d7aa5112bb3548))
(constraint (= (f #x2635dbbb666b92b5) #xb39448893328da94))
(constraint (= (f #xa6e146c451842a6c) #x000006c040840004))
(constraint (= (f #xb21a19ead2000d63) #x0000100a10000000))
(constraint (= (f #xed82e4ddaa889d6a) #x0000e480a0888808))
(check-synth)
