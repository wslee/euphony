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
(constraint (= (f #x101335e013bde390) #x000008099af009df))
(constraint (= (f #xba0b23905bd40ed5) #x00005d0591c82deb))
(constraint (= (f #xc500e9873dc481a9) #x0000628074c39ee3))
(constraint (= (f #x8d8b6999026190e8) #x9b16d33204c321d0))
(constraint (= (f #x29d1a69b7e33c114) #x53a34d36fc678228))
(constraint (= (f #xbd4c8e4e110ed143) #x00005ea647270888))
(constraint (= (f #x06a236b8e03bec86) #x0d446d71c077d90c))
(constraint (= (f #x22ae86d500cee873) #x455d0daa019dd0e6))
(constraint (= (f #xbe92b0e848463c32) #xfd2561d0908c7864))
(constraint (= (f #xe64468e0c7317db0) #x0000732234706399))
(check-synth)
