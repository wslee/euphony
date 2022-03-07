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
(constraint (= (f #x440421BD4C821120) #x4FC3DFA177B9F00C))
(constraint (= (f #xE1648654E02AFA3C) #xE34E3DEF92284A98))
(constraint (= (f #x811C39E4B025A464) #x890A764665234A1C))
(constraint (= (f #x7F4557F882A5087A) #x87510278FA7AB7F2))
(constraint (= (f #xD01E4D80FCB3D300) #xD31C68A8ECE895CE))
(constraint (= (f #xFFFFFFFFFFFFFFFE) #x1FFFFFFFFFFFFFFC))
(constraint (= (f #x0000000000000000) #x0FFFFFFFFFFFFFFE))
(constraint (= (f #xFFFF000000000002) #xFFFF100000000000))
(constraint (= (f #xA72F7D1BCAAE1701) #x04E5EFA37955C2E0))
(constraint (= (f #x2A2F25CC00FE9155) #x0545E4B9801FD22A))
(constraint (= (f #x5104C31E588D4DB9) #x0A209863CB11A9B7))
(constraint (= (f #xDB760C9E5AB2A351) #x0B6EC193CB56546A))
(constraint (= (f #x0D837613EE1E0DE1) #x01B06EC27DC3C1BC))
(check-synth)
