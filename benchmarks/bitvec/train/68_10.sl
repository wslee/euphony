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
(constraint (= (f #xec20ecd05c0851ae) #x0ec20ecd05c0851a))
(constraint (= (f #x1de6b6dc97db1751) #x01de6b6dc97db175))
(constraint (= (f #x4e4936e9c5c1ed81) #x00004e4936e9c5c1))
(constraint (= (f #xaecd2a928edc006e) #x0aecd2a928edc006))
(constraint (= (f #x34e4ecebbcdee8b2) #x000034e4ecebbcde))
(constraint (= (f #x8c3d7149ce70b888) #x00008c3d7149ce70))
(constraint (= (f #x37c76099679ca5ab) #x037c76099679ca5a))
(constraint (= (f #xe503727605e04a00) #x0000e503727605e0))
(constraint (= (f #x00b2ec55de67ea2b) #x000b2ec55de67ea2))
(constraint (= (f #x046e1189d57e8ec2) #x0046e1189d57e8ec))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x000000000000000a x) x) (bvudiv x #x0000000000000010) (ite (= (bvor #x0000000000000008 x) x) (bvlshr x #x0000000000000010) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000010 x) x) (bvudiv x #x0000000000000010) (bvlshr x #x0000000000000010)) (ite (= (bvor #x0000000000000010 x) x) (bvlshr x #x0000000000000010) (ite (= (bvor #x0000000000000002 x) x) (bvudiv x #x0000000000000010) (bvlshr x #x0000000000000010)))))))
