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
(constraint (= (f #xc8960d58101e6361) #x912c1ab0203cc6c2))
(constraint (= (f #x3c49a54b6653dc62) #xfffffffffffffffe))
(constraint (= (f #xc9c8200106ea8c53) #x939040020dd518a6))
(constraint (= (f #xd8da1cbe597682e3) #xb1b4397cb2ed05c6))
(constraint (= (f #x310a69e352cddc99) #x6214d3c6a59bb932))
(constraint (= (f #x5e284a0ebdeb0b4e) #xfffffffffffffffe))
(constraint (= (f #xd46d496623aa034c) #x95c95b4cee2afe58))
(constraint (= (f #x4003196eaa59981e) #xfffffffffffffffe))
(constraint (= (f #xb3a2ab8176a2e1ea) #xa62eaa3f44ae8f0b))
(constraint (= (f #xeca576ba37527a05) #xd94aed746ea4f40a))
(check-synth)
