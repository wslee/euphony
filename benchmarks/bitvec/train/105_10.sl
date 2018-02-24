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
(constraint (= (f #x306c7a7c13802c06) #x0000000000000000))
(constraint (= (f #x4bc3915643c40629) #x0000000000000001))
(constraint (= (f #x53ed3096d41c57b4) #x0000000000000000))
(constraint (= (f #x81a38de92e3badec) #x03471bd25c775bd8))
(constraint (= (f #xa929321a893e34eb) #x0000000000000001))
(constraint (= (f #xae0e47401697eb6b) #x5c1c8e802d2fd6d6))
(constraint (= (f #xba6e53bb706d9eb5) #x74dca776e0db3d6a))
(constraint (= (f #x98e661bcb965c620) #x31ccc37972cb8c40))
(constraint (= (f #x2abe37287eb8067e) #x0000000000000000))
(constraint (= (f #xebb7071ea9950202) #xd76e0e3d532a0404))
(check-synth)
