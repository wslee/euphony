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
(constraint (= (f #x8186d3e081baae46) #xfffffffffffffffe))
(constraint (= (f #xa6c1dcd5ae68008b) #xffffffffffffffff))
(constraint (= (f #x56e2b6c5006a408d) #xffffffffffffffff))
(constraint (= (f #x4ec50ede7e8a101d) #xffffffffffffffff))
(constraint (= (f #x4141051d040da8b3) #x00004141051d040d))
(constraint (= (f #x9d150d19c10b6596) #x00009d150d19c10b))
(constraint (= (f #xe8d804ca63cd9775) #x0000e8d804ca63cd))
(constraint (= (f #xe08d298dd9ee4224) #xfffffffffffffffe))
(constraint (= (f #x7ab5586b9ad9573e) #x00007ab5586b9ad9))
(constraint (= (f #x6ea3edae14546baa) #xfffffffffffffffe))
(check-synth)
