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
(constraint (= (f #x5d1a1ba411b5e373) #x5d1a1ba411b5e373))
(constraint (= (f #xa67ee6e7e3761380) #xa67ee6e7e3761381))
(constraint (= (f #x70144724b1edc80e) #x70144724b1edc80f))
(constraint (= (f #x48ea0967ae1181da) #xb715f69851ee7e25))
(constraint (= (f #x7603ee9e575097aa) #x7603ee9e575097ab))
(constraint (= (f #x964ee3271e075e3e) #x69b11cd8e1f8a1c1))
(constraint (= (f #xd7ec5702beea39ca) #x2813a8fd4115c635))
(constraint (= (f #x071b4c9b73e617a1) #x071b4c9b73e617a1))
(constraint (= (f #x860b79c184d6c7e6) #x79f4863e7b293819))
(constraint (= (f #xd8cb21de63aa1a38) #xd8cb21de63aa1a39))
(check-synth)
