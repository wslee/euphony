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
(constraint (= (f #x31b89a6e3356b240) #xcb2bdbeae973e29b))
(constraint (= (f #xc192ea128ad82dd6) #xc192ea128ad82dd6))
(constraint (= (f #xe7a658ee0e27e583) #x09df418310f59c24))
(constraint (= (f #xee201d97438486a5) #xee201d97438486a4))
(constraint (= (f #xa85b91667db28e15) #x4d1eb5831a724909))
(constraint (= (f #xaa7321ab163764bd) #x4ae5ac3a386524f7))
(constraint (= (f #xdaebb8b1bbedeeec) #xdaebb8b1bbedeeec))
(constraint (= (f #x38a50903364a8d82) #xc3d0a66c9650c9a5))
(constraint (= (f #xeee47814c1d81989) #xeee47814c1d81988))
(constraint (= (f #xe06e034804a598cd) #xe06e034804a598cc))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000010 x) x) (bvnot (bvadd (bvudiv x #x0000000000000010) x)) (ite (= (bvor #x0000000000000003 x) x) (bvnot (bvadd (bvudiv x #x0000000000000010) x)) (bvnot (bvneg x)))) (ite (= (bvor #x0000000000000004 x) x) x (bvnot (bvadd (bvudiv x #x0000000000000010) x)))))
