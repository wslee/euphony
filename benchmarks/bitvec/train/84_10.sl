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
(constraint (= (f #xe093a45011447027) #xfffff1f6c5bafeeb))
(constraint (= (f #x222ee77dbb47d602) #xfffffddd1188244b))
(constraint (= (f #xe9d6351259ee1ed4) #xe9d6351259ee1ed5))
(constraint (= (f #xb4294084760655ad) #xfffff4bd6bf7b89f))
(constraint (= (f #x63580b071e7661a3) #x63580b071e7661a4))
(constraint (= (f #xb6de6711d9cd7e20) #xfffff492198ee263))
(constraint (= (f #x57a3bb75d75edd42) #x57a3bb75d75edd43))
(constraint (= (f #xae869555954769d4) #xae869555954769d5))
(constraint (= (f #x164db6b971e3d9a9) #xfffffe9b249468e1))
(constraint (= (f #xd97714baed4295e9) #xfffff2688eb4512b))
(check-synth)
