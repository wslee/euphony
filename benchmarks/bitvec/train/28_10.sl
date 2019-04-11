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
(constraint (= (f #xd74594057974e439) #x0000d74594057974))
(constraint (= (f #x74641ebeee92e8a2) #x000074641ebeee92))
(constraint (= (f #x91c80141d7ec76b1) #x000091c80141d7ec))
(constraint (= (f #xe4e55862e5ee4bec) #x0000e4e55862e5ee))
(constraint (= (f #x367da67ede4260ce) #x0000367da67ede42))
(constraint (= (f #xa365eb36246b3d8e) #x0000a365eb36246b))
(constraint (= (f #xcd8a44a6d4c09c29) #x0000cd8a44a6d4c0))
(constraint (= (f #xa97e9b9b7970433d) #x0000a97e9b9b7970))
(constraint (= (f #x474dec0dd75d6894) #x0000474dec0dd75d))
(constraint (= (f #x12430014ed058b24) #x000012430014ed05))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (bvlshr x #x0000000000000010))
