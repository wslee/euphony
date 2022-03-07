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
(constraint (= (f #xD44AB4736D8107CB) #xA89568E6DB020F97))
(constraint (= (f #xEDDC78D42D651711) #xDBB8F1A85ACA2E23))
(constraint (= (f #xC16E4B1649021037) #x82DC962C9204206F))
(constraint (= (f #xED1392C85082BCE3) #xDA272590A10579C7))
(constraint (= (f #x90D5343161DD79D5) #x21AA6862C3BAF3AB))
(constraint (= (f #xBF59DCA1E5CAFDBC) #xFD677287972BF6F2))
(constraint (= (f #xE43AAF5497C75230) #x90EABD525F1D48C2))
(constraint (= (f #xBF86DDDC205AB0C2) #xFE1B7770816AC30A))
(constraint (= (f #x0B5B1464C1D69F20) #x2D6C5193075A7C82))
(constraint (= (f #x27B2AFE1F48613BE) #x9ECABF87D2184EFA))
(constraint (= (f #x681486092C3050F1) #x681486092C3050F2))
(constraint (= (f #x0F02843C2C0282D1) #x0F02843C2C0282D2))
(constraint (= (f #xB04A1480E061A079) #xB04A1480E061A07A))
(constraint (= (f #xA0E0F0A580E14819) #xA0E0F0A580E1481A))
(constraint (= (f #xC10C0524960A5091) #xC10C0524960A5092))
(constraint (= (f #x0000000000000021) #x0000000000000043))
(constraint (= (f #x0000000000000029) #x0000000000000053))
(constraint (= (f #x000000000000002B) #x0000000000000057))
(constraint (= (f #x0000000000000033) #x0000000000000067))
(constraint (= (f #x000000000000003F) #x000000000000007F))
(constraint (= (f #x0000000000000036) #x000000000000006D))
(constraint (= (f #x000000000000002A) #x0000000000000055))
(constraint (= (f #x000000000000002C) #x0000000000000059))
(constraint (= (f #x0000000000000035) #x0000000000000036))
(constraint (= (f #x0000000000000031) #x0000000000000032))
(constraint (= (f #x000000000000003D) #x000000000000003E))
(constraint (= (f #x0000000000000039) #x000000000000003A))
(constraint (= (f #x66989C7710E042F2) #x9A6271DC43810BCA))
(constraint (= (f #xD209BCD09D27C4D0) #x4826F342749F1342))
(constraint (= (f #x9C9D5AF4A276ED45) #x393AB5E944EDDA8B))
(constraint (= (f #xE062307C276760BF) #xC0C460F84ECEC17F))
(constraint (= (f #x5D9585D4EF87F0B6) #x76561753BE1FC2DA))
(constraint (= (f #x692BA8A7015EDF0D) #xD257514E02BDBE1B))
(constraint (= (f #xEDA100A6D9E0B6C7) #xDB42014DB3C16D8F))
(constraint (= (f #xD78F9060B219F953) #xAF1F20C16433F2A7))
(constraint (= (f #x644A273CB6B8F706) #x91289CF2DAE3DC1A))
(constraint (= (f #xD5ED0F07FE361479) #xABDA1E0FFC6C28F3))
(constraint (= (f #x496905858604B05B) #x496905858604B05C))
(constraint (= (f #x0000000000000035) #x0000000000000036))
(constraint (= (f #x0000000000000038) #x0000000000000071))
(constraint (= (f #x0000000000000029) #x0000000000000053))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvurem x #x0000000000000007) #x0000000000000000) (ite (= (bvor #x0000000000000009 x) x) (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (bvsub x (bvnot x)) (bvxor #x0000000000000007 x)) (bvsub x (bvnot x))) (bvsub x (bvnot x))) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (bvsub x (bvnot x)) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvsub x (bvnot x)) (ite (= (bvor #x0000000000000009 x) x) (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (bvxor #x0000000000000003 x) (ite (= (bvlshr x #x0000000000000006) #x0000000000000000) (bvxor #x0000000000000003 x) (bvsub x (bvnot x)))) (bvxor #x0000000000000003 x))) (bvxor #x0000000000000003 x)))) (ite (= (bvlshr x #x0000000000000006) #x0000000000000000) (bvsub x (bvnot x)) (bvxor (bvmul #x0000000000000004 x) #x0000000000000002))))
