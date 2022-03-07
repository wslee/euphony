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
(constraint (= (f #x98095205D52F3184) #xF7FFEFFFAAFDCEFF))
(constraint (= (f #x46129A3EF88EB4C4) #xFBFFF7DD17775FBB))
(constraint (= (f #x5B2F0053B6864522) #xFEDDFFFECDFFBBFD))
(constraint (= (f #x97E0D71886676C21) #xFE9FFAEF7F999BFF))
(constraint (= (f #xF4E8EDE17F156564) #xFBB7733FE8EEBBBB))
(constraint (= (f #x00000000001C6E85) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x00000000001F2E66) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x000000000015F247) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000165384) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x00000000001217A7) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x78F657674F5380ED) #xFF79BA99BBAEFFF3))
(constraint (= (f #xB37D045D45C23468) #xFCCAFFBABBBFDFBF))
(constraint (= (f #xCD114FE6C5E541AE) #xF3EEFB19BBBBBFF5))
(constraint (= (f #x836EBB9626DBBBC9) #xFFD9546FDDB64477))
(constraint (= (f #x35902E91A4E3EA0C) #xFEEFFD7EFFBDD5FF))
(constraint (= (f #x0000000000000002) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000000003) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xE0C21C601442A496) #x00000E0C21C60144))
(constraint (= (f #x528EDB05A7D80214) #x00000528EDB05A7D))
(constraint (= (f #xF010527904F83E76) #x00000F010527904F))
(constraint (= (f #x78736C3BCBD552D4) #x0000078736C3BCBD))
(constraint (= (f #xE3A37EDC9421E517) #x00000E3A37EDC942))
(constraint (= (f #x0000000000101F69) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x00000000001F45C8) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000166828) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x00000000001384ED) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000119FFF) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x000000000010FCF0) #x0000000000000001))
(constraint (= (f #x00000000001CFFD7) #x0000000000000001))
(constraint (= (f #x000000000017C014) #x0000000000000001))
(constraint (= (f #x00000000001A2CF1) #x0000000000000001))
(constraint (= (f #x0000000000155291) #x0000000000000001))
(constraint (= (f #xAAAAAAAAAAAAAAAB) #x00000AAAAAAAAAAA))
(constraint (= (f #x43F862DC137D9A5B) #x0000043F862DC137))
(constraint (= (f #x51D8F5FF916FBD59) #x0000051D8F5FF916))
(constraint (= (f #xA9276BD7BCE9148F) #x00000A9276BD7BCE))
(constraint (= (f #x5C3C65200A4E0F9B) #x000005C3C65200A4))
(constraint (= (f #x5F1F5F58DB7AAC9E) #x000005F1F5F58DB7))
(constraint (= (f #x00000000001CDD3A) #x0000000000000001))
(constraint (= (f #x00000000001D84BE) #x0000000000000001))
(constraint (= (f #x0000000000157B6F) #x0000000000000001))
(constraint (= (f #x00000000001623AF) #x0000000000000001))
(constraint (= (f #x00000000001308DE) #x0000000000000001))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvor #x000000000000000f x) x) (bvnot #x0000000000000000) (bvudiv (bvlshr x #x0000000000000010) #x0000000000000010)) (ite (= (bvor #x000000000000000b x) x) (bvudiv (bvlshr x #x0000000000000010) #x0000000000000010) (ite (= (bvashr x x) #x0000000000000000) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (ite (= (bvand #x0000000000000007 x) #x0000000000000000) (bvnot #x0000000000000000) (bvnot (bvand (bvudiv x #x0000000000000010) x))) (ite (= (bvor #x000000000000000c x) x) (ite (= (bvurem x #x000000000000000d) #x0000000000000000) (bvnot #x0000000000000000) (bvnot (bvand (bvudiv x #x0000000000000010) x))) (bvnot #x0000000000000000))) (bvnot (bvand (bvudiv x #x0000000000000010) x))))))
