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
(constraint (= (f #x9838c02283e8a235) #x9838c02283e8a235))
(constraint (= (f #xbea5b19521dee588) #x0000000000000001))
(constraint (= (f #xba010ecd01a176eb) #xba010ecd01a176eb))
(constraint (= (f #x2d51e856b031ca52) #x0000000000000001))
(constraint (= (f #x409d73e061a4c778) #x409d77ea38e2cd92))
(constraint (= (f #xe723ee480a2e98b3) #x0000000000000000))
(constraint (= (f #x6428aebe501e7ad4) #x6428b500db0a5fd5))
(constraint (= (f #x6b715d4c4ede7816) #x0000000000000001))
(constraint (= (f #x1ea0ac3ca7b9b74a) #x1ea0ae26b27d81c5))
(constraint (= (f #xd6bb7b0a79dd39e6) #xd6bb8876318de183))
(check-synth)
