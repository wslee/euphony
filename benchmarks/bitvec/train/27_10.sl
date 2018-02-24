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
(constraint (= (f #x032d792de0ae3224) #x032d792de0ae3225))
(constraint (= (f #x531e454c79e076ea) #x531e454c79e076eb))
(constraint (= (f #x6eeba4be14e0da51) #x6eeba4be14e0da53))
(constraint (= (f #x1e6697219164c3de) #x1e6697219164c3df))
(constraint (= (f #x90d602c2245aad30) #x90d602c2245aad31))
(constraint (= (f #xc62be2c5eb598b9d) #xc62be2c5eb598b9f))
(constraint (= (f #xa529c9558cd346c8) #xa529c9558cd346c9))
(constraint (= (f #x5d0119506e6ed842) #x5d0119506e6ed843))
(constraint (= (f #x0da86818c4268984) #x0da86818c4268985))
(constraint (= (f #x8510a5bdb8912bd8) #x8510a5bdb8912bd9))
(check-synth)
