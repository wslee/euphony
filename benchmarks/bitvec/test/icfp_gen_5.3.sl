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
(constraint (= (f #x49E3D34A96CFD18C) #x299026D9F4D4E5DE))
(constraint (= (f #x1F0EEC5192D2CAB2) #x117864EDE2969204))
(constraint (= (f #x9E67287B2427BF1C) #x591A06C544565B7F))
(constraint (= (f #x8ABA6C6816FF4676) #x4E08DCFA8CEF97A2))
(constraint (= (f #x093CA3785B22036C) #x05321BF3B34321EC))
(constraint (= (f #x0000000000000002) #x0000000000000001))
(constraint (= (f #x00000000003591EE) #x00000000001E2215))
(constraint (= (f #x000000000030ED6C) #x00000000001B858C))
(constraint (= (f #x0000000000313E28) #x00000000001BB2F6))
(constraint (= (f #x00000000003267B0) #x00000000001C5A53))
(constraint (= (f #x000000000026401E) #x0000000000158410))
(constraint (= (f #x507F1B58AF43B86D) #x507F9BD8EF63BC6F))
(constraint (= (f #xF8DD09873A277621) #xFCDF89C73B377F31))
(constraint (= (f #xFB9FDB66C653F7E9) #xFFDFFFF7E673FFFD))
(constraint (= (f #x788B39733CBC3727) #x78CF39FBBCFC37B7))
(constraint (= (f #xA7520DAF3A5F4A37) #xA77A0DEF3B5FEA37))
(constraint (= (f #xAAAAAAAAAAAAAAAA) #x0AAAAAAAAAAAAAAA))
(constraint (= (f #x0000000000000003) #x0000000000000001))
(constraint (= (f #x000000000038951D) #x000000000038951D))
(constraint (= (f #x0000000000276D89) #x0000000000276D89))
(constraint (= (f #x000000000025AD87) #x000000000025AD87))
(constraint (= (f #x0000000000209259) #x0000000000209259))
(constraint (= (f #x000000000031BF67) #x000000000031BF67))
(check-synth)
