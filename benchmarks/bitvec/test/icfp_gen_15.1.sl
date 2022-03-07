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
(constraint (= (f #x75A5D2BC237CA0F0) #x075A5D2BC237CA0E))
(constraint (= (f #xBE4902B95DE3B752) #x0BE4902B95DE3B74))
(constraint (= (f #x4223C39E0619329F) #x04223C39E0619328))
(constraint (= (f #xA76E95752CAD6675) #x0A76E95752CAD666))
(constraint (= (f #x342173C1A10E107E) #x0342173C1A10E106))
(constraint (= (f #x2F2AE210FACD0E63) #x2F2AE503A8EE1E0F))
(constraint (= (f #xE597AA3ED49172E3) #xE597B8984F35602C))
(constraint (= (f #x04D377EA5F5F5F2D) #x04D3783796DE0522))
(constraint (= (f #xDE01051012CA6408) #xDE0112F0231B6534))
(constraint (= (f #x1B6CFD84499B174D) #x1B6CFF3B19735BE6))
(constraint (= (f #xFFFFFFFFFFFFFFFE) #x0FFFFFFFFFFFFFFE))
(constraint (= (f #xFFFFFFFF00000002) #x00000FFEFFFFF002))
(constraint (= (f #x0000000000000001) #x0000000000000001))
(constraint (= (f #x3F037F9ADC5AA5E5) #x3F03838B145453AA))
(constraint (= (f #x33A0079FACAFA8E0) #x33A00AD9AD29A3AA))
(constraint (= (f #x15D48F257DD06F65) #x15D49082C6C2C742))
(constraint (= (f #x3059461AA812E354) #x03059461AA812E34))
(constraint (= (f #x301FF33BC78EAA28) #x301FF63DC6C266A0))
(constraint (= (f #xFAC5E48E763E32A7) #xFAC5F43AD4871A0A))
(constraint (= (f #x49AD1A1573081C53) #x049AD1A1573081C4))
(constraint (= (f #x3FC9A1382AC9CA32) #x03FC9A1382AC9CA2))
(constraint (= (f #xA2A5FD1F3ACDEE64) #xA2A607499A9FE210))
(constraint (= (f #x236DCFB034DF4490) #x0236DCFB034DF448))
(constraint (= (f #xFFFFFFFF00000002) #x00000FFEFFFFF002))
(check-synth)
