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
(constraint (= (f #x2e6535c581a8392a) #x2e6535c581a8392a))
(constraint (= (f #xa153d2ee3ed0ce5d) #xa153d2ee3ed0ce5f))
(constraint (= (f #x802ca6c48dad2e26) #x802ca6c48dad2e26))
(constraint (= (f #xe724ed68de88bead) #xe724ed68de88beaf))
(constraint (= (f #x29d1733e35663b5e) #x29d1733e35663b5e))
(constraint (= (f #x45c8ec3283143ebb) #x45c8ec3283143ebb))
(constraint (= (f #x214938924a27324d) #x214938924a27324f))
(constraint (= (f #x895e15ace4700348) #x895e15ace4700348))
(constraint (= (f #xa110d71639987076) #xa110d71639987076))
(constraint (= (f #xa0b469693dd6ad2d) #xa0b469693dd6ad2f))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000003 x) x) x (bvxor #x0000000000000002 x)) x))
