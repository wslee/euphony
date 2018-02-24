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
(constraint (= (f #x7e68103aa3adc1c8) #x7e68103b2215d202))
(constraint (= (f #xeea4069881de9e20) #xeea406997082a4b8))
(constraint (= (f #xda16d0abad2b5818) #xda16d0ac874228c3))
(constraint (= (f #x4801cbab5ace8577) #x004801cbab5ace85))
(constraint (= (f #x09e8d69ebee4add2) #x09e8d69ec8cd8470))
(constraint (= (f #xd402696eb0896b04) #xd402696f848bd472))
(constraint (= (f #x51b74d3de1eb6c2e) #x51b74d3e33a2b96b))
(constraint (= (f #x66618e5291de00c0) #x66618e52f83f8f12))
(constraint (= (f #x1481302b08ee8a77) #x001481302b08ee8a))
(constraint (= (f #x3cb584e035ea3ab1) #x003cb584e035ea3a))
(check-synth)
