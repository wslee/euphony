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
(constraint (= (f #x56b71824648d03dc) #xffffffff56b71824))
(constraint (= (f #x2eae5e05e7abe9e8) #xffffffff2eae5e05))
(constraint (= (f #xcd3ec1341d9b9d94) #xffffffffcd3ec134))
(constraint (= (f #xa22c2e44413a449a) #x0bba7a3777d8b76c))
(constraint (= (f #x61cbc78155de393b) #x13c6870fd54438d8))
(constraint (= (f #xeab8219b6ee7b76d) #xffffffffeab8219b))
(constraint (= (f #x93899d46b23e71ce) #x0d8ecc5729b831c6))
(constraint (= (f #x3766ddab39201e64) #xffffffff3766ddab))
(constraint (= (f #xe8a93b7c358a54dc) #xffffffffe8a93b7c))
(constraint (= (f #xbe83736d5754cb8e) #x082f91925515668e))
(check-synth)
