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
(constraint (= (f #xE2582A071A2A4027) #x0000712C15038D14))
(constraint (= (f #x1BBB9CE646E6BBE7) #x00000DDDCE732372))
(constraint (= (f #x8BB9DA4A7C216663) #x000045DCED253E11))
(constraint (= (f #x5CA40DC1D8297E75) #x00002E5206E0EC15))
(constraint (= (f #x330B572D86A88E4B) #x00001985AB96C355))
(constraint (= (f #x41CF48A62C5073FE) #x041CF48A62C50740))
(constraint (= (f #xFB119E35FC3611F2) #x0FB119E35FC3611F))
(constraint (= (f #x7183FFEB04D6FA64) #x07183FFEB04D6FA6))
(constraint (= (f #x8F9D11F1D21F213A) #x08F9D11F1D21F213))
(constraint (= (f #x5A2976F47BD2CF6E) #x05A2976F47BD2CF7))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #x0000000000000001))
(constraint (= (f #x0005555555555556) #x00000002AAAAAAAB))
(constraint (= (f #x5555555555555556) #x00002AAAAAAAAAAB))
(constraint (= (f #x0155555555555556) #x000000AAAAAAAAAB))
(constraint (= (f #x0000000005555556) #x00000000000002AB))
(constraint (= (f #x1555555555555556) #x00000AAAAAAAAAAB))
(check-synth)
