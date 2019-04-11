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
(constraint (= (f #x541a486debee6ee3) #x0000541a486debee))
(constraint (= (f #xe5be55a30ebc7880) #xe5be55a30ebc7882))
(constraint (= (f #x322473791e191dbc) #x0000322473791e19))
(constraint (= (f #xe735725aee3eebeb) #x0000e735725aee3e))
(constraint (= (f #x83bbebe9e88e3257) #x000083bbebe9e88e))
(constraint (= (f #x9dcebed0204c4146) #x9dcebed0204c4148))
(constraint (= (f #x1bb3c7716677ae6c) #x00001bb3c7716677))
(constraint (= (f #xa955e45a3c83cbca) #x0000a955e45a3c83))
(constraint (= (f #x27762c119e3ae5ad) #x000027762c119e3a))
(constraint (= (f #xc49e108cb38623b0) #xc49e108cb38623b2))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000004 x) x) (ite (= (bvor #x0000000000000001 x) x) (bvlshr x #x0000000000000010) (bvxor #x000000000000000e x)) (bvlshr x #x0000000000000010)) (ite (= (bvor #x0000000000000004 x) x) (bvlshr x #x0000000000000010) (bvxor #x0000000000000002 x))))
