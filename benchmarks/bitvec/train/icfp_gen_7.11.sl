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
(constraint (= (f #x09EE2CC0649C2A23) #x09EE2CC0649C2A22))
(constraint (= (f #x40A8B1E6834857D7) #x40A8B1E6834857D6))
(constraint (= (f #xA60EB9B05B70E406) #xA60EB9B05B70E407))
(constraint (= (f #x0B5722B550220243) #x0B5722B550220242))
(constraint (= (f #x909B5BEE2EF64881) #x909B5BEE2EF64880))
(constraint (= (f #x0000000000C45C04) #x0000000000C45C05))
(constraint (= (f #x00000000007CFD28) #x00000000007CFD29))
(constraint (= (f #x00000000009EE90C) #x00000000009EE90D))
(constraint (= (f #x00000000007A4C7D) #x00000000007A4C7C))
(constraint (= (f #x0000000000D44850) #x0000000000D44851))
(constraint (= (f #x29B9DA2B04892D7B) #x06B2312EA7DBB694))
(constraint (= (f #x6117E56D91312182) #x04F740D4937676F3))
(constraint (= (f #x5292C0F2335BA0C8) #x056B69F86E6522F9))
(constraint (= (f #xAACCDAC37619BD7A) #x02A99929E44F3214))
(constraint (= (f #xEDAE97B7B7D79DD0) #x00928B4242414311))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #x0000000000C36726) #x0000000000C36727))
(constraint (= (f #x0000000000DFC732) #x0000000000DFC733))
(constraint (= (f #x0000000000C5BDE3) #x0000000000C5BDE2))
(constraint (= (f #x0000000000BDB1AF) #x0000000000BDB1AE))
(constraint (= (f #x0000000000CF80D5) #x0000000000CF80D4))
(constraint (= (f #xFFFFFFFFFFFF8378) #x07FFFFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFF283A) #x07FFFFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFF1CB8) #x07FFFFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFFC0E9) #x07FFFFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFF6ADE) #x07FFFFFFFFFFFFFF))
(constraint (= (f #xFFFF0000FFFF0002) #x000007FFF80007FF))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000009 x) #x0000000000000001) (bvnot (bvneg x)) (ite (= (bvashr x x) #x0000000000000000) (ite (= (bvor #x0000000000000004 x) x) (bvxor #x0000000000000001 x) (ite (= (bvor #x000000000000000a x) x) (bvlshr (bvnot x) #x0000000000000005) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (ite (= (bvand #x000000000000000c x) #x0000000000000000) (bvlshr (bvnot x) #x0000000000000005) (ite (= (bvurem x #x0000000000000007) #x0000000000000001) (bvlshr (bvnot x) #x0000000000000005) (bvxor #x0000000000000001 x))) (bvxor #x0000000000000001 x)))) (ite (= (bvand #x000000000000000c x) #x0000000000000000) (bvnot (bvashr x #x0000000000000005)) (ite (= (bvor #x0000000000000008 x) x) (ite (= (bvurem x #x0000000000000005) #x0000000000000001) (ite (= (bvor #x000000000000000a x) x) (bvnot (bvashr x #x0000000000000005)) (bvlshr (bvnot #x0000000000000000) #x0000000000000005)) (bvlshr (bvnot #x0000000000000000) #x0000000000000005)) (bvxor #x0000000000000001 x))))))
