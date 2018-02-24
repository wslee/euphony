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
(constraint (= (f #x67e8e46bb31d6e42) #x0000000000000001))
(constraint (= (f #xa3dc6c9be02db165) #x0000000000000001))
(constraint (= (f #x0b640eeedc8306eb) #x0000000000000001))
(constraint (= (f #x6c74cac0054bc64d) #x6c74cac0054bc64d))
(constraint (= (f #x46ee8602ccabea5e) #x0000000000000001))
(constraint (= (f #xc4300d3937d2e24d) #x88601a726fa5c49a))
(constraint (= (f #xe1e315a3ee2164b7) #x0000000000000001))
(constraint (= (f #xcac874b956d47ea4) #x9590e972ada8fd48))
(constraint (= (f #xcc44d4d8b20e4a16) #x9889a9b1641c942c))
(constraint (= (f #xe224ce8d6ecc4b15) #xc4499d1add98962a))
(check-synth)
