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
(constraint (= (f #x6a526433946db183) #x95ad9bcc6b924e7c))
(constraint (= (f #x70537e3e52455423) #x8fac81c1adbaabdc))
(constraint (= (f #x3a13584c406871a1) #xc5eca7b3bf978e5e))
(constraint (= (f #xe9e3d11eb6208ebd) #x161c2ee149df7142))
(constraint (= (f #xbe5cc03822a3a7e1) #x41a33fc7dd5c581e))
(constraint (= (f #x4aeec336b4e610e3) #xb5113cc94b19ef1c))
(constraint (= (f #x6ebd666ee4eec9e7) #x914299911b113618))
(constraint (= (f #x06dd6314116d2195) #xf9229cebee92de6a))
(constraint (= (f #xce6b15de5ab2d1ce) #xce6b15de5ab2d1ce))
(constraint (= (f #x457ad0e42c41ac31) #xba852f1bd3be53ce))
(check-synth)
