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
(constraint (= (f #x44BDEA77706EF696) #x44BDEA77706EF696))
(constraint (= (f #x378FE2296B844650) #x378FE2296B844650))
(constraint (= (f #x48A7DB48F96DF2C6) #x48A7DB48F96DF2C6))
(constraint (= (f #x9D4E550A2D0B80A0) #x9D4E550A2D0B80A0))
(constraint (= (f #x619584AFE2CEF05E) #x619584AFE2CEF05E))
(constraint (= (f #x000000000000987D) #x000000000000987D))
(constraint (= (f #x000000000000D48A) #x000000000000D48A))
(constraint (= (f #x0000000000017BF1) #x0000000000017BF1))
(constraint (= (f #x000000000001FE42) #x000000000001FE42))
(constraint (= (f #x0000000000014A4D) #x0000000000014A4D))
(constraint (= (f #x6986047E857AFF17) #x06986047E857AFF1))
(constraint (= (f #x355AB728FF7EFBBB) #x0355AB728FF7EFBB))
(constraint (= (f #x7CBB16A4867B4B1C) #x07CBB16A4867B4B1))
(constraint (= (f #xDD80A894275C97F0) #x0DD80A894275C97F))
(constraint (= (f #x8358AF3AC699C18C) #x08358AF3AC699C18))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000003 x) x) (bvudiv x #x0000000000000010) (ite (= (bvand #x0000000000000003 x) #x0000000000000000) (ite (= (bvor #x0000000000000008 x) x) (bvudiv x #x0000000000000010) (ite (= (bvurem x #x000000000000000b) #x0000000000000000) x (ite (= (bvashr x x) #x0000000000000000) x (bvudiv x #x0000000000000010)))) x)))
