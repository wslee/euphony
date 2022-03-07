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
(constraint (= (f #x9BD1231054C0FF91) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xAE2A4FD61CE7BC2C) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xAAF02C6786496620) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x58EF5A896289101C) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x60D1B7681667132D) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x0000000000000001) #x0000000000000003))
(constraint (= (f #xFFFFFFFFFFFFFFF8) #x0000000000000006))
(constraint (= (f #xFFFFFFFFFFFFFFF9) #x0000000000000007))
(constraint (= (f #xC7904787D555E5E6) #xCFB0CF8FFFFFEFEE))
(constraint (= (f #xEE86EFCC77BB91CA) #xFF8FFFDCFFFFB3DE))
(constraint (= (f #x76A3A8F0C689B94E) #xFFE7F9F1CF9BFBDE))
(constraint (= (f #x496098A743FDA7AB) #xDBE1B9EFC7FFEFFF))
(constraint (= (f #x35CD8BADBE3EDB1E) #x7FDF9FFFFE7FFF3E))
(constraint (= (f #xFFFFFFFFFFFFFFFB) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFFFFFA) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x219A5EB951273A10) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xFD71488239F74355) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #xFC00A5E3C337AC8C) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x48EA8603A18734D6) #xD9FF8E07E38F7DFE))
(constraint (= (f #x4EBD449EADA72DD6) #xDFFFCDBFFFEF7FFE))
(constraint (= (f #xC1E00841980FBD39) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x34F459A4C32D9E80) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xC35F7471F8795CE8) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x0776BA36C3A03BB1) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x1D74BE92152F2794) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x0000000000000001) #x0000000000000003))
(constraint (= (f #xFFFFFFFFFFFFFFF8) #x0000000000000006))
(constraint (= (f #xFFFFFFFFFFFFFFF9) #x0000000000000007))
(constraint (= (f #xFFFFFFFFFFFFFFFB) #xFFFFFFFFFFFFFFFF))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvnot #x0000000000000006) x) (bvnot (bvneg (bvand #x0000000000000008 x))) (ite (= (bvnot #x0000000000000007) x) #x0000000000000006 (ite (= #x0000000000000001 x) (bvor (bvadd x x) x) (ite (= (bvor #x0000000000000002 x) x) (bvor (bvadd x x) x) (bvor (bvnot #x0000000000000001) x))))))
