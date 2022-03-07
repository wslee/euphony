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
(constraint (= (f #xec1e737c37696a3d) #x89f0c641e44b4ae1))
(constraint (= (f #xd7cc6b697551c449) #x9419ca4b45571ddb))
(constraint (= (f #xd9b86bade91c4cee) #x9323ca290b71d989))
(constraint (= (f #x1cb71cee8216310d) #xf1a47188bef4e779))
(constraint (= (f #x0686d155e141e629) #xfcbc97550f5f0ceb))
(constraint (= (f #x115c812037db0dba) #xf751bf6fe4127923))
(constraint (= (f #xa5174eeb6dd36a07) #xad74588a49164afd))
(constraint (= (f #x5eeb1cb494e1b33b) #xd08a71a5b58f2663))
(constraint (= (f #x9ce38ea84e8e2ae1) #xb18e38abd8b8ea8f))
(constraint (= (f #xb0e0a62e25ee6adc) #xa78face8ed08ca91))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (bvneg (bvudiv x #x0000000000000002)) (bvnot (bvudiv x #x0000000000000002))))
