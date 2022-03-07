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
(constraint (= (f #x78c97a78c9a86653) #xf192f4f19350cca7))
(constraint (= (f #x9e8969bd7e39ee48) #x3d12d37afc73dc91))
(constraint (= (f #xa5e016e1056e1dca) #x4bc02dc20adc3b95))
(constraint (= (f #x7799082a428aa965) #xef321054851552cb))
(constraint (= (f #xd85172bd9beb73c7) #xb0a2e57b37d6e78f))
(constraint (= (f #x7ea8541d9c2ab554) #xfd50a83b38556aa9))
(constraint (= (f #x36bbc8b1a6050ec2) #x6d7791634c0a1d85))
(constraint (= (f #x05e67429c1dc893e) #x0bcce85383b9127d))
(constraint (= (f #x7a22c90ed54aab68) #xf445921daa9556d1))
(constraint (= (f #xa16d9de778940d13) #x42db3bcef1281a27))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (bvsub x (bvnot x)))
