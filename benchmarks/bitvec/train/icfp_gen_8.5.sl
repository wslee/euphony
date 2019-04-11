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
(constraint (= (f #xC759A27CA4545C9A) #x4759A27CA4545C9A))
(constraint (= (f #x1DF6680C7B1045BA) #x1DF6680C7B1045BA))
(constraint (= (f #xE0925B3653B0EA52) #x60925B3653B0EA52))
(constraint (= (f #xECCD2BAB435FE898) #x6CCD2BAB435FE898))
(constraint (= (f #x394A560305BC7C0E) #x394A560305BC7C0E))
(constraint (= (f #x7092DC36C543070A) #x7092DC36C543070A))
(constraint (= (f #x1D5D6587E826D812) #x1D5D6587E826D812))
(constraint (= (f #x7A3A194E03ABA1DA) #x7A3A194E03ABA1DA))
(constraint (= (f #x4500D17E7526FAEE) #x4500D17E7526FAEE))
(constraint (= (f #x8FFEB55F6886B650) #x0FFEB55F6886B650))
(constraint (= (f #x444C93273AB069F3) #x8899264E7560D3E6))
(constraint (= (f #x173080383836C053) #x2E610070706D80A6))
(constraint (= (f #x55EF1928A0F04A55) #xABDE325141E094AA))
(constraint (= (f #xB180BD02B49BD8D1) #x63017A056937B1A2))
(constraint (= (f #x5688C0258D95AF81) #xAD11804B1B2B5F02))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #x0D07B3FE9AE68E23) #x0D07B3FE9AE68E23))
(constraint (= (f #x497093A34348500F) #x497093A34348500F))
(constraint (= (f #x3059045A0FCA170D) #x3059045A0FCA170D))
(constraint (= (f #xBA215BAF6A0EF18F) #x3A215BAF6A0EF18F))
(constraint (= (f #xC1A86766FEA8C31D) #x41A86766FEA8C31D))
(constraint (= (f #xBE6AF6A502146C5E) #x3E6AF6A502146C5E))
(constraint (= (f #x89D400D5A0C15D9E) #x09D400D5A0C15D9E))
(constraint (= (f #x92B1101CF328F414) #x12B1101CF328F414))
(constraint (= (f #x259C1D1CD7B540E6) #x259C1D1CD7B540E6))
(constraint (= (f #xED71935F7740564B) #x6D71935F7740564B))
(constraint (= (f #x2542026A5861CD87) #x2542026A5861CD87))
(constraint (= (f #x962AD76495E45769) #x162AD76495E45769))
(constraint (= (f #xF6B323E42BB3DFBF) #xED6647C85767BF7E))
(constraint (= (f #x7D7113D202061300) #x7D7113D202061300))
(constraint (= (f #x6B97301B45A6F2D6) #x6B97301B45A6F2D6))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #x7F64E1D4D31D6241) #xFEC9C3A9A63AC482))
(constraint (= (f #x8362DA0F56E5E8BB) #x0362DA0F56E5E8BB))
(constraint (= (f #x07D824451F838489) #x07D824451F838489))
(constraint (= (f #xE3B8E26DFD015C55) #x63B8E26DFD015C55))
(constraint (= (f #x25ADD9DD6C98988B) #x4B5BB3BAD9313116))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvand #x000000000000000e x) #x0000000000000000) (bvadd x x) (ite (= (bvand #x0000000000000006 x) #x0000000000000000) (bvudiv (bvadd x x) #x0000000000000002) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvand #x000000000000000c x) #x0000000000000000) (bvadd x x) (ite (= (bvor #x0000000000000006 x) x) (bvadd x x) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (ite (= (bvand #x0000000000000008 x) #x0000000000000000) (bvadd x x) (bvudiv (bvadd x x) #x0000000000000002)) (bvudiv (bvadd x x) #x0000000000000002)))) (ite (= (bvor #x000000000000000b x) x) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvudiv (bvadd x x) #x0000000000000002) (ite (= (bvor #x0000000000000006 x) x) (bvudiv (bvadd x x) #x0000000000000002) (bvadd x x))) x)))) (bvudiv (bvadd x x) #x0000000000000002)))
