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
(constraint (= (f #xb36d1bce56064ea9) #x126d034842004880))
(constraint (= (f #xc6be0be5db01ee63) #x0000000000000000))
(constraint (= (f #xe0c74e88a9e415be) #x7063a74454f20ae0))
(constraint (= (f #xb7c22be831ee8d6a) #x5be115f418f746b6))
(constraint (= (f #x16627b532861ddea) #x0b313da99430eef6))
(constraint (= (f #xe4eeb42ce05a9e8b) #x0000000000000000))
(constraint (= (f #x7b2ead61490a06a5) #x0b24852009000084))
(constraint (= (f #x8c2565b3e67be663) #x0000000000000000))
(constraint (= (f #xdb8a4ea75d3ba136) #x6dc52753ae9dd09c))
(constraint (= (f #x25bc62c279774602) #x12de31613cbba302))
(check-synth)
