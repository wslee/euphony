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
(constraint (= (f #xa58199527021aecd) #x0000000000000002))
(constraint (= (f #x0a8e1b47152b045b) #x0000000000000002))
(constraint (= (f #xa2ae6e15ae402a80) #x0000000000000000))
(constraint (= (f #xcd3e2c76d2967379) #x0000000000000000))
(constraint (= (f #xe432767845375e02) #x0000000000000002))
(constraint (= (f #x7ce2ec4d032e4006) #x0000000000000000))
(constraint (= (f #x7b04438bb147022c) #x0000000000000002))
(constraint (= (f #x67e90e24e2aadeac) #x0000000000000000))
(constraint (= (f #x14e560c5b8b59c65) #x0000000000000002))
(constraint (= (f #xd0dd6177289ba994) #x0000000000000002))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000006 x) #x0000000000000000) #x0000000000000000 (ite (= (bvor #x0000000000000006 x) x) #x0000000000000000 (ite (= (bvurem x #x0000000000000007) #x0000000000000000) #x0000000000000000 #x0000000000000002))))
