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
(constraint (= (f #xae8222e8155d4a81) #xafc233fc15ffeac1))
(constraint (= (f #xe610de43d0868381) #xe710de63d8868381))
(constraint (= (f #x1a1e5274e339bb63) #x1a1e7276e339fff3))
(constraint (= (f #x1a4351575b97eba4) #x0ec5ddc12385748c))
(constraint (= (f #x1e267c44cc3beaae) #x10f5a5e6b2e1b401))
(constraint (= (f #x403ba2870033d967) #x403bf3870033dde7))
(constraint (= (f #xe57587e9652017b6) #x81121c7348e20d56))
(constraint (= (f #x95c600e75ac36e1d) #x95e600e77ac37f1d))
(constraint (= (f #x86db6296a33eebb7) #x86fff396b33fffff))
(constraint (= (f #x7a761e4b7ad2269c) #x44e2710a751635b7))
(check-synth)
