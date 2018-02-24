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
(constraint (= (f #x6ec3248418558b84) #x6ec3248418558b84))
(constraint (= (f #x01d6903ea2282e63) #x01d6903ea2282e63))
(constraint (= (f #x6becab11e1c19946) #x6becab11e1c19946))
(constraint (= (f #x92ed828198ed7441) #x12ed828198ed7441))
(constraint (= (f #xc11cece67ca06bad) #x411cece67ca06bad))
(constraint (= (f #x13adecabaab1956d) #x275bd95755632ada))
(constraint (= (f #x5e4c53e9d83ccce7) #xbc98a7d3b07999ce))
(constraint (= (f #x997e2c9a77a823e1) #x197e2c9a77a823e1))
(constraint (= (f #x0b97de3b6b722418) #x0b97de3b6b722418))
(constraint (= (f #x7a70e09bd34bc755) #x7a70e09bd34bc755))
(check-synth)
