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
(constraint (= (f #x9bbc9a8037ebabc8) #x9bbc9a8037ebabc9))
(constraint (= (f #x97e64ac15279e90a) #x02fcc9582a4f3d21))
(constraint (= (f #x0b29a7367e4154dc) #x0b29a7367e4154dd))
(constraint (= (f #xe04d4640a6077568) #xe04d4640a6077569))
(constraint (= (f #xc45de3b998c119ea) #x088bbc773318233d))
(constraint (= (f #xb6bebc97944c7bac) #xb6bebc97944c7bad))
(constraint (= (f #xd87adc2caed18135) #xd87adc2caed18134))
(constraint (= (f #x4520104ba3b189e5) #x4520104ba3b189e4))
(constraint (= (f #x698cba6a92662eee) #x0d31974d524cc5dd))
(constraint (= (f #xd1910ae768491370) #xd1910ae768491371))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (bvudiv (bvadd x x) #x0000000000000010) (bvxor #x0000000000000001 x)))
