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
(constraint (= (f #xcb811430e70a8385) #xcfb91573ef7aabbd))
(constraint (= (f #x0740ec3ae90051e7) #x0774eefbef9055ff))
(constraint (= (f #x1eb87952ba16c7eb) #x1ffbffd7bbb7efff))
(constraint (= (f #x737e3745835cbe2a) #x777ff775db7dffea))
(constraint (= (f #x695a65ab504578e1) #x0000695a65ab5045))
(constraint (= (f #x5c04be5bb9ed2840) #x00005c04be5bb9ed))
(constraint (= (f #x3579b1b1ebb2ba1a) #x377fbbbbffbbbbbb))
(constraint (= (f #x3524d1be542199e7) #x00003524d1be5421))
(constraint (= (f #x1a740959ad3b0b47) #x00001a740959ad3b))
(constraint (= (f #xb29abad0be12dc2e) #xbbbbbbfdbff3fdee))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000006 x) #x0000000000000000) (bvlshr x #x0000000000000010) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvor (bvudiv x #x0000000000000010) x) (ite (= (bvand #x0000000000000008 x) #x0000000000000000) (bvlshr x #x0000000000000010) (bvor (bvudiv x #x0000000000000010) x)))))
