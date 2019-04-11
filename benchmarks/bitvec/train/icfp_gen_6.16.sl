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
(constraint (= (f #x5269D534C1F68F0E) #x24D3AA6983ED1E1C))
(constraint (= (f #x71AB82E22F82152A) #x635705C45F042A54))
(constraint (= (f #x7D66021EC042D808) #x7ACC043D8085B010))
(constraint (= (f #x9893126891949CCC) #x312624D123293998))
(constraint (= (f #x4E2D65089394A7BC) #x1C5ACA1127294F78))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #x540DA51EB3FA2C79) #x0000A81B4A3D67F4))
(constraint (= (f #x7B5E6C95AE70F81B) #x0000F6BCD92B5CE0))
(constraint (= (f #xECEE5C39272027A9) #x0001D9DCB8724E40))
(constraint (= (f #xAE632F1423E010D3) #x00015CC65E2847C0))
(constraint (= (f #xD068C5F043A622BF) #x0001A0D18BE0874C))
(constraint (= (f #x0000000000000003) #x0000000000000000))
(constraint (= (f #x76831CFDB7CD373D) #x0000ED0639FB6F9A))
(constraint (= (f #x22AB8EF1C50DCE36) #x000045571DE38A1A))
(constraint (= (f #x1E5A856474BB22BF) #x00003CB50AC8E976))
(constraint (= (f #x3EBF7454D425F4F6) #x00007D7EE8A9A84A))
(constraint (= (f #x634B44B8ACC77E9D) #x0000C6968971598E))
(constraint (= (f #xC89AB6F4CCE774FE) #x000191356DE999CE))
(constraint (= (f #xCF917B3794F20E35) #x00019F22F66F29E4))
(constraint (= (f #xF3203AA1FCB4A99D) #x0001E6407543F968))
(constraint (= (f #x6E19F364FA035156) #x0000DC33E6C9F406))
(constraint (= (f #xA94A0E869C592EDB) #x000152941D0D38B2))
(constraint (= (f #x6E72E004C09F1A1C) #x0000DCE5C009813E))
(constraint (= (f #x5B5EA3972C946B5C) #x36BD472E5928D6B8))
(constraint (= (f #x2459634EEB9BA7CD) #x000048B2C69DD736))
(constraint (= (f #x6BE3FCC3BA34F7F1) #x0000D7C7F9877468))
(constraint (= (f #x6C6C257839D207D2) #x58D84AF073A40FA4))
(constraint (= (f #x0000000000000003) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (ite (= (bvurem x #x000000000000000d) #x0000000000000000) (bvlshr x #x000000000000000f) (ite (= (bvor #x0000000000000006 x) x) (ite (= (bvand #x0000000000000009 x) #x0000000000000000) (bvnot (bvneg (bvlshr x #x000000000000000f))) (ite (= (bvurem x #x000000000000000a) #x0000000000000000) (bvlshr x #x000000000000000f) (bvudiv (bvmul #x0000000000000004 x) #x0000000000000002))) (bvudiv (bvmul #x0000000000000004 x) #x0000000000000002))) (ite (not (= #x0000000000000003 x)) (ite (= (bvurem x #x000000000000000b) #x0000000000000000) (bvlshr x #x000000000000000f) (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (bvnot (bvneg (bvlshr x #x000000000000000f))) (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvlshr x #x000000000000000f) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (bvnot (bvneg (bvlshr x #x000000000000000f))) (ite (= (bvor #x0000000000000008 x) x) (ite (= (bvashr x x) #x0000000000000000) (bvlshr x #x000000000000000f) (bvnot (bvneg (bvlshr x #x000000000000000f)))) (bvnot (bvneg (bvlshr x #x000000000000000f)))))) (bvlshr x #x000000000000000f)))) (bvlshr x #x000000000000000f))))
