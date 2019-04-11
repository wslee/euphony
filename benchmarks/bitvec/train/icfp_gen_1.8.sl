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
(constraint (= (f #xAFDC99E51562FE40) #x2BF726794558BF90))
(constraint (= (f #x502B54DA51F272EA) #x140AD536947C9CBA))
(constraint (= (f #x5331E4BDB1E05630) #x14CC792F6C78158C))
(constraint (= (f #x183C63020022B9E8) #x060F18C08008AE7A))
(constraint (= (f #xB6D87962EF4F1C40) #x2DB61E58BBD3C710))
(constraint (= (f #x70F34895B686A16E) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xC6BAFEFC3A3F9DBC) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x5190932E478FE4C6) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x889C66617AA204BC) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x955AF811D1FE6A66) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x7BC9928F195E0851) #x0000000000000000))
(constraint (= (f #xAF21F16219179891) #x0000000000000000))
(constraint (= (f #xC6FE1AF9BF99BFD3) #x0000000000000000))
(constraint (= (f #x3B617DAC03484AB1) #x0000000000000000))
(constraint (= (f #x5717A940A03403B3) #x0000000000000000))
(constraint (= (f #xAE4536E2044B76FD) #x0000000000000000))
(constraint (= (f #x664EF35233C9C2F5) #x0000000000000000))
(constraint (= (f #x83A91C44746622C7) #x0000000000000000))
(constraint (= (f #xDB5D5D03419F242D) #x0000000000000000))
(constraint (= (f #xFC6B5BC838D9CABD) #x0000000000000000))
(constraint (= (f #xC10CA337F34F9330) #x304328CDFCD3E4CC))
(constraint (= (f #x6C886670A431B83E) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x18E3175B896EB9F3) #x0000000000000000))
(constraint (= (f #x5FF9F5F78EFFA69E) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x472C79A97FC80F8F) #x0000000000000000))
(constraint (= (f #x4186561B61C6EDBA) #x10619586D871BB6E))
(constraint (= (f #xB235C2391E0869BB) #x0000000000000000))
(constraint (= (f #x999009FA87E99173) #x0000000000000000))
(constraint (= (f #xFE7F93400CD09222) #x3F9FE4D003342488))
(constraint (= (f #x640BE3492B2CEEC8) #x1902F8D24ACB3BB2))
(constraint (= (f #x7495109E348C06DC) #xFFFFFFFFFFFFFFFE))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) #x0000000000000000 (ite (= (bvor #x0000000000000004 x) x) (bvnot #x0000000000000001) (bvudiv x #x0000000000000004))))
