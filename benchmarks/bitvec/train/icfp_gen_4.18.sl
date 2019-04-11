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
(constraint (= (f #x8D7562436DC6150A) #x8DF776677FDE755A))
(constraint (= (f #x2A4F78BF6488C408) #x2AEFFFBFF6C8CC48))
(constraint (= (f #x6429893481440080) #x666B99B7C9544088))
(constraint (= (f #xCCB51FA88708942C) #xCCFF5FFA8F789D6E))
(constraint (= (f #xAB807E1C125CF136) #xABB87FFDD37DFF37))
(constraint (= (f #x100A6F6CDB359DEE) #x0000100A6F6CDB35))
(constraint (= (f #x679FA8710EDF8852) #x0000679FA8710EDF))
(constraint (= (f #x5217C446565F1E8D) #x00005217C446565F))
(constraint (= (f #x80549F730123544F) #x000080549F730123))
(constraint (= (f #x037DF15039F17906) #x0000037DF15039F1))
(constraint (= (f #x0000000000000001) #x0FFFFFFFFFFFFFFF))
(constraint (= (f #xAAAAAAAAAAAAAABD) #xAAAAAAAAAAAAAABF))
(constraint (= (f #xAAAAAAAAAAAAAAB0) #xAAAAAAAAAAAAAABB))
(constraint (= (f #xAAAAAAAAAAAAAABB) #xAAAAAAAAAAAAAABB))
(constraint (= (f #xAAAAAAAAAAAAAABE) #xAAAAAAAAAAAAAABF))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= #x0000000000000001 x) (bvudiv (bvnot x) #x0000000000000010) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvor #x0000000000000008 x) x) (bvor (bvudiv x #x0000000000000010) x) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000004 x) x) (bvor (bvudiv x #x0000000000000010) x) (bvlshr x #x0000000000000010)) (bvxor #x000000000000000b x))) (ite (= (bvor #x0000000000000006 x) x) (bvlshr x #x0000000000000010) (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (bvor (bvudiv x #x0000000000000010) x) (bvlshr x #x0000000000000010))))))
