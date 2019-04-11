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
(constraint (= (f #x1ee1a02ae82bbd5d) #x1ee1a02ae82bbd5c))
(constraint (= (f #x0acd72d89a2cea29) #x0acd72d89a2cea28))
(constraint (= (f #x2c3b8d463c3e31d8) #x084b2a7d2b4ba958))
(constraint (= (f #x281ee351059ee7d3) #x281ee351059ee7d2))
(constraint (= (f #x79b5452658cabc0e) #x06d1fcf730a60342))
(constraint (= (f #xc75649ee0c398b30) #x05602ddca24aca19))
(constraint (= (f #x732aeee686c80d7c) #x05980ccb39458287))
(constraint (= (f #x5ecaede3c57db56d) #x5ecaede3c57db56c))
(constraint (= (f #x3ce3b23e2dbe4e96) #x0b6ab16ba893aebc))
(constraint (= (f #x745366e292980959) #x745366e292980958))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvnot (bvneg x)) (bvudiv (bvmul #x0000000000000003 x) #x0000000000000010)))
