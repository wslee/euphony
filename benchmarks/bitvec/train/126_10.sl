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
(constraint (= (f #x71c7e1ab41379480) #xfffffffffffffffc))
(constraint (= (f #x7b4319c0667e8b53) #xfffffffffffffffe))
(constraint (= (f #xb4c780718adb8ed7) #x0b4c780718adb8ed))
(constraint (= (f #x204b051e056a95e0) #x0204b051e056a95e))
(constraint (= (f #x758d3e93d508c7aa) #x0758d3e93d508c7a))
(constraint (= (f #xa91e81c7989ab3ed) #xfffffffffffffffe))
(constraint (= (f #x7bb37b8ea0e551bb) #xfffffffffffffffe))
(constraint (= (f #x9e72bc3e96c7ea68) #xfffffffffffffffc))
(constraint (= (f #x35e1057c93242bd7) #xfffffffffffffffe))
(constraint (= (f #x405b3287eb0a36e5) #x0405b3287eb0a36e))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvurem x #x0000000000000006) #x0000000000000000) (bvnot #x0000000000000003) (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (bvudiv x #x0000000000000010) (ite (= (bvand #x000000000000000a x) #x0000000000000000) (bvudiv x #x0000000000000010) (ite (= (bvashr x x) #x0000000000000000) (bvnot #x0000000000000001) (ite (= (bvor #x0000000000000003 x) x) (bvudiv x #x0000000000000010) (bvnot #x0000000000000001)))))))
