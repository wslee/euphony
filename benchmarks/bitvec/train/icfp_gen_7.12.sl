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
(constraint (= (f #x7E4A2DA266107FFF) #x7E4A2DA266108000))
(constraint (= (f #x822E6DC2D33D82DF) #x822E6DC2D33D82E0))
(constraint (= (f #x6353CF841F7EE442) #x6353CF841F7EE443))
(constraint (= (f #x06E5CD6959BD8091) #x06E5CD6959BD8092))
(constraint (= (f #x2FAB5F25817AC6D0) #x2FAB5F25817AC6D1))
(constraint (= (f #x00000000007BAAF7) #xFFFFFFFFFF08AA11))
(constraint (= (f #x0000000000619254) #xFFFFFFFFFF3CDB57))
(constraint (= (f #x000000000062EB97) #xFFFFFFFFFF3A28D1))
(constraint (= (f #x00000000004BD692) #xFFFFFFFFFF6852DB))
(constraint (= (f #x0000000000718E65) #xFFFFFFFFFF1CE335))
(constraint (= (f #x7D0574A54C971ACA) #x05F516B566D1CA6B))
(constraint (= (f #xF589091A93184483) #x14EDEDCAD9CF76F9))
(constraint (= (f #x59702B9B91A42A28) #x4D1FA8C8DCB7ABAF))
(constraint (= (f #xA23E5F6883D775EC) #xBB83412EF8511427))
(constraint (= (f #x9035A82B11BF45CB) #xDF94AFA9DC817469))
(constraint (= (f #x00000000005F08B2) #xFFFFFFFFFF41EE9B))
(constraint (= (f #x000000000057383E) #xFFFFFFFFFF518F83))
(constraint (= (f #x000000000072FFFF) #xFFFFFFFFFF1A0001))
(constraint (= (f #x00000000004B6E46) #xFFFFFFFFFF692373))
(constraint (= (f #x00000000007D1ACC) #xFFFFFFFFFF05CA67))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000006 x) #x0000000000000000) (ite (= (bvor #x0000000000000008 x) x) (bvnot (bvadd x x)) (bvneg (bvnot x))) (ite (= (bvor #x000000000000000d x) x) (ite (= (bvurem x #x000000000000000b) #x0000000000000000) (bvnot (bvadd x x)) (bvneg (bvnot x))) (ite (= (bvand #x0000000000000005 x) #x0000000000000000) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (ite (= (bvor #x0000000000000008 x) x) (bvnot (bvadd x x)) (bvxor #x0000000000000001 x)) (bvnot (bvadd x x))) (bvnot (bvadd x x))))))
