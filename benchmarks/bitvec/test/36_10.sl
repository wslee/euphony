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
(constraint (= (f #x283b9e991d25a487) #x000057c46166e2da))
(constraint (= (f #xe18d186592997a06) #x00007fffffffffff))
(constraint (= (f #xc1adaea38452eec0) #x00007fffffffffff))
(constraint (= (f #x8509c657e993ade8) #x00007fffffffffff))
(constraint (= (f #x410d5ede613250be) #x00003ef2a1219ecd))
(constraint (= (f #x76ae910d897c9d2c) #x00007fffffffffff))
(constraint (= (f #x4ba6642874560093) #x000034599bd78ba9))
(constraint (= (f #x125e054b0c61aee2) #x00007fffffffffff))
(constraint (= (f #x18d0dd4357bb0517) #x0000672f22bca844))
(constraint (= (f #x9c9503352d1da3c3) #x0000636afccad2e2))
(check-synth)
