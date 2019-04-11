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
(constraint (= (f #x78816e053d4a20ea) #x0000000000000001))
(constraint (= (f #xe788a27d860dbde8) #x0000000000000001))
(constraint (= (f #x76256d76c3e5d986) #x0000000000000001))
(constraint (= (f #x8ee5bd7343229e4e) #x0000000000000001))
(constraint (= (f #x92b25872224e4c64) #x0000000000000001))
(constraint (= (f #x71c02511615e82b7) #x0001c70094458578))
(constraint (= (f #x83b21aa78589590b) #x00020ec86a9e1624))
(constraint (= (f #xe044e7b5ea939aa8) #x0000000000000001))
(constraint (= (f #xa481a4a2889de652) #x0000000000000001))
(constraint (= (f #x2e1572e70432518a) #x0000000000000001))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000005 x) x) (bvxor (bvlshr x #x000000000000000e) #x0000000000000002) (bvnot (bvneg (bvlshr x #x000000000000000e)))) #x0000000000000001))
