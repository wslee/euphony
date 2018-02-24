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
(constraint (= (f #x296e29c563670c08) #x00000296e29c5636))
(constraint (= (f #x9096a7e3127e9b38) #x0000000000000000))
(constraint (= (f #x7670839c2ae8eb77) #x0000000000000001))
(constraint (= (f #x1ab9e2248573e1ee) #x0000000000000000))
(constraint (= (f #x5e1e722cecd24e91) #x000005e1e722cecd))
(constraint (= (f #x0e362e1e4ae97ded) #x0000000000000001))
(constraint (= (f #xa7e4c4437b4e5e0b) #x00000a7e4c4437b4))
(constraint (= (f #x80ea76a7e097ea87) #x0000080ea76a7e09))
(constraint (= (f #xd06e03c3ba82e5ae) #x0000000000000000))
(constraint (= (f #x868e5ac7d6019609) #x00000868e5ac7d60))
(check-synth)
