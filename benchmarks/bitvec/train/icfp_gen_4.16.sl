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
(constraint (= (f #x46F9174FFEAFE848) #xDC83745800A80BDB))
(constraint (= (f #x871839319ADCB919) #xBC73E3673291A373))
(constraint (= (f #x500BF20069B885AE) #xD7FA06FFCB23BD29))
(constraint (= (f #x547134CB5F9633D0) #xD5C7659A5034E617))
(constraint (= (f #xE3BAB15C8FC38F73) #x8E22A751B81E3847))
(constraint (= (f #xFFFFFFFFFFFF26A1) #x8000000000006CAF))
(constraint (= (f #xFFFFFFFFFFFFDCDF) #x8000000000001191))
(constraint (= (f #xFFFFFFFFFFFF58F4) #x8000000000005385))
(constraint (= (f #xFFFFFFFFFFFF43ED) #x8000000000005E09))
(constraint (= (f #xFFFFFFFFFFFF431F) #x8000000000005E71))
(constraint (= (f #xA31C71540C60382B) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x8C2206180C61870D) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x284631501C50860F) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x104070C31420C629) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xD0C07110630AAAA9) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xE47834BAC516C572) #x8DC3E5A29D749D47))
(constraint (= (f #x55B6B2D574AF74AC) #xD524A69545A845A9))
(constraint (= (f #x6E5EC2C261A434D9) #xC8D09E9ECF2DE593))
(constraint (= (f #xFA6B5A1484B73992) #x82CA52F5BDA46337))
(constraint (= (f #x7146578B0D04C8E7) #xC75CD43A797D9B8D))
(constraint (= (f #x0407DFC0BB9F9614) #xFDFC101FA23034F5))
(constraint (= (f #x26EBD77F267590EF) #xEC8A14406CC53789))
(constraint (= (f #x1DECD9E43014A512) #xF109930DE7F5AD77))
(constraint (= (f #xC7A234B884C437F1) #x9C2EE5A3BD9DE407))
(constraint (= (f #xD6C5856F1ED2AC69) #x949D3D487096A9CB))
(constraint (= (f #x51C1C4718C00850F) #xFFFFFFFFFFFFFFFF))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x000000000000000b x) x) (ite (= (bvand #x0000000000000004 x) #x0000000000000000) (bvnot #x0000000000000000) (ite (= (bvurem x #x0000000000000005) #x0000000000000001) (bvnot #x0000000000000000) (bvneg (bvudiv x #x0000000000000002)))) (bvneg (bvudiv x #x0000000000000002))) (ite (= (bvor #x0000000000000010 x) x) (bvnot (bvudiv x #x0000000000000002)) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvurem x #x0000000000000007) #x0000000000000000) (bvnot #x0000000000000000) (ite (= (bvashr x x) #x0000000000000000) (bvnot #x0000000000000000) (ite (= (bvurem x #x0000000000000005) #x0000000000000001) (bvnot #x0000000000000000) (bvnot (bvudiv x #x0000000000000002))))) (bvnot (bvudiv x #x0000000000000002))))))
