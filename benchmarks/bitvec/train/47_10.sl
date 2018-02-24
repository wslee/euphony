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
(constraint (= (f #x2ace6154c9d65db4) #x559cc2a993acbb69))
(constraint (= (f #xddc2726b7eabe005) #xddc2726b7eabe001))
(constraint (= (f #x8a4b66e6de3de165) #x1496cdcdbc7bc2cb))
(constraint (= (f #x5e61087b2954178d) #x5e61087b29541789))
(constraint (= (f #x3e9520ed2bd2b515) #x3e9520ed2bd2b511))
(constraint (= (f #x678d3e83d88b258e) #x678d3e83d88b258a))
(constraint (= (f #x494964c29dec25a9) #x9292c9853bd84b53))
(constraint (= (f #xa340aede7d209a66) #x46815dbcfa4134cd))
(constraint (= (f #x5a611e3e2e855bed) #xb4c23c7c5d0ab7db))
(constraint (= (f #x17266a760c37e395) #x17266a760c37e391))
(check-synth)
