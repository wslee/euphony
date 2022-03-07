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
(constraint (= (f #xc9ee82786e38ab9b) #x0000000000000001))
(constraint (= (f #xec48302e13b292b2) #x0000000000000000))
(constraint (= (f #x1d32eba06b25743b) #x000062cd145f94da))
(constraint (= (f #x69ce62c63901eee7) #x000016319d39c6fe))
(constraint (= (f #xc41d69980db9b5e7) #x0000000000000001))
(constraint (= (f #xc0893d72064152eb) #x00003f76c28df9be))
(constraint (= (f #x6be4882a16a811e9) #x0000141b77d5e957))
(constraint (= (f #xdb82eaee1d5e72ec) #x0000000000000000))
(constraint (= (f #x67026ed6e353be18) #x0000000000000000))
(constraint (= (f #xca31ce8ccc4b7ba8) #x00007fffffffffff))
(check-synth)
