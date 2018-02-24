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
(constraint (= (f #x6ba85dde49446e3e) #x0000000000000001))
(constraint (= (f #xd14a9567e1e3e174) #x0000000000000001))
(constraint (= (f #x73eec18bc935e853) #x73eec18bc935e853))
(constraint (= (f #x7e1268367456aa6d) #x7e1268367456aa6f))
(constraint (= (f #xa50b8b60ce5de125) #xa50b8b60ce5de127))
(constraint (= (f #x00d377cc616a4a8b) #x0000000000000000))
(constraint (= (f #xeecbec39e14c9464) #x0000000000000001))
(constraint (= (f #x131376035b872e20) #x0000000000000001))
(constraint (= (f #x9503080bc4444573) #x0000000000000000))
(constraint (= (f #x76222ae89e4c5153) #x0000000000000000))
(check-synth)
