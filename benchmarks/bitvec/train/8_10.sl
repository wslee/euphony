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
(constraint (= (f #x2963d0b107bb27a8) #x0a58f42c41eec9ea))
(constraint (= (f #xe46e1ea225c311ba) #x391b87a88970c46e))
(constraint (= (f #x068c92dda82cade4) #xfffffffffffffffe))
(constraint (= (f #x2461aa8e4eb06e58) #x09186aa393ac1b96))
(constraint (= (f #xc7cab4c50b4c26a3) #x0000000000000000))
(constraint (= (f #x2cc767751283b208) #x0b31d9dd44a0ec82))
(constraint (= (f #x6b044d2c4a769e58) #x1ac1134b129da796))
(constraint (= (f #xa4de59beeb52d8e8) #x2937966fbad4b63a))
(constraint (= (f #x1ee075b4a42c2509) #x0000000000000000))
(constraint (= (f #xde1d5e85ec587acc) #xfffffffffffffffe))
(check-synth)
