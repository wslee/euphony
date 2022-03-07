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
(constraint (= (f #xd5a6481ee2ba1030) #xfffffffffffffffe))
(constraint (= (f #x03e887e72dee55cd) #x03e887e72dee55cd))
(constraint (= (f #xaced92921c8e318d) #xaced92921c8e318d))
(constraint (= (f #x95e5e4184e40aaec) #xfffffffffffffffe))
(constraint (= (f #x352367e34d76550b) #x352367e34d76550b))
(constraint (= (f #x398560eeee7b1b6c) #xfffffffffffffffe))
(constraint (= (f #x099be4899986c29a) #xfffffffffffffffe))
(constraint (= (f #xb14b75be2e13445a) #xfffffffffffffffe))
(constraint (= (f #xb4c680ad7e6b16ce) #xfffffffffffffffe))
(constraint (= (f #x7e4954872868acb8) #xfffffffffffffffe))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) x (bvnot #x0000000000000001)))
