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
(constraint (= (f #xB26A03BC7B2BAF8B) #xC9A80EF1ECAEBE2D))
(constraint (= (f #x7F37A8B72575A52E) #xFCDEA2DC95D694B9))
(constraint (= (f #x5E137993BB490903) #x784DE64EED24240D))
(constraint (= (f #x59AAAEC41B8E1034) #x66AABB106E3840D1))
(constraint (= (f #x0F1D04A8278BF7D5) #x3C7412A09E2FDF55))
(constraint (= (f #x67CC741A0823B4DC) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xCAEAA4EE4A52E991) #xFFFFFFFFFFFFFFFD))
(constraint (= (f #xBD331A0E9C9038CF) #xFFFFFFFFFFFFFFFD))
(constraint (= (f #x943E05AD8803A68D) #xFFFFFFFFFFFFFFFD))
(constraint (= (f #x6C6E51542E93D459) #xFFFFFFFFFFFFFFFD))
(constraint (= (f #x0000000000000000) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000000001) #xFFFFFFFFFFFFFFFD))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000005 x) x) (bvnot #x0000000000000002) (bvxor (bvmul #x0000000000000004 x) #x0000000000000001)) (ite (= (bvor #x0000000000000005 x) x) (ite (= (bvor #x0000000000000008 x) x) (bvnot #x0000000000000002) (bvxor (bvmul #x0000000000000004 x) #x0000000000000001)) (bvnot #x0000000000000002))) (ite (= #x0000000000000000 x) (bvnot x) (ite (= (bvor #x0000000000000002 x) x) (bvxor (bvmul #x0000000000000004 x) #x0000000000000001) (ite (= (bvor #x0000000000000008 x) x) (bvnot #x0000000000000000) (bvxor (bvmul #x0000000000000004 x) #x0000000000000001))))))
