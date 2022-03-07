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
(constraint (= (f #x2ce5e9e10c73eb82) #x59cbd3c218e7d706))
(constraint (= (f #x3015e13ed4b39bed) #x381ff1bffefbdfff))
(constraint (= (f #xbbea49e80e8ecc1b) #xffff6dfc0fcfee1f))
(constraint (= (f #xa21d2edd9a4dca23) #xf31fbfffdf6fef33))
(constraint (= (f #x1d33b2c138183809) #x1fbbfbe1bc1c3c0d))
(constraint (= (f #x1ee568b71e6e09ce) #x3dcad16e3cdc139e))
(constraint (= (f #xe5d593db27461e9b) #xf7ffdbffb7e71fdf))
(constraint (= (f #x17d381ec01aea3e3) #x1ffbc1fe01fff3f3))
(constraint (= (f #x88ce7dc6ce9c3e79) #xccef7fe7efde3f7d))
(constraint (= (f #xa37e551c66670005) #xf3ff7f9e77778007))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvor (bvudiv x #x0000000000000002) x) (bvxor (bvadd x x) #x0000000000000002)))
