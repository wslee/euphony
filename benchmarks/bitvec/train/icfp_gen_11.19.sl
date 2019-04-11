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
(constraint (= (f #x77F6D3587D33F8AC) #x0000EFEDA6B0FA67))
(constraint (= (f #xBA126A4C3CAF8326) #x00007424D498795F))
(constraint (= (f #x1C9CFA1FA96D95DE) #x00003939F43F52DB))
(constraint (= (f #xAE01303465C381AC) #x00005C026068CB87))
(constraint (= (f #x984EE90F3B3597BD) #x0000309DD21E766B))
(constraint (= (f #xD47F048B4E3B2222) #x0000A8FE09169C76))
(constraint (= (f #x8EF5924F1EE500EA) #x00001DEB249E3DCA))
(constraint (= (f #xE8047A86DE8704AB) #x0000D008F50DBD0E))
(constraint (= (f #xB2DDAD0AB759417B) #x000065BB5A156EB2))
(constraint (= (f #xBE2BE74998777D72) #x00007C57CE9330EE))
(constraint (= (f #xFFFFFFFFFFFFFFC5) #x0000FFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFFFFD4) #x0000FFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFFFFD2) #x0000FFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFFFFD8) #x0000FFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFFFFD0) #x0000FFFFFFFFFFFF))
(constraint (= (f #x0D2660D34C2AC659) #x03499834D30AB196))
(constraint (= (f #x73DF9C9F2A37FFFF) #x1CF7E727CA8E0000))
(constraint (= (f #x91FAF3662A6ACDA5) #x247EBCD98A9AB369))
(constraint (= (f #xE734B6B141D2C0FD) #x39CD2DAC5074B03F))
(constraint (= (f #xFB2FBBCD5F40DAFA) #x3ECBEEF357D036BE))
(constraint (= (f #x340A096B61DA6088) #x0D02825AD8769822))
(constraint (= (f #x9E186459E52E051A) #x27861916794B8146))
(constraint (= (f #x86560BC21A7214CA) #x219582F0869C8532))
(constraint (= (f #x1715825E243404FD) #x05C56097890D013F))
(constraint (= (f #xD6640B2B2DF26C9D) #x359902CACB7C9B27))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000007 x) x) (bvneg (bvnot (bvudiv x #x0000000000000004))) (ite (= (bvand #x0000000000000009 x) #x0000000000000000) (bvlshr (bvadd x x) #x0000000000000010) (ite (= (bvurem x #x000000000000000c) #x0000000000000000) (bvlshr (bvadd x x) #x0000000000000010) (ite (= (bvor #x0000000000000003 x) x) (bvlshr (bvadd x x) #x0000000000000010) (ite (= (bvor #x0000000000000006 x) x) (bvlshr x #x000000000000000f) (ite (= (bvashr x x) #x0000000000000000) (bvudiv x #x0000000000000004) (ite (= (bvurem x #x000000000000000a) #x0000000000000000) (bvlshr (bvadd x x) #x0000000000000010) (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (ite (= (bvsrem x #x0000000000000003) #x0000000000000000) (bvudiv x #x0000000000000004) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (bvlshr (bvadd x x) #x0000000000000010) (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (bvlshr (bvadd x x) #x0000000000000010) (bvudiv x #x0000000000000004)))) (bvudiv x #x0000000000000004))))))))))
