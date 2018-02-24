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
(constraint (= (f #xdeb381c72cbc89c2) #xfffff214c7e38d34))
(constraint (= (f #x1daae07b7ad8ce3c) #xfffffe2551f84852))
(constraint (= (f #x3808341e47ede38e) #xfffffc7f7cbe1b81))
(constraint (= (f #x218949588221e8c5) #x0000000000000002))
(constraint (= (f #x5c472b66076ebde3) #x0000000000000002))
(constraint (= (f #x2395e7e10a51a8d3) #x0000000000000002))
(constraint (= (f #x5b4e6bb40dee30ed) #x0000000000000002))
(constraint (= (f #x88ede962bb9583b4) #xfffff7712169d446))
(constraint (= (f #xeb343ee1e896e112) #xfffff14cbc11e176))
(constraint (= (f #x2e60e3eee22cd9e9) #x0000000000000002))
(check-synth)
