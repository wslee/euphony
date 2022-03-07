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
(constraint (= (f #x3335CFB6199F07E5) #x0000000000000002))
(constraint (= (f #xA4E09AE8529CBCAE) #x0000000000000002))
(constraint (= (f #x1081268BF5554867) #x0000000000000002))
(constraint (= (f #x7DCB54C972D04832) #x0000000000000002))
(constraint (= (f #x4ADFB9B79C3D4D7D) #x0000000000000002))
(constraint (= (f #x3791F1E2308F32B4) #x3791F1E2308F32B4))
(constraint (= (f #x8E012643536B2A6C) #x8E012643536B2A6C))
(constraint (= (f #xA96B206A78C9C7BE) #xA96B206A78C9C7BE))
(constraint (= (f #xA16175DAAC05D24E) #xA16175DAAC05D24E))
(constraint (= (f #xA9DB6CFCEA60A468) #xA9DB6CFCEA60A468))
(constraint (= (f #xF0F0F0F0F0F0F0F2) #x0000000000000002))
(constraint (= (f #xAAAAAAAAAAAAAAAB) #xAAAAAAAAAAAAAAAA))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #xA04026321AC588CA) #xA04026321AC588CA))
(constraint (= (f #xADCD34F1FE4EA326) #xADCD34F1FE4EA326))
(constraint (= (f #x9B968444F55F56C0) #x0000000000000002))
(constraint (= (f #x781248C9978CFFB3) #x781248C9978CFFB2))
(constraint (= (f #x95CEB97EF4A0FE25) #x95CEB97EF4A0FE24))
(constraint (= (f #xF47597868CECBCED) #xF47597868CECBCEC))
(constraint (= (f #x2CD25E455673C463) #x0000000000000002))
(constraint (= (f #x91DF2D16D35C9552) #x0000000000000002))
(constraint (= (f #xA80BCB8886379C50) #x0000000000000002))
(constraint (= (f #xC9E01855476CE422) #xC9E01855476CE422))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #xAAAAAAAAAAAAAAAB) #xAAAAAAAAAAAAAAAA))
(constraint (= (f #x4A948A112A529293) #x0000000000000002))
(constraint (= (f #x4AA4204A92548083) #x0000000000000002))
(constraint (= (f #x5EEFBBC18DE4AFC8) #x5EEFBBC18DE4AFC8))
(constraint (= (f #xD1F293C89B72B754) #x0000000000000002))
(constraint (= (f #xCE890B1932C7AB8D) #xCE890B1932C7AB8C))
(constraint (= (f #xF0F0F0F0F0F0F0F2) #x0000000000000002))
(constraint (= (f #x15B6FD1316945FF8) #x0000000000000002))
(constraint (= (f #x76527C1B23D057C9) #x0000000000000002))
(constraint (= (f #x7AEDE5B7270743F2) #x7AEDE5B7270743F2))
(constraint (= (f #xA08F1C4E676D3603) #xA08F1C4E676D3602))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvashr x x) #x0000000000000000) (ite (not (= #x0000000000000001 x)) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvurem x #x000000000000000b) #x0000000000000000) #x0000000000000002 (bvnot (bvneg x))) #x0000000000000002) #x0000000000000002) (bvnot (bvneg x))) (bvnot (bvneg x))) (ite (= (bvurem x #x0000000000000007) #x0000000000000000) x (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvand #x0000000000000005 x) #x0000000000000000) #x0000000000000002 (ite (= (bvashr x x) #x0000000000000000) x #x0000000000000002)) (ite (= (bvand #x000000000000000a x) #x0000000000000000) #x0000000000000002 (ite (= (bvor #x0000000000000006 x) x) (ite (= (bvand #x0000000000000009 x) #x0000000000000000) x #x0000000000000002) x))))))
