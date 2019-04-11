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
(constraint (= (f #x4cb86ddc83ce50a2) #x4cb86ddc83ce50a2))
(constraint (= (f #xec64bb73d0e8ba14) #xec64bb73d0e8ba14))
(constraint (= (f #x7cae1d68e5ee2eb8) #x7cae1d68e5ee2eb8))
(constraint (= (f #x1aedd0e026c49408) #x1aedd0e026c49408))
(constraint (= (f #x540b2c9e007b5422) #x540b2c9e007b5422))
(constraint (= (f #x3ea34ed7052e99db) #x3ea34ed7052e99d9))
(constraint (= (f #x9900ed412c53262c) #x9900ed412c53262c))
(constraint (= (f #x8e21e59225eae682) #x8e21e59225eae682))
(constraint (= (f #x81bc9ed221c6a904) #x81bc9ed221c6a904))
(constraint (= (f #x12e6ec5aac0e57e7) #x12e6ec5aac0e57e5))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvxor #x0000000000000002 x) x))
