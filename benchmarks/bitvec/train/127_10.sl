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
(constraint (= (f #xe2aad860ccbeb9ec) #xe2aad860ccbeb9ee))
(constraint (= (f #xe85a01a9ee3b3b2b) #x0000000000000000))
(constraint (= (f #x1c3404d442e676c8) #x1c3404d442e676ca))
(constraint (= (f #x16820d5bb4a612b6) #x0000000000000000))
(constraint (= (f #x25987358e5a5c622) #x0000000000000000))
(constraint (= (f #xeb8ede4b3deb2046) #x0000000000000000))
(constraint (= (f #x1292b5490e1ccb77) #x0000000000000000))
(constraint (= (f #xe5d0e653830b8855) #xe5d0e653830b8857))
(constraint (= (f #x8be246981e2267a6) #x0000000000000000))
(constraint (= (f #x76a70d5360aa01b5) #x76a70d5360aa01b7))
(check-synth)
