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
(constraint (= (f #xe2e78ca6c693d53c) #xff0c083108182400))
(constraint (= (f #xa961935eabbcccec) #xff020e2400000111))
(constraint (= (f #x3d552067e8a06422) #xffc0004f88030f89))
(constraint (= (f #x191dc16e409ee219) #x191dc16e409ee218))
(constraint (= (f #x74e350718010b838) #xff810c07863fe703))
(constraint (= (f #xe54353ded7589e49) #xe54353ded7589e48))
(constraint (= (f #x707e929eec94501d) #x707e929eec94501c))
(constraint (= (f #x51ede1b7dc676592) #xff86000e00018808))
(constraint (= (f #xe7e714224941e0e4) #xff080861cc921e0f))
(constraint (= (f #x1d149620a81046b3) #x1d149620a81046b2))
(check-synth)
