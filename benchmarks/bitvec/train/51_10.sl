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
(constraint (= (f #xe9770aa10cacb30c) #xe9770aa10cacb30e))
(constraint (= (f #x1c14b64e2717423e) #x1c14b64e2717423c))
(constraint (= (f #xd123e2eaed9b2040) #xd123e2eaed9b2042))
(constraint (= (f #x6bb2782a4cb648ba) #x6bb2782a4cb648b8))
(constraint (= (f #xe6a8adcd2a0515d6) #xe6a8adcd2a0515d4))
(constraint (= (f #x0ada9e34c6e7938d) #xf52561cb39186c72))
(constraint (= (f #xb93e327e6dcd693d) #x46c1cd81923296c2))
(constraint (= (f #xc8293b7147e394ce) #xc8293b7147e394cc))
(constraint (= (f #x9a778869ee82e19c) #x9a778869ee82e19e))
(constraint (= (f #xacc924e82ea4eec5) #x5336db17d15b113a))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvnot x) (bvxor #x0000000000000002 x)))
