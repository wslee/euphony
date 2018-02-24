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
(constraint (= (f #x1be88589ba201842) #xe4177a7645dfe7bd))
(constraint (= (f #x49ea2ae53e599623) #x93d455ca7cb32c46))
(constraint (= (f #xea82cc5e6104247d) #xea82cc5e6104247d))
(constraint (= (f #x75820d31bed79b87) #xeb041a637daf370e))
(constraint (= (f #xe682665199ee31a8) #x197d99ae6611ce57))
(constraint (= (f #x9d8d9c6595ee5ded) #x9d8d9c6595ee5ded))
(constraint (= (f #xad1b863e6b5351d4) #x52e479c194acae2b))
(constraint (= (f #xa7465c5c466de212) #x58b9a3a3b9921ded))
(constraint (= (f #xc287ecb0e2e8eb85) #xc287ecb0e2e8eb85))
(constraint (= (f #xac30404490729c8c) #x53cfbfbb6f8d6373))
(check-synth)
