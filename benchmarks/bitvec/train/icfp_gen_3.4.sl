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
(constraint (= (f #x5B239FA4FF220D48) #x2D91CFD27F9106A4))
(constraint (= (f #x32917F0BB37EE9EE) #x1948BF85D9BF74F7))
(constraint (= (f #x1EA5A7602F98D782) #x0F52D3B017CC6BC1))
(constraint (= (f #xFCDB355B4F5E9FE9) #x7E6D9AADA7AF4FF4))
(constraint (= (f #x5E977CBB0F162E0E) #x2F4BBE5D878B1707))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #xAB6A447FBB0812AF) #x55B5223FDD840957))
(constraint (= (f #x3DCB4CF89A55419A) #x1EE5A67C4D2AA0CD))
(constraint (= (f #x4F740114723848E5) #x27BA008A391C2472))
(constraint (= (f #x207027E60E5FFC33) #x103813F3072FFE19))
(constraint (= (f #xA300D04A3D96C1E2) #x518068251ECB60F1))
(constraint (= (f #x15C4274A4CFC7596) #x0AE213A5267E3ACB))
(constraint (= (f #xD6EEEC13ACAC1593) #x6B777609D6560AC9))
(constraint (= (f #x62A08267B20C662B) #x31504133D9063315))
(constraint (= (f #x3E3E9645C524C8BD) #x1F1F4B22E292645E))
(constraint (= (f #xE6763FA2A9AED4EB) #x733B1FD154D76A75))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (bvudiv x #x0000000000000002))
