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
(constraint (= (f #x63bbe0e3ee9b44d9) #x9c441f1c1164bb27))
(constraint (= (f #x6113ba335eca362c) #x6113ba335eca362c))
(constraint (= (f #xd5e47b36e4ee7066) #xd5e47b36e4ee7066))
(constraint (= (f #xea8e5aee9ee367b5) #x1571a511611c984b))
(constraint (= (f #x0913e7e316e61ebd) #x0913e7e316e61ebc))
(constraint (= (f #x4a7acedede5c3d3e) #x4a7acedede5c3d3e))
(constraint (= (f #xa0eee1c1d71405c4) #xa0eee1c1d71405c4))
(constraint (= (f #x9ecce41707cd67a0) #x61331be8f832985e))
(constraint (= (f #x6437aed38086ec86) #x6437aed38086ec86))
(constraint (= (f #xdbc0b1e3bb84cebc) #xdbc0b1e3bb84cebc))
(check-synth)
