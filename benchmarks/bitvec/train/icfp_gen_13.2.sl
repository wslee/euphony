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
(constraint (= (f #x2F34991EFA1E2318) #xD0CB66E105E1DCE7))
(constraint (= (f #x007D556A3F0E2C1C) #xFF82AA95C0F1D3E3))
(constraint (= (f #x27FA9DF2D2B0C0AA) #xD805620D2D4F3F55))
(constraint (= (f #xEBE6702FB7FCB068) #x14198FD048034F97))
(constraint (= (f #x8256C84538746248) #x7DA937BAC78B9DB7))
(constraint (= (f #x000000000000002A) #xFFFFFFFFFFFFFFD5))
(constraint (= (f #x0000000000000024) #xFFFFFFFFFFFFFFDB))
(constraint (= (f #x000000000000002E) #xFFFFFFFFFFFFFFD1))
(constraint (= (f #x0000000000000034) #xFFFFFFFFFFFFFFCB))
(constraint (= (f #x0000000000000032) #xFFFFFFFFFFFFFFCD))
(constraint (= (f #x9AC4235BDB8C2255) #x00009AC4235BDB8C))
(constraint (= (f #x1ACE9F8EE5B68635) #x00001ACE9F8EE5B6))
(constraint (= (f #x8123FFA4DA734F8A) #x00008123FFA4DA73))
(constraint (= (f #x9682C888ED91A8B7) #x00009682C888ED91))
(constraint (= (f #x9A60731D2E5D23C7) #x00009A60731D2E5D))
(constraint (= (f #xCCCCCCCCCCCCCCCE) #x3333333333333331))
(constraint (= (f #x0000000000000021) #x0000000000000000))
(constraint (= (f #x0000000000000027) #x0000000000000000))
(constraint (= (f #x000000000000003F) #x0000000000000000))
(constraint (= (f #x0000000000000025) #x0000000000000000))
(constraint (= (f #x000000000000003B) #x0000000000000000))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #xFFFFFFFFFFFFFFFD) #x0000FFFFFFFFFFFF))
(constraint (= (f #x9BB79716AE626E96) #x644868E9519D9169))
(constraint (= (f #xF1C242483713DC9B) #x0000F1C242483713))
(constraint (= (f #xD4E49F9B3519297B) #x0000D4E49F9B3519))
(constraint (= (f #x7CF22541C1E29840) #x830DDABE3E1D67BF))
(constraint (= (f #x12D4E54FDD614B21) #x000012D4E54FDD61))
(constraint (= (f #x5A146FA521E91C24) #x00005A146FA521E9))
(constraint (= (f #xDF098CFDB394E366) #x20F673024C6B1C99))
(constraint (= (f #x51AFE024295249B5) #x000051AFE0242952))
(constraint (= (f #xB71507C4560CB9A7) #x0000B71507C4560C))
(constraint (= (f #x0A51DD99CE22A720) #xF5AE226631DD58DF))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #x0000000000000034) #xFFFFFFFFFFFFFFCB))
(constraint (= (f #xFFFFFFFFFFFFFFFD) #x0000FFFFFFFFFFFF))
(constraint (= (f #xCCCCCCCCCCCCCCCE) #x3333333333333331))
(constraint (= (f #x000000000000002F) #x0000000000000000))
(constraint (= (f #x1F1B3A542601310E) #x00001F1B3A542601))
(constraint (= (f #x5D98707EE658CAD1) #x00005D98707EE658))
(constraint (= (f #xBED4C149F7503A43) #x0000BED4C149F750))
(constraint (= (f #xA83A183BEED6987F) #x0000A83A183BEED6))
(constraint (= (f #x3584B9E65A2CB887) #x00003584B9E65A2C))
(constraint (= (f #x463BA626BFD6CC9D) #x0000463BA626BFD6))
(constraint (= (f #x3AF10C59230EA4AB) #x00003AF10C59230E))
(constraint (= (f #x784CAEF1EB3B50CA) #x0000784CAEF1EB3B))
(constraint (= (f #x832F086E53C3B7A6) #x0000832F086E53C3))
(constraint (= (f #xC4C7F5E1F65BC0DE) #x0000C4C7F5E1F65B))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvlshr x #x0000000000000010) (ite (= (bvshl x x) #x0000000000000000) (ite (= (bvand #x0000000000000007 x) #x0000000000000000) (bvnot x) (ite (= (bvand #x000000000000000b x) #x0000000000000000) (bvlshr x #x0000000000000010) (ite (= (bvor #x000000000000000a x) x) (ite (= (bvor #x0000000000000010 x) x) (bvlshr x #x0000000000000010) (ite (= (bvurem x #x0000000000000005) #x0000000000000001) (bvnot x) (ite (= (bvashr x x) #x0000000000000000) (bvlshr x #x0000000000000010) (ite (= (bvor #x0000000000000004 x) x) (bvnot x) (bvlshr x #x0000000000000010))))) (ite (= (bvor #x0000000000000010 x) x) (bvnot x) (ite (= (bvsrem x #x0000000000000005) #x0000000000000000) (bvnot x) (bvlshr x #x0000000000000010)))))) (bvnot x))))
