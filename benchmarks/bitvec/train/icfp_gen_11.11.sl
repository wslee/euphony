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
(constraint (= (f #x82E98AA31BBBC5EE) #x826B6329B8A07E2B))
(constraint (= (f #x3774DA268398A7CD) #x3743AEFCA51B3F6A))
(constraint (= (f #x134655A91D80AC22) #x135513FCB49D2C8E))
(constraint (= (f #x63DBD06742C237CB) #x63B80BB72580F5FC))
(constraint (= (f #xEF19641AF767FFFF) #xEFF67D7EED909800))
(constraint (= (f #xA7CFAE984BD79F72) #xB060A2CF6850C11A))
(constraint (= (f #xCEAF64394D7D9FD7) #x62A1378D6504C050))
(constraint (= (f #x2E7D351A4984E36F) #xA30595CB6CF63920))
(constraint (= (f #x846F96FD68E7219C) #xF720D2052E31BCC6))
(constraint (= (f #x156F15DAAACE14C9) #xD521D44AAA63D66C))
(constraint (= (f #x0000000000011600) #x0000000000011600))
(constraint (= (f #x000000000001200C) #x000000000001200C))
(constraint (= (f #x000000000001C9A1) #x000000000001C9A1))
(constraint (= (f #x000000000001CC92) #x000000000001CC92))
(constraint (= (f #x0000000000014C9B) #x0000000000014C9B))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) x (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvmul (bvnot x) #x0000000000000002) (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (bvmul (bvnot x) #x0000000000000002) x))) (ite (= (bvand #x0000000000000003 x) #x0000000000000000) x (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (bvxor (bvlshr x #x0000000000000008) x) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvxor (bvlshr x #x0000000000000008) x) (ite (= (bvor #x0000000000000006 x) x) (bvmul (bvnot x) #x0000000000000002) (ite (= (bvand #x0000000000000006 x) #x0000000000000000) (bvmul (bvnot x) #x0000000000000002) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (bvxor (bvlshr x #x0000000000000008) x) x))))))))
