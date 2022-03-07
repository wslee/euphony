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
(constraint (= (f #x7ccc6e8b28aeee9d) #x7ccd6e8b28aeee9c))
(constraint (= (f #x19e8e4125382c6c0) #x19e9e4125382c6bf))
(constraint (= (f #xe137a30c1d3c2eb6) #xfffffffffffffffc))
(constraint (= (f #x54eac1dc9853aed7) #xfffffffffffffffe))
(constraint (= (f #xaeb15d8e05e32553) #xfffffffffffffffe))
(constraint (= (f #x8935e3b7034e6697) #xfffffffffffffffe))
(constraint (= (f #xe0ddea4eb0b4b1e9) #xe0deea4eb0b4b1e8))
(constraint (= (f #xb0ec41ceae410296) #xfffffffffffffffc))
(constraint (= (f #x25a9eb4d0a8717d8) #x25aaeb4d0a8717d7))
(constraint (= (f #x4c80d548e86d4eb5) #x4c81d548e86d4eb4))
(check-synth)
