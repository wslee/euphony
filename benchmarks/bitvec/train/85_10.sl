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
(constraint (= (f #x68c20964a024e417) #x0346104b25012720))
(constraint (= (f #x9e686926dde2b208) #x00009e686926dde2))
(constraint (= (f #x29801e64a0b50d72) #x000029801e64a0b5))
(constraint (= (f #x93709e4694a44c47) #x049b84f234a52262))
(constraint (= (f #xcc21ce876043a944) #x0000cc21ce876043))
(constraint (= (f #xd57e0a1e75e1c30d) #x06abf050f3af0e18))
(constraint (= (f #x94b673e96d703309) #x04a5b39f4b6b8198))
(constraint (= (f #xeae6e9c61cac407a) #x0000eae6e9c61cac))
(constraint (= (f #xeb77d30544028e9e) #x0000eb77d3054402))
(constraint (= (f #xa182aea7c2e2ee27) #x050c15753e171771))
(check-synth)
