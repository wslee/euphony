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
(constraint (= (f #xbca14022da2cc437) #x0000bca14022da2d))
(constraint (= (f #x67c305a708dea7e7) #x0000000000000000))
(constraint (= (f #x7ceae1392a837e6a) #x0000000000000001))
(constraint (= (f #x2b0d3b8d4dc15c98) #x0000000000000001))
(constraint (= (f #x0e9d1eb3e8b63eb4) #x0000000000000001))
(constraint (= (f #xe153edb0eb117ea3) #x0000000000000000))
(constraint (= (f #x3e18754acb303ed7) #x00003e18754acb31))
(constraint (= (f #x868a659e313ee3aa) #x0000000000000001))
(constraint (= (f #x0601e9e6b9b6d6ce) #x0000000000000001))
(constraint (= (f #x051e1495672159e4) #x0000000000000001))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000010 x) x) (bvxor (bvlshr x #x0000000000000010) #x0000000000000001) #x0000000000000000) #x0000000000000001))
