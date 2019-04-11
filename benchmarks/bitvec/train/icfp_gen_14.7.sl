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
(constraint (= (f #x7A51B30C58FE0230) #x8EF2D514E9020650))
(constraint (= (f #x5271B1221413D2D1) #xF692D3663C347772))
(constraint (= (f #x6238CBAD0F5BC767) #xA6495CF711EC49A8))
(constraint (= (f #xE7626A0A918E2D69) #x29A6BE1FB29277BA))
(constraint (= (f #xE5138119F353379B) #x2F34832A15F558AC))
(constraint (= (f #xB093012C38934429) #xD1B5037449B5CC7A))
(constraint (= (f #x8E804138980366DD) #x9380C349A805AB66))
(constraint (= (f #x1A7A4004348B4235) #x2E8EC00C5D9DC65E))
(constraint (= (f #xDF900004C1B3184D) #x60B0000D42D528D6))
(constraint (= (f #x604718380243AC29) #xA0C9284806C4F47A))
(constraint (= (f #x68D8C3C211351335) #xF97273C3DEECAECC))
(constraint (= (f #xA07D554F63A5BCAC) #xF5F82AAB09C5A435))
(constraint (= (f #x53126934AF652A57) #xFACED96CB509AD5A))
(constraint (= (f #x25E7628B2255BBD7) #xFDA189D74DDAA442))
(constraint (= (f #xF3242C8D2461545B) #xF0CDBD372DB9EABA))
(constraint (= (f #xFFFFC0000FFFFC02) #xF00003FFFF00003F))
(constraint (= (f #x2B3494C04305BC91) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x3240C1220E995047) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x2AD151060629C091) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0D03F0CC0A010563) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xD705207A09854409) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000000001) #xFFFFFFFFFFFFFFFF))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (bvnot (bvudiv x #x0000000000000010)) (bvxor (bvadd x x) x)) (ite (= (bvand #x000000000000000c x) #x0000000000000000) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvnot #x0000000000000000) (bvxor (bvsub x (bvnot x)) x)) (bvnot #x0000000000000000)) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (ite (= (bvurem x #x000000000000000b) #x0000000000000001) (bvnot #x0000000000000000) (ite (= (bvashr x x) #x0000000000000000) (bvxor (bvsub x (bvnot x)) x) (ite (= (bvor #x000000000000000c x) x) (bvxor (bvsub x (bvnot x)) x) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvxor (bvsub x (bvnot x)) x) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvxor (bvsub x (bvnot x)) x) (bvnot #x0000000000000000)))))) (ite (= (bvor #x000000000000000c x) x) (bvxor (bvsub x (bvnot x)) x) (ite (= (bvurem x #x000000000000000b) #x0000000000000000) (bvxor (bvsub x (bvnot x)) x) (ite (= (bvashr x x) #x0000000000000000) (bvnot (bvudiv x #x0000000000000010)) (ite (= (bvurem x #x0000000000000007) #x0000000000000000) (bvnot (bvudiv x #x0000000000000010)) (bvxor (bvsub x (bvnot x)) x)))))))))
