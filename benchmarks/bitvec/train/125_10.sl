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
(constraint (= (f #x1dea8379eebdceb0) #xffffffffffffffff))
(constraint (= (f #x2abc048154191b93) #xfffffffffffffffe))
(constraint (= (f #xa8472bd3838ebdc8) #xaf71a858f8e2846f))
(constraint (= (f #x20ed136260d51b5a) #xbe25d93b3e55c94b))
(constraint (= (f #xe1ba389d81122339) #x3c8b8ec4fddbb98d))
(constraint (= (f #xed72e6e97c80ec49) #x251a322d06fe276d))
(constraint (= (f #x2bab98ddb4a69d3d) #xa8a8ce4496b2c585))
(constraint (= (f #x1ebb8ac38e903975) #xfffffffffffffffe))
(constraint (= (f #x6507809ee4ccee86) #xffffffffffffffff))
(constraint (= (f #x1a1b7cde82e79eb1) #xfffffffffffffffe))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000008 x) x) (bvnot (bvadd x x)) (bvnot (bvand #x0000000000000001 x))))
