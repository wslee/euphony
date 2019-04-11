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
(constraint (= (f #xB55271875DFBC690) #x00004AAD8E78A204))
(constraint (= (f #x468B94F804B3F133) #x0000B9746B07FB4C))
(constraint (= (f #x1BA3BE78A3EB5693) #x0000E45C41875C14))
(constraint (= (f #x0541457A7E36563F) #x0000FABEBA8581C9))
(constraint (= (f #x0451415C6A7507B3) #x0000FBAEBEA3958A))
(constraint (= (f #x72A7A84040ADFCFB) #x654F5080815BF9F6))
(constraint (= (f #x403D20461035C733) #x007A408C206B8E66))
(constraint (= (f #xCB29D8243126CA57) #x1653B048624D94AE))
(constraint (= (f #x7B244000803892FB) #x76488001007125F6))
(constraint (= (f #x48CCB11098621839) #x1199622130C43072))
(constraint (= (f #xB9729788431F728E) #x72E52F10863EE51C))
(constraint (= (f #xF662DA4E8700D5A0) #x6CC5B49D0E01AB40))
(constraint (= (f #x8A90E42D99FD7C81) #x1521C85B33FAF902))
(constraint (= (f #x6AF7E917DBE8F2C9) #x55EFD22FB7D1E592))
(constraint (= (f #x8285210FEE61152D) #x050A421FDCC22A5A))
(constraint (= (f #xC319B9231034662B) #x063372462068CC56))
(constraint (= (f #x27B2C802693764A3) #x4F659004D26EC946))
(constraint (= (f #x44704980442019CB) #x08E0930088403396))
(constraint (= (f #x5A20280C76BD9C03) #x34405018ED7B3806))
(constraint (= (f #xDC5611084632254F) #x38AC22108C644A9E))
(constraint (= (f #xF000000000000001) #x6000000000000002))
(constraint (= (f #x0000000000000003) #x0000000000000002))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (not (= #x0000000000000003 x)) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvurem x #x000000000000000d) #x0000000000000000) (bvudiv (bvmul #x0000000000000004 x) #x0000000000000002) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvlshr (bvnot x) #x0000000000000010) (ite (= (bvand #x0000000000000008 x) #x0000000000000000) (ite (= (bvor #x0000000000000004 x) x) (bvudiv (bvmul #x0000000000000004 x) #x0000000000000002) (bvlshr (bvnot x) #x0000000000000010)) (bvudiv (bvmul #x0000000000000004 x) #x0000000000000002))) (bvudiv (bvmul #x0000000000000004 x) #x0000000000000002))) (bvnot (bvashr x #x0000000000000010))) (bvudiv (bvmul #x0000000000000004 x) #x0000000000000002)) #x0000000000000002))
