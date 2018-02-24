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
(constraint (= (f #x92123e7041ee43c1) #x0000000000000002))
(constraint (= (f #x4de85d23756a544a) #x0000000000000000))
(constraint (= (f #xa329341be562e976) #x0000000000000000))
(constraint (= (f #xd39ed8e49b6a7347) #x0000000000000002))
(constraint (= (f #x185a8aea12a9325d) #xd71060c1c804a918))
(constraint (= (f #xe6925aed00be61e6) #x0000000000000000))
(constraint (= (f #x84e4e1e7380e629e) #x0000000000000000))
(constraint (= (f #x92845de481d2c029) #x0000000000000002))
(constraint (= (f #xdd57e5639d8853a5) #x0000000000000002))
(constraint (= (f #x7e326765d326718e) #x0000000000000000))
(check-synth)
