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
(constraint (= (f #x79c583151dccecdc) #x0000000000000000))
(constraint (= (f #x145e6dd46e84741d) #x28bcdba8dd08e83a))
(constraint (= (f #xb87396e7d47b3cae) #x70e72dcfa8f6795c))
(constraint (= (f #xdd3bae7dce765576) #x0000000000000000))
(constraint (= (f #xc865922a66de88d1) #x90cb2454cdbd11a2))
(constraint (= (f #xe677bbc3e08b2ba5) #x000188c360830104))
(constraint (= (f #xb8174e198a4698dd) #x702e9c33148d31ba))
(constraint (= (f #x86a7a27c6e6485cc) #x0d4f44f8dcc90b98))
(constraint (= (f #x39028982d50c909a) #x0000000000000000))
(constraint (= (f #x5b7bec9e09e225ce) #xb6f7d93c13c44b9c))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000010 x) x) (bvadd x x) (bvand (bvlshr x #x000000000000000f) x)) (ite (= (bvor #x0000000000000010 x) x) #x0000000000000000 (bvadd x x))))
