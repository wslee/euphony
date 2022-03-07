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
(constraint (= (f #xb321e2bcb5d4ce60) #x6643c5796ba99cc0))
(constraint (= (f #x48776ed52a38663a) #x90eeddaa5470cc74))
(constraint (= (f #xe0642c2e018e40e4) #xc0c8585c031c81c8))
(constraint (= (f #xe7ea80d80b2ea9ee) #xcfd501b0165d53dc))
(constraint (= (f #xe82de1215d08cc8e) #xd05bc242ba11991c))
(constraint (= (f #xd03e8a11d2a7a889) #x681f4508e953d444))
(constraint (= (f #xbec219398a108952) #x7d843273142112a4))
(constraint (= (f #x849702c9ee9a767b) #x0000000000000000))
(constraint (= (f #x826ec5c883d48b71) #x0000000000000000))
(constraint (= (f #x5503401395759099) #x2a81a009cabac84c))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000003 x) x) #x0000000000000000 (ite (= (bvor #x0000000000000008 x) x) (bvudiv x #x0000000000000002) #x0000000000000000)) (bvadd x x)))
