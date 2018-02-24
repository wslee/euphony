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
(constraint (= (f #x1082C6C5D3DCC425) #x000008416362E9EF))
(constraint (= (f #x6802510593A33FCE) #x000034012882C9D2))
(constraint (= (f #xC0FED460CDE32057) #x0000607F6A3066F2))
(constraint (= (f #xC878E1B80941CE91) #x0000643C70DC04A1))
(constraint (= (f #xB785D54749D5948C) #x00005BC2EAA3A4EB))
(constraint (= (f #xFFFFC0000FFFFC02) #x0000000000000001))
(constraint (= (f #x72AF30494410F42A) #xE55E60928821E854))
(constraint (= (f #x27DA19E5B05321E2) #x4FB433CB60A643C4))
(constraint (= (f #xA15F887C82474460) #xC2BF10F9048E88C0))
(constraint (= (f #xFBA69B7B28C93351) #x774D36F6519266A2))
(constraint (= (f #x68BBB350D0ADBF48) #xD17766A1A15B7E90))
(constraint (= (f #x0000000000013866) #x000000000001D499))
(constraint (= (f #x00000000000136D5) #x000000000001D23F))
(constraint (= (f #x000000000001FF94) #x000000000002FF5E))
(constraint (= (f #x0000000000017E9F) #x0000000000023DEE))
(constraint (= (f #x00000000000178C1) #x0000000000023521))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #x0000000000000001) #x0000000000000002))
(check-synth)
