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
(constraint (= (f #xF1AA14DEC3996D7E) #x0C01C20038440001))
(constraint (= (f #x3C4784AB51BB8C81) #x833072000C00627C))
(constraint (= (f #xA0D5A65B64F9B14D) #x1E00110012040C20))
(constraint (= (f #xA5E43ACC4E6A3C67) #x1013802321018310))
(constraint (= (f #x86A239A32AFECC61) #x701984188000231C))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #xEBB5561A8021FA9B) #x000001C07F9C0040))
(constraint (= (f #xA0B9553FCDD93689) #x1E04008020048064))
(constraint (= (f #x06499CE1ADC68787) #xF124421C00307070))
(constraint (= (f #x198184365CB3AAFC) #xC47C738102080003))
(constraint (= (f #x0E670BC050304A8F) #xE110E03F0F8F2060))
(constraint (= (f #x000000197527A00E) #xFFFFFFC400901FE1))
(constraint (= (f #x0000001A23544C1A) #xFFFFFFC1980323C1))
(constraint (= (f #x0000001D499B84D1) #xFFFFFFC02440720C))
(constraint (= (f #x00000013738A10FF) #xFFFFFFC80861CE00))
(constraint (= (f #x00000011C23DA064) #xFFFFFFCC39801F13))
(constraint (= (f #xA611B569672C6302) #x4C236AD2CE58C604))
(constraint (= (f #x0866FBB193893F20) #x10CDF76327127E40))
(constraint (= (f #x3F27DD8EEF556E7D) #x7E4FBB1DDEAADCFA))
(constraint (= (f #xF88EB6FB0F8A4729) #xF11D6DF61F148E52))
(constraint (= (f #x747C16B88F59EF13) #xE8F82D711EB3DE26))
(constraint (= (f #x000000124CD1CB8C) #x000000124CD1CB8D))
(constraint (= (f #x0000001B15FD5A3E) #x0000001B15FD5A3F))
(constraint (= (f #x000000133C85CF3C) #x000000133C85CF3D))
(constraint (= (f #x00000018DCC59E62) #x00000018DCC59E63))
(constraint (= (f #x000000150D5997E8) #x000000150D5997E9))
(constraint (= (f #x0000001D76B17A04) #x0000001D76B17A05))
(constraint (= (f #x0000001F0256C6BC) #x0000001F0256C6BD))
(constraint (= (f #x00000013DF9712D6) #x00000013DF9712D7))
(constraint (= (f #x0000001E5FFBFBAB) #x0000001E5FFBFBAC))
(constraint (= (f #x0000001D63EEA2FD) #x0000001D63EEA2FE))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000009 x) x) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (ite (= (bvsrem x #x0000000000000007) #x0000000000000000) (bvadd x x) (bvxor #x0000000000000003 x)) (ite (= (bvand #x0000000000000007 x) #x0000000000000001) (ite (= (bvurem x #x000000000000000d) #x0000000000000000) (bvnot (bvor (bvadd x x) x)) (bvadd x x)) (ite (= (bvand #x0000000000000004 x) #x0000000000000000) (ite (= (bvor #x0000000000000010 x) x) (bvnot (bvor (bvadd x x) x)) (bvxor #x0000000000000007 x)) (bvnot (bvor (bvadd x x) x))))) (ite (= (bvand #x000000000000000d x) #x0000000000000000) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (bvxor #x0000000000000001 x) (bvadd x x)) (ite (= (bvor #x0000000000000003 x) x) (ite (= (bvor #x0000000000000010 x) x) (bvadd x x) (bvnot (bvor (bvadd x x) x))) (ite (= (bvashr x x) #x0000000000000000) (ite (not (= #x0000000000000001 x)) (ite (= (bvand #x0000000000000007 x) #x0000000000000001) (bvnot (bvor (bvadd x x) x)) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (ite (= (bvor #x000000000000000a x) x) (bvnot (bvor (bvadd x x) x)) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvxor #x0000000000000001 x) (ite (= (bvurem x #x0000000000000005) #x0000000000000001) (bvxor #x0000000000000001 x) (bvnot (bvor (bvadd x x) x))))) (bvxor #x0000000000000001 x))) #x0000000000000000) (bvnot (bvor (bvadd x x) x)))))))
