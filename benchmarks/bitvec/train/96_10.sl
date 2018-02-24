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
(constraint (= (f #x4b44d589543a565b) #x04b44d589543a565))
(constraint (= (f #x60e4741ede572dae) #x060e4741ede572db))
(constraint (= (f #x377e80057ae8bca6) #x377e80057ae8bca6))
(constraint (= (f #xe5aa51edae79ee50) #x0e5aa51edae79ee5))
(constraint (= (f #x2c947e52d713642d) #x02c947e52d713642))
(constraint (= (f #xe0680844d6470e22) #xe0680844d6470e22))
(constraint (= (f #xe6ddc3ee7242a70c) #xe6ddc3ee7242a70c))
(constraint (= (f #x46bb5e5b69cdb903) #x46bb5e5b69cdb904))
(constraint (= (f #xba16321b911b1ead) #x0ba16321b911b1ea))
(constraint (= (f #x6987b7c65b0725ce) #x6987b7c65b0725ce))
(check-synth)
