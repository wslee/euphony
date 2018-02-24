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
(constraint (= (f #x84EB546DF4EB310D) #x01CB080D278B0AB3))
(constraint (= (f #xAADA5137770AB749) #x00024432999B8098))
(constraint (= (f #x573522F06DDA072B) #x001A8263BD2647DA))
(constraint (= (f #x434B4229B885C2E9) #x00E888E614D9C6E3))
(constraint (= (f #x48667CD1D1CEC80C) #x009D55EA3636B29F))
(constraint (= (f #x396B7B0D06514778) #xFFFFFC69484F2F9A))
(constraint (= (f #x7201559930641556) #xFFFFF8DFEAA66CF9))
(constraint (= (f #xBA9414D9C87D3C55) #xFFFFF456BEB26378))
(constraint (= (f #x278697A83321747A) #xFFFFFD8796857CCD))
(constraint (= (f #x5E90641CBFEC41DE) #xFFFFFA16F9BE3401))
(constraint (= (f #x0000000144FC47A1) #x000000000F341323))
(constraint (= (f #x0000000157F6BA82) #x000000000FE06F3E))
(constraint (= (f #x0000000172DD1C4A) #x000000000E5D9C93))
(constraint (= (f #x00000001CEB9316A) #x00000000094F2D4E))
(constraint (= (f #x0000000123D32305) #x000000000D91D594))
(constraint (= (f #xFFFFFFFFC0000002) #x03FFFFFFFEFFFFFF))
(constraint (= (f #x0000000000000001) #x03FFFFFFFFFFFFFF))
(constraint (= (f #x0000FFFFFFFFFFFE) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x00000001DB1A83D3) #xFFFFFFFFFFFFE24E))
(constraint (= (f #x00000001CCB42550) #xFFFFFFFFFFFFE334))
(constraint (= (f #x00000001F9697E50) #xFFFFFFFFFFFFE069))
(constraint (= (f #x0000000121DB209B) #xFFFFFFFFFFFFEDE2))
(constraint (= (f #x000000011E737772) #xFFFFFFFFFFFFEE18))
(check-synth)
