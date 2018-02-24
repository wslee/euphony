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
(constraint (= (f #xF5222623A9DE2363) #x0000000000000001))
(constraint (= (f #x463D30F6394FDA77) #x0000000000000001))
(constraint (= (f #x308BDFBAE07CEE6F) #x0000000000000001))
(constraint (= (f #x3C0E1CB46E2A08D3) #x0000000000000001))
(constraint (= (f #x85F095FA51395463) #x0000000000000001))
(constraint (= (f #xBED59799BBDB3906) #xBED59C74E2A2A2BB))
(constraint (= (f #xAB404AD0759A292C) #xAB40406471372E75))
(constraint (= (f #x9BE29A95418ADC10) #x9BE2932B68238808))
(constraint (= (f #x19F67D2E37A1474C) #x19F67CB15073A436))
(constraint (= (f #xCADF780F4E99959C) #xCADF74A2B9196175))
(constraint (= (f #x1A01C16018248491) #x0000000000000001))
(constraint (= (f #x281092507861601F) #x0000000000000001))
(constraint (= (f #x785A5A0A52040071) #x0000000000000001))
(constraint (= (f #x5807052900280E15) #x0000000000000001))
(constraint (= (f #xC161A40D04903839) #x0000000000000001))
(constraint (= (f #xC3B88CD1DB0563C6) #xC3B880EA53C87E76))
(constraint (= (f #x4D14B3691EFD9267) #x0000000000000001))
(constraint (= (f #xB6214A30AD5E61A6) #xB6214152B9FD6B73))
(constraint (= (f #x46D07232E3DCC108) #x46D0765FE4FFEF35))
(constraint (= (f #x17D102B41EFBB226) #x17D103C90ED0F3C9))
(constraint (= (f #x4677796B145B38EE) #x46777D0C63CD89AB))
(constraint (= (f #x564A96CAD47D49DB) #x0000000000000001))
(constraint (= (f #xE2924B95C643EC48) #xE29245BCE2FAB02C))
(constraint (= (f #x4DB09D03AE4DC0F5) #x0000000000000001))
(constraint (= (f #x5B6414DB775EA43A) #x5B64116D3613134F))
(constraint (= (f #xE042C1C29241A495) #x0000000000000001))
(check-synth)
