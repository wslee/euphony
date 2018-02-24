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
(constraint (= (f #x2e06e138a01be4ec) #x0000000000000002))
(constraint (= (f #xc5479a03b8ad40d5) #xc5479a03b8ad40d4))
(constraint (= (f #xb84d9d77284eb244) #xb84d9d77284eb244))
(constraint (= (f #x7e14893876abdc0a) #x7e14893876abdc0a))
(constraint (= (f #x75e909118e5b5ae4) #x0000000000000002))
(constraint (= (f #x2d85aa78aace1add) #x2d85aa78aace1adc))
(constraint (= (f #xee4b91c8a03ae200) #x0000000000000002))
(constraint (= (f #x8549d93e95b13e60) #x0000000000000002))
(constraint (= (f #xd96912ebe9be9ceb) #x0000000000000002))
(constraint (= (f #xe2413169cecd32de) #xe2413169cecd32de))
(check-synth)
