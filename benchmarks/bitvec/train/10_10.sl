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
(constraint (= (f #xae064e188be601e0) #x0000000000000001))
(constraint (= (f #xca7ae372909c2906) #x0000000000000001))
(constraint (= (f #x6833e2a6d59ebd8c) #x00006833e2a6d59f))
(constraint (= (f #xe752d90d263734eb) #x0000e752d90d2638))
(constraint (= (f #x1564469c9e2d4247) #x0000000000000000))
(constraint (= (f #xa923ca523156a7ce) #x0000a923ca523157))
(constraint (= (f #x9ec50b4d3cde96be) #x00009ec50b4d3cdf))
(constraint (= (f #x1876d06e3833abce) #x00001876d06e3834))
(constraint (= (f #x03ee74ec16dab097) #x0000000000000000))
(constraint (= (f #x626335a2956e1c8e) #x0000626335a2956f))
(check-synth)
