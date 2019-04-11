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
(constraint (= (f #x09b006eeb2e88a19) #x09b006eeb2e88a1b))
(constraint (= (f #x157ddd888346b7d7) #x157ddd888346b7d9))
(constraint (= (f #xdea83587e06667e6) #xfffe42af94f03f32))
(constraint (= (f #xee090693a3d29a1a) #xfffe23edf2d8b85a))
(constraint (= (f #x2458e49e31e34a65) #xffffb74e36c39c38))
(constraint (= (f #x02ac3ce11e610b3b) #xfffffaa7863dc33c))
(constraint (= (f #xe0ca6a8281e5b0ba) #xe0ca6a8281e5b0ba))
(constraint (= (f #xa45cee2ea020157d) #xa45cee2ea020157f))
(constraint (= (f #x1a7d765be85d44c0) #x1a7d765be85d44c0))
(constraint (= (f #xa1ae39945e9ee100) #xfffebca38cd742c2))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000006 x) x) (bvxor #x000000000000000e x) (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (ite (= (bvand #x000000000000000a x) #x0000000000000000) (bvnot (bvxor (bvlshr x #x000000000000000f) #x0000000000000001)) (bvxor #x0000000000000002 x)) (bvnot (bvxor (bvlshr x #x000000000000000f) #x0000000000000001)))) (ite (= (bvor #x0000000000000004 x) x) (bvnot (bvxor (bvlshr x #x000000000000000f) #x0000000000000001)) (ite (= (bvurem x #x0000000000000007) #x0000000000000000) (bvnot (bvlshr x #x000000000000000f)) (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) x (bvnot (bvlshr x #x000000000000000f))) x)))))
