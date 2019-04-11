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
(constraint (= (f #x2FAF020F03F8508A) #x2FAF020F03F8508B))
(constraint (= (f #x8B44F7D3057C0A74) #x8B44F7D3057C0A75))
(constraint (= (f #x27537400BD2E6802) #x27537400BD2E6803))
(constraint (= (f #x34797BDAF4E80C9D) #x34797BDAF4E80C9E))
(constraint (= (f #x380941636AEE349E) #x380941636AEE349F))
(constraint (= (f #x0000000000000001) #x0000000000000002))
(constraint (= (f #xC03FFE951B591F90) #x0000C03FFE951B58))
(constraint (= (f #xB2984DC669D18732) #x0000B2984DC669D0))
(constraint (= (f #xCF641C5C65491B4C) #x0000CF641C5C6548))
(constraint (= (f #x17019F25A76A6D11) #x000017019F25A76B))
(constraint (= (f #xBE34FECDE8DD2DFA) #x0000BE34FECDE8DC))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #x0000000000000000))
(constraint (= (f #x1DB5FC6FDEAEC09A) #x1DB5FC6FDEAEC09B))
(constraint (= (f #x595E15DBFF030887) #x595E15DBFF030888))
(constraint (= (f #xCEC289435229DA06) #xCEC289435229DA07))
(constraint (= (f #xD81CE5C477EB73FC) #x0000D81CE5C477EA))
(constraint (= (f #xB440097EA631DD53) #x0000B440097EA630))
(constraint (= (f #xD53A3560E2B596D3) #xD53A3560E2B596D4))
(constraint (= (f #x87B217E6ED340E51) #x87B217E6ED340E52))
(constraint (= (f #x7193648C3DB38931) #x00007193648C3DB2))
(constraint (= (f #x3A8798DE185CCBAB) #x00003A8798DE185D))
(constraint (= (f #xDA96AE668BE5394A) #x0000DA96AE668BE4))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #x0000000000000000))
(constraint (= (f #x7FFFFFFFFFFFFFFF) #x00007FFFFFFFFFFE))
(constraint (= (f #xFFFFFFFFFFFFFFFE) #x0000FFFFFFFFFFFE))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (bvneg (bvnot x)) (ite (= (bvsdiv #x0000000000000001 x) x) (bvneg (bvnot x)) (ite (= (bvor #x000000000000000e x) x) (bvxor (bvlshr x #x0000000000000010) #x0000000000000001) (ite (= (bvor #x0000000000000005 x) x) (bvneg (bvnot x)) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (ite (= (bvor #x000000000000000c x) x) (bvxor (bvlshr x #x0000000000000010) #x0000000000000001) (bvneg (bvnot x))) (ite (= (bvor #x0000000000000010 x) x) (bvxor (bvlshr x #x0000000000000010) #x0000000000000001) (ite (= (bvurem x #x0000000000000006) #x0000000000000000) (ite (= (bvurem x #x000000000000000b) #x0000000000000000) (bvxor (bvlshr x #x0000000000000010) #x0000000000000001) (bvneg (bvnot x))) (bvxor (bvlshr x #x0000000000000010) #x0000000000000001)))))))))
