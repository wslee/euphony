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
(constraint (= (f #x1537C38D6EF25507) #x75641E394886D57C))
(constraint (= (f #x0466789125F0621B) #x7DCCC3B76D07CEF2))
(constraint (= (f #xAAF1CDF74EC20AA0) #x2A871904589EFAAF))
(constraint (= (f #x75570A6218028E7B) #x45547ACEF3FEB8C2))
(constraint (= (f #xF34581B94DE086BE) #x065D3F23590FBCA0))
(constraint (= (f #x8000000000000001) #x7FFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000000001) #x7FFFFFFFFFFFFFFF))
(constraint (= (f #x5A69DEBA971540D5) #x2CB10A2B4755F957))
(constraint (= (f #xA976C725C016D121) #xB449C6D1FF4976F7))
(constraint (= (f #xE79CEF7668CD6FB8) #xC318844CB994823F))
(constraint (= (f #xD3BD517567D7EBE8) #x62157454C140A0BF))
(constraint (= (f #xA4EDDEFD84D44B9F) #xD8910813D95DA307))
(constraint (= (f #xFFFFFFFFFFFE9CB7) #x0000000000058D23))
(constraint (= (f #xFFFFFFFFFFFE10C0) #x000000000007BCFF))
(constraint (= (f #xFFFFFFFFFFFED7C5) #x000000000004A0EB))
(constraint (= (f #xFFFFFFFFFFFEAFF9) #x000000000005401B))
(constraint (= (f #xFFFFFFFFFFFE9554) #x000000000005AAAF))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvsub #x0000000000000002 x) x) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvneg x) (bvudiv (bvnot x) #x0000000000000002)) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvnot (bvashr x #x0000000000000001)) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x000000000000000d x) x) (bvnot (bvmul #x0000000000000008 x)) (ite (= (bvor #x0000000000000008 x) x) (bvudiv (bvnot x) #x0000000000000002) (ite (= (bvor #x0000000000000010 x) x) (bvnot (bvmul #x0000000000000004 x)) (bvudiv (bvnot x) #x0000000000000002)))) (ite (= (bvand #x0000000000000009 x) #x0000000000000000) (bvnot (bvmul #x0000000000000004 x)) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (ite (= (bvand #x0000000000000003 x) #x0000000000000000) (bvnot (bvmul #x0000000000000008 x)) (bvnot (bvmul #x0000000000000004 x))) (bvnot (bvmul #x0000000000000008 x))))))))
