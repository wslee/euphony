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
(constraint (= (f #x9c6c25661dc9d634) #x38d84acc3b93ac68))
(constraint (= (f #x2be6709487973ced) #x15f3384a43cb9e77))
(constraint (= (f #x2c7eee01e59eb9c0) #x58fddc03cb3d7380))
(constraint (= (f #x7412c40ec51cbc58) #xe825881d8a3978b0))
(constraint (= (f #xde8e3e5d701107a1) #x6f471f2eb80883d1))
(constraint (= (f #x1e9e5e0c6112db31) #x0f4f2f0630896d99))
(constraint (= (f #x848ea0e1e3da4723) #x42475070f1ed2392))
(constraint (= (f #xab08ac3613991219) #x5584561b09cc890d))
(constraint (= (f #xe59b3be1787e9489) #x72cd9df0bc3f4a45))
(constraint (= (f #xd0833761eee6ebeb) #x68419bb0f77375f6))
(check-synth)
