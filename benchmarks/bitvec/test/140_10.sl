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
(constraint (= (f #x079d6cad4a88077e) #x0e30901000000cf8))
(constraint (= (f #xbe1863d9211bc3de) #x7c30c7b2423787bd))
(constraint (= (f #x0174eb79eec52e84) #x02e9d6f3dd8a5d09))
(constraint (= (f #xd0d396dc6e1e49d4) #xa1a72db8dc3c93a8))
(constraint (= (f #xa216b83d87cb304c) #x442d707b0f966099))
(constraint (= (f #x1395680e44e4c257) #x272ad01c89c984af))
(constraint (= (f #xb50c0be6453d8979) #x40100788007200e0))
(constraint (= (f #x699e23340de2d37c) #x82380440138104f0))
(constraint (= (f #x1e829e1c5847e41e) #x3d053c38b08fc83d))
(constraint (= (f #x07d79b0bdcdece98) #x0faf3617b9bd9d30))
(check-synth)
