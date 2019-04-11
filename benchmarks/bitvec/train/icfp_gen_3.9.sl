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
(constraint (= (f #x791B53536ECC2863) #x0000791B53536ECC))
(constraint (= (f #xB02E4A2562D1BD97) #x0000B02E4A2562D1))
(constraint (= (f #x988BFDC934FD06E7) #x0000988BFDC934FD))
(constraint (= (f #x0106CA91EDF41B0F) #x00000106CA91EDF4))
(constraint (= (f #xEA2BDC6771886C1B) #x0000EA2BDC677188))
(constraint (= (f #x57BB5EC3685ED6EC) #xAF76BD86D0BDADDA))
(constraint (= (f #x23AA9C05F3C983B0) #x4755380BE7930762))
(constraint (= (f #xE6E39142A71476BC) #xCDC722854E28ED7A))
(constraint (= (f #x4A821E0314573598) #x95043C0628AE6B32))
(constraint (= (f #x2C7432F86008D8BE) #x58E865F0C011B17E))
(constraint (= (f #x6EE1A4104E258854) #xDDC348209C4B10AA))
(constraint (= (f #x80B44C89EC779989) #x000080B44C89EC77))
(constraint (= (f #x6856F787DA7A35C1) #x00006856F787DA7A))
(constraint (= (f #xEE0D6F7DB5B8CEF4) #xDC1ADEFB6B719DEA))
(constraint (= (f #xD83B6CAAB9625988) #xB076D95572C4B312))
(constraint (= (f #x8F45655D35F7C1D2) #x1E8ACABA6BEF83A6))
(constraint (= (f #x6E72933DE6549FE4) #xDCE5267BCCA93FCA))
(constraint (= (f #xC7BFE18985771888) #x8F7FC3130AEE3112))
(constraint (= (f #xA0BC3E993B73DC6A) #x41787D3276E7B8D6))
(constraint (= (f #x82BD82915050DA40) #x057B0522A0A1B482))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvlshr x #x0000000000000010) (bvxor (bvadd x x) #x0000000000000002)))
