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
(constraint (= (f #x22726DE422515A37) #x022224C402011023))
(constraint (= (f #x047AF1A04FD2C8D3) #x0042A10004D00881))
(constraint (= (f #x3489B12BA10E18BC) #x00089102A0000088))
(constraint (= (f #xA040B52748F59ED5) #x00000102408518C5))
(constraint (= (f #x6389FBECC75CE58D) #x02089BACC454C408))
(constraint (= (f #x31539D89D6299645) #x31539D89D6299644))
(constraint (= (f #x57915ADC2C6F3941) #x57915ADC2C6F3940))
(constraint (= (f #xEFD823E8FCBDB1FF) #xEFD823E8FCBDB1FE))
(constraint (= (f #xAAA28BA9C999760A) #xAAA28BA9C999760B))
(constraint (= (f #xF5392318BFF9E8A5) #xF5392318BFF9E8A4))
(constraint (= (f #xFFFFFFFFFFFE72B2) #x0FFFFFFFFFFE4212))
(constraint (= (f #xFFFFFFFFFFFEC23E) #x0FFFFFFFFFFEC006))
(constraint (= (f #xFFFFFFFFFFFEAAE8) #x0FFFFFFFFFFE8048))
(constraint (= (f #xFFFFFFFFFFFE1CED) #x0FFFFFFFFFFE008D))
(constraint (= (f #xFFFFFFFFFFFEEB6B) #x0FFFFFFFFFFEC969))
(constraint (= (f #x0000000000005151) #x0000000000000111))
(constraint (= (f #x00000000000352EE) #x000000000000102E))
(constraint (= (f #x000000000004F8C5) #x0000000000004884))
(constraint (= (f #x000000000002CC84) #x0000000000000C80))
(constraint (= (f #x00000000000A518C) #x0000000000000108))
(constraint (= (f #x0000000000095CED) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x00000000000F9698) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x000000000007FFF7) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x00000000000D48B3) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x00000000000F14B3) #xFFFFFFFFFFFFFFFE))
(check-synth)
