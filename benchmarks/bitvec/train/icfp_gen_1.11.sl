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
(constraint (= (f #x9ACB3BCA80FDAF6E) #x00009ACB3BCA80FD))
(constraint (= (f #x38E37ED5C4C9AE06) #x000038E37ED5C4C9))
(constraint (= (f #xD27350952BA8CAC8) #x0000D27350952BA8))
(constraint (= (f #xA8B2184F1FCB5E02) #x0000A8B2184F1FCB))
(constraint (= (f #x3B47C334FE9D06A8) #x00003B47C334FE9D))
(constraint (= (f #x0000000000010C1A) #x0000000000000001))
(constraint (= (f #x000000000001232C) #x0000000000000001))
(constraint (= (f #x000000000001C014) #x0000000000000001))
(constraint (= (f #x000000000001021A) #x0000000000000001))
(constraint (= (f #x0000000000016474) #x0000000000000001))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #xAFE4DC7D9F433E6B) #x501B238260BCC194))
(constraint (= (f #xC012B152668A4653) #x3FED4EAD9975B9AC))
(constraint (= (f #xD7F034E4A452267B) #x280FCB1B5BADD984))
(constraint (= (f #x002EE53FE3320D9D) #xFFD11AC01CCDF262))
(constraint (= (f #xED434B308047A959) #x12BCB4CF7FB856A6))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #x0000000000000000))
(constraint (= (f #x0000000000018867) #xFFFFFFFFFFFE7798))
(constraint (= (f #x0000000000014EC5) #xFFFFFFFFFFFEB138))
(constraint (= (f #x000000000001531D) #xFFFFFFFFFFFEACE0))
(constraint (= (f #x000000000001CEAB) #xFFFFFFFFFFFE3154))
(constraint (= (f #x0000000000016867) #xFFFFFFFFFFFE9798))
(constraint (= (f #x015E678DC91DB3A9) #xFEA1987236E24C56))
(constraint (= (f #xF1BD6C417FA8A4E6) #x0000F1BD6C417FA8))
(constraint (= (f #xA4E41BD254B1AE7F) #x5B1BE42DAB4E5180))
(constraint (= (f #x25AF3296F7925AC4) #x000025AF3296F792))
(constraint (= (f #xE0E3D45086ACB4E2) #x0000E0E3D45086AC))
(constraint (= (f #x1E78D8B2034FF300) #x00001E78D8B2034F))
(constraint (= (f #x186861D55227F952) #x0000186861D55227))
(constraint (= (f #x0BF9FABAB94211AA) #x00000BF9FABAB942))
(constraint (= (f #x93A89B5EC03013D9) #x6C5764A13FCFEC26))
(constraint (= (f #x3AFE07A7FA652528) #x00003AFE07A7FA65))
(constraint (= (f #x000000000001A595) #xFFFFFFFFFFFE5A68))
(constraint (= (f #x0000000000011D13) #xFFFFFFFFFFFEE2EC))
(constraint (= (f #x00000000000154A4) #x0000000000000001))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (bvlshr x #x0000000000000010) (ite (= (bvand #x000000000000000a x) #x0000000000000000) (bvnot (bvxor #x0000000000000002 x)) (ite (= (bvor #x000000000000000c x) x) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvnot x) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvnot x) (bvnot (bvxor #x0000000000000002 x)))) (bvnot x)))))
