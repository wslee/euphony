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
(constraint (= (f #x58703d430d67a0a3) #x0950b7c92836e1e9))
(constraint (= (f #x3de45654801b9c2e) #x03de45654801b9c2))
(constraint (= (f #xb44144144b24522b) #x1cc3cc3ce16cf681))
(constraint (= (f #x3b17e28895aeb19e) #x03b17e28895aeb18))
(constraint (= (f #xeb3131b22abb4257) #xc19395168031c705))
(constraint (= (f #x6ce21b13a02eba79) #x46a6513ae08c2f6b))
(constraint (= (f #x2db0458a6a069eed) #x8910d09f3e13dcc7))
(constraint (= (f #x458a9c54bcd143c5) #xd09fd4fe3673cb4f))
(constraint (= (f #x74ae46a61c9d85e7) #x5e0ad3f255d891b5))
(constraint (= (f #x10335e027857a12e) #x010335e027857a12))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvmul #x0000000000000003 x) (ite (= (bvor #x0000000000000010 x) x) (bvnot (bvneg (bvudiv x #x0000000000000010))) (bvudiv x #x0000000000000010))))
