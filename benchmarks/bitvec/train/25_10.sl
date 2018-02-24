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
(constraint (= (f #xe5ba16a0cde4e589) #xe5ba16a0cde4e588))
(constraint (= (f #x741d790c2ab5c990) #x741d790c2ab5c991))
(constraint (= (f #x06a1eb613b768d55) #x06a1eb613b768d54))
(constraint (= (f #x7ed38e8ce9029ba6) #x7ed38e8ce9029ba7))
(constraint (= (f #xd2cd44e9a04e1e4d) #xd2cd44e9a04e1e4c))
(constraint (= (f #x5417a08e80eceb0c) #x5417a08e80eceb0d))
(constraint (= (f #x713e1384e9b13c68) #x713e1384e9b13c69))
(constraint (= (f #x592e869385c640a3) #x00000592e869385c))
(constraint (= (f #x956ee45beea75536) #x956ee45beea75537))
(constraint (= (f #x9ece8de3d1350422) #x9ece8de3d1350423))
(check-synth)
