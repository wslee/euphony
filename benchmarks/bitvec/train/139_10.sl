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
(constraint (= (f #x6d1e607710691396) #xda3cc0ee20d2272e))
(constraint (= (f #x675aecbae08b4a14) #xceb5d975c116942a))
(constraint (= (f #xbe0160eb542aa373) #xbe0160eb542aa373))
(constraint (= (f #x253ac2ea42e1a49e) #x4a7585d485c3493e))
(constraint (= (f #x4238c39857ad3006) #x84718730af5a600e))
(constraint (= (f #x6cb09733ce90d037) #x6cb09733ce90d037))
(constraint (= (f #xac3c44aa716920ee) #x58788954e2d241de))
(constraint (= (f #x98ec5d22bd30b4d2) #x31d8ba457a6169a6))
(constraint (= (f #xbc4955e77a7eb8b6) #x7892abcef4fd716e))
(constraint (= (f #x993eee07446e8a7e) #x327ddc0e88dd14fe))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) x (bvxor (bvadd x x) #x0000000000000002)))
