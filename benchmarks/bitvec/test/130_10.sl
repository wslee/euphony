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
(constraint (= (f #x64696e76c5588442) #x64696e76c5588444))
(constraint (= (f #x0bc43a44e7d4533c) #x0000f43bc5bb182c))
(constraint (= (f #x29e61e9e6d51300a) #x29e61e9e6d51300c))
(constraint (= (f #xaa3e30ee79d2945a) #xaa3e30ee79d2945c))
(constraint (= (f #xc27b0bd99b52ba3c) #x00003d84f42664ae))
(constraint (= (f #x8cdd161e33b71ee4) #x00007322e9e1cc49))
(constraint (= (f #x114cc9a56332b3dd) #x0001000000000000))
(constraint (= (f #xc23dee6ce4d1ee12) #xc23dee6ce4d1ee14))
(constraint (= (f #x416ec37e51d9a5ae) #x416ec37e51d9a5b0))
(constraint (= (f #xac5a4153684d624b) #x0000000000000002))
(check-synth)
