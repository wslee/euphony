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
(constraint (= (f #x00983eba6e3050dd) #x0000000000000000))
(constraint (= (f #xce7b84b2369ed225) #x0000843204921204))
(constraint (= (f #x84a7d40166cb42de) #x0000000000000000))
(constraint (= (f #x4d5705a9239673e5) #x0000050101802384))
(constraint (= (f #xaa373e0beb2dde83) #x00002a032a09ca01))
(constraint (= (f #xe36141cb84a2c164) #x000071b0a0e5c251))
(constraint (= (f #x5e673d99deb8e6da) #x0000000000000000))
(constraint (= (f #x76e02ceec77e4d40) #x000024e0046e4540))
(constraint (= (f #x051ae67e0d4ce044) #x0000041a044c0044))
(constraint (= (f #xebbb66266593389b) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000008 x) x) #x0000000000000000 (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (bvudiv (bvlshr x #x0000000000000010) #x0000000000000002) (bvand (bvlshr x #x0000000000000010) x)) (bvand (bvlshr x #x0000000000000010) x))))
