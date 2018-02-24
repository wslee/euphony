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
(constraint (= (f #xec54b1528e483750) #x0000000000000000))
(constraint (= (f #x83217ee5c2e5aa1e) #x0000000000000000))
(constraint (= (f #x0e64cb96c38e7e0e) #x0e64cc7d1047ea46))
(constraint (= (f #x1835eae3ddec0457) #x0000000000000000))
(constraint (= (f #x58774c55a08d6c70) #x0000000000000000))
(constraint (= (f #xa576265225941ad6) #x0000000000000000))
(constraint (= (f #x86eb0658d7e059ee) #x86eb0ec78845e76c))
(constraint (= (f #x30171ca5a9610ec9) #x30171ca5a9610ec9))
(constraint (= (f #x2aee8cc9a721554b) #x2aee8cc9a721554b))
(constraint (= (f #x3414db69de676130) #x0000000000000000))
(check-synth)
