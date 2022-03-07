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
(constraint (= (f #xbc9b36c3d3a6d7ae) #x0c5ad5b4474eb78f))
(constraint (= (f #x618e7d2b3028b505) #x0a292877d5079df0))
(constraint (= (f #xb2b31021e72b4583) #xb2b31021e72b4584))
(constraint (= (f #x903339ca8258b7e1) #x0b0554a5f86e9d82))
(constraint (= (f #x0d72a11da419b8ba) #x01797e326ec2ac9c))
(constraint (= (f #x2aa39ec9b16d03ed) #x2aa39ec9b16d03ee))
(constraint (= (f #xa5eed08e88aa35e9) #xa5eed08e88aa35ea))
(constraint (= (f #xa114ed4659e71556) #xa114ed4659e71557))
(constraint (= (f #x115e3b5bccb66c11) #x115e3b5bccb66c12))
(constraint (= (f #xd0c872b4060c0d8a) #xd0c872b4060c0d8b))
(check-synth)
