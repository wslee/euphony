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
(constraint (= (f #xaec3dee9734a4306) #xaec3dee9734a4308))
(constraint (= (f #x772ec24e8c65ab70) #x772ec24e8c65ab72))
(constraint (= (f #x806e58130c00a28c) #x806e58130c00a28e))
(constraint (= (f #xa9b0e5416e3419e4) #xa9b0e5416e3419e6))
(constraint (= (f #xdb3c33b4250ee12c) #xdb3c33b4250ee12e))
(constraint (= (f #x564740439407d2d2) #x564740439407d2d4))
(constraint (= (f #x809763ce43994942) #x809763ce43994944))
(constraint (= (f #x68477ac79b8b4517) #x068477ac79b8b451))
(constraint (= (f #x88e8cb268279ba71) #x088e8cb268279ba7))
(constraint (= (f #x205c19416deb69b0) #x205c19416deb69b2))
(check-synth)
