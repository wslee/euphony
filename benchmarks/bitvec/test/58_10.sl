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
(constraint (= (f #xdc452be7242c1a1e) #x0000b88a57ce4858))
(constraint (= (f #xc4636197a50b3e36) #x0000a652d15c778e))
(constraint (= (f #x1e8da262013499e5) #x00001e8da2620134))
(constraint (= (f #x58e046e06b41306b) #x0000749065905ee1))
(constraint (= (f #xdeec6ae8e5ed97eb) #x0000b19a5f9c971b))
(constraint (= (f #x5d713121e99b6151) #x0000bae26243d336))
(constraint (= (f #x8c5cc5e425bada5c) #x000018b98bc84b75))
(constraint (= (f #xbeaebdece50913e4) #x0000beaebdece509))
(constraint (= (f #x84e219ddd90314d8) #x000084e219ddd903))
(constraint (= (f #x11674b54ee3623d1) #x000022ce96a9dc6c))
(check-synth)
