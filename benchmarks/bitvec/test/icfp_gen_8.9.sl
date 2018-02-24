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
(constraint (= (f #xB011331E5FD06FA0) #xFFFFF4FEECCE1A02))
(constraint (= (f #x65E9013D54965F34) #xFFFFF9A16FEC2AB6))
(constraint (= (f #x9F8A53553E7CCD80) #xFFFFF6075ACAAC18))
(constraint (= (f #x754428FE70B8541C) #xFFFFF8ABBD7018F4))
(constraint (= (f #x796E25A770C08126) #xFFFFF8691DA588F3))
(constraint (= (f #x0000FFFFFFFFFFFE) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x09221743EDBB7E3D) #x0000000000000002))
(constraint (= (f #x9E464F22F9514ADF) #x0000000000000002))
(constraint (= (f #xD23B046761535AEF) #x0000000000000002))
(constraint (= (f #x112DED50C2D9FFF7) #x0000000000000002))
(constraint (= (f #x249ECAD65BE222B5) #x0000000000000002))
(constraint (= (f #x394201278433A521) #xFFFFFC6BDFED87BC))
(constraint (= (f #x14094266C1E16013) #xFFFFFEBF6BD993E1))
(constraint (= (f #x128B69559AC02901) #xFFFFFED7496AA653))
(constraint (= (f #x12212251C9BD1255) #xFFFFFEDDEDDAE364))
(constraint (= (f #xA001A644BC842223) #xFFFFF5FFE59BB437))
(check-synth)
