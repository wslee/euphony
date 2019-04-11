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
(constraint (= (f #x36AF3C0669CD72D0) #x36AF3C0669CD72D1))
(constraint (= (f #x59DE552D8888D9BA) #x59DE552D8888D9BB))
(constraint (= (f #x19738855B999764A) #x19738855B999764B))
(constraint (= (f #x05739610CD6CB2AA) #x05739610CD6CB2AB))
(constraint (= (f #x41861401BF6B4020) #x41861401BF6B4021))
(constraint (= (f #xF0F0F0F0F0F0F0F2) #xF0F0F0F0F0F0F0F3))
(constraint (= (f #x0000000000000001) #x0000000000000002))
(constraint (= (f #x2044759E965BD886) #x00004088EB3D2CB7))
(constraint (= (f #xFBB9B358D2A99215) #x0000F77366B1A553))
(constraint (= (f #xBEB31E8F6D552F54) #x00007D663D1EDAAA))
(constraint (= (f #xBF422C9EB8CA8F44) #x00007E84593D7195))
(constraint (= (f #xB1980F847AE75314) #x000063301F08F5CE))
(constraint (= (f #xFFFF80003FFFDFFF) #x0000FFFF00007FFF))
(constraint (= (f #x44A629B392B496A2) #x44A629B392B496A3))
(constraint (= (f #x64436DF2B74B05D6) #x0000C886DBE56E96))
(constraint (= (f #xA93287998DF65EB8) #xA93287998DF65EB9))
(constraint (= (f #x41F47859EB5E8515) #x000083E8F0B3D6BD))
(constraint (= (f #x5AFD775260806086) #x0000B5FAEEA4C100))
(constraint (= (f #xDE622B2191F7D7F5) #x0000BCC4564323EF))
(constraint (= (f #x50DC656DA28DEAB1) #x50DC656DA28DEAB2))
(constraint (= (f #xA0C233B01AA9C790) #xA0C233B01AA9C791))
(constraint (= (f #x05810D19555930D0) #x05810D19555930D1))
(constraint (= (f #x24096AB12338815A) #x24096AB12338815B))
(constraint (= (f #xFFFF80003FFFDFFF) #x0000FFFF00007FFF))
(constraint (= (f #x60550F2738AAAEB3) #x60550F2738AAAEB4))
(constraint (= (f #xD174B2B89A366473) #xD174B2B89A366474))
(constraint (= (f #xAF7B5864456B1B73) #xAF7B5864456B1B74))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000004 x) x) (bvlshr (bvadd x x) #x0000000000000010) (bvneg (bvnot x))))
