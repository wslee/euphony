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
(constraint (= (f #x0b80bcce081d6022) #x00b80bcce081d603))
(constraint (= (f #xd9eabcbc78ac8230) #x0d9eabcbc78ac823))
(constraint (= (f #x8c852ae6e269a12e) #x08c852ae6e269a13))
(constraint (= (f #x6b32e26d1ca63440) #x06b32e26d1ca6345))
(constraint (= (f #x119a7e445ee7eed3) #x119bffe45feffeff))
(constraint (= (f #x23b0b691ca45585e) #x023b0b691ca45585))
(constraint (= (f #x579729ee56601c26) #x0579729ee56601c3))
(constraint (= (f #x229c90c44d29c079) #x22bdd9cc4dfbdc7f))
(constraint (= (f #x7ced72a06c5b771d) #x7feff7aa6edff77d))
(constraint (= (f #xb5e879e31e817da3) #xbffeffff3fe97ffb))
(check-synth)
