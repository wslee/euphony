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
(constraint (= (f #xD39B4C1E74F99600) #xEF7FB87DFBF77C02))
(constraint (= (f #x847E7995220E22E6) #x19FDF77ECC3CCFDE))
(constraint (= (f #x7EFACDAE3CA27366) #xFFFFBFFCFBCDEFDE))
(constraint (= (f #x50B9B102323C8462) #xE3F7E60CECFB19CE))
(constraint (= (f #xB4744C6E2799E5AE) #xF9F9B9FCDF77DFFE))
(constraint (= (f #xED979071CEBF841A) #xC8C6B1556C3E8C4E))
(constraint (= (f #x9F5FE4F24C080A57) #xDE1FAED6E4181F05))
(constraint (= (f #x726677BF5830F9F7) #x5733673E0892EDE5))
(constraint (= (f #x9DA6E87F13579372) #xD8F4B97D3A06BA56))
(constraint (= (f #x42300D345E9F633D) #xC690279D1BDE29B7))
(constraint (= (f #x0000000000000002) #x0000000000000006))
(constraint (= (f #x9143623AC23A2508) #x678FCCFF8CFCDE32))
(constraint (= (f #xC9670B71513B306F) #xB7DE3FE7E6FEE1FC))
(constraint (= (f #xA740F16C54E1F5B7) #xF5C2D444FEA5E125))
(constraint (= (f #xD34A99D77FE712AD) #xEFBF77FFFFDE6FFC))
(constraint (= (f #x0BFC2684049F23C6) #x3FF8DF181B7ECF9E))
(constraint (= (f #x2E089B96C5656CD9) #x8A19D2C45030468B))
(constraint (= (f #x974440D351015F6C) #x7F9983EFE607FFFA))
(constraint (= (f #x98B17CCF5A8440C3) #x73E7FBBFFF19838C))
(constraint (= (f #xB9C0E3744930C9BA) #x2D42AA5CDB925D2E))
(constraint (= (f #x6F3D7F5C08DDFF0B) #xFEFFFFF833FFFE3C))
(constraint (= (f #x0000000000000002) #x0000000000000006))
(constraint (= (f #x0000000000000003) #x000000000000000C))
(constraint (= (f #x0000000000000001) #x0000000000000004))
(check-synth)
