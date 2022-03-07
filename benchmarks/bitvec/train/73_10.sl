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
(constraint (= (f #xbd2e7ea9b463ce62) #x05e973f54da31e73))
(constraint (= (f #x3e9d2a58375e0cec) #x01f4e952c1baf067))
(constraint (= (f #x549693d347db136e) #x02a4b49e9a3ed89b))
(constraint (= (f #xa51d9c807d697b37) #x5ae2637f829684c8))
(constraint (= (f #xacbc0945b57eedd9) #x5343f6ba4a811226))
(constraint (= (f #xcde4c5943e78c87b) #x321b3a6bc1873784))
(constraint (= (f #x31ab192ce1eb4ca4) #x018d58c9670f5a65))
(constraint (= (f #xe14e457ec37821da) #x1eb1ba813c87de25))
(constraint (= (f #xb64a18144e5d70d8) #x49b5e7ebb1a28f27))
(constraint (= (f #xd1a7d7c2c6c511ad) #x2e58283d393aee52))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvnot x) (ite (= (bvor #x0000000000000004 x) x) (bvlshr x #x0000000000000005) (ite (= (bvor #x0000000000000008 x) x) (bvnot x) (bvlshr x #x0000000000000005)))))
