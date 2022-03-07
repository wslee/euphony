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
(constraint (= (f #x994e85271c1e3a70) #x0994e85271c1e3a6))
(constraint (= (f #xe2e02781e4ce825c) #x0e2e02781e4ce825))
(constraint (= (f #x178618d7e6e38904) #x2f0c31afcdc71209))
(constraint (= (f #x16a0506a1e682a8e) #x016a0506a1e682a8))
(constraint (= (f #x478b428a199b00e4) #x8f168514333601c9))
(constraint (= (f #xedadaedc0c9ede14) #x0edadaedc0c9ede1))
(constraint (= (f #x58917d6bdca5dc84) #xb122fad7b94bb909))
(constraint (= (f #x1a1a94e73ee890c6) #x01a1a94e73ee890c))
(constraint (= (f #x9cbdbb86ae15e55e) #x397b770d5c2bcabd))
(constraint (= (f #x2c5d499e0553e944) #x58ba933c0aa7d289))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000004 x) x) (ite (= (bvor #x000000000000000a x) x) (ite (= (bvor #x0000000000000010 x) x) (bvsub x (bvnot x)) (bvudiv x #x0000000000000010)) (ite (= (bvor #x0000000000000010 x) x) (bvudiv x #x0000000000000010) (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (bvsub x (bvnot x)) (bvudiv x #x0000000000000010)))) (bvnot (bvneg (bvudiv x #x0000000000000010)))))
