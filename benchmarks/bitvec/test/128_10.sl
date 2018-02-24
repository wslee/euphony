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
(constraint (= (f #x05571722de4db775) #x0000000028b81012))
(constraint (= (f #xaa9d55ace66a929e) #xaa7556b399aa4a7a))
(constraint (= (f #x4c2e7dbaeec91772) #x30b9f6ebbb245dca))
(constraint (= (f #x7a892ba42e90e373) #xea24ae90ba438dca))
(constraint (= (f #xb901c4e77da95e7c) #x0000000008062329))
(constraint (= (f #xad4e32a194be4e62) #xb538ca8652f9398a))
(constraint (= (f #xa41a8c6140763856) #x906a318501d8e15a))
(constraint (= (f #x2e0060d6d761b97d) #x00000000000206b2))
(constraint (= (f #x536291dc5036b77a) #x4d8a477140daddea))
(constraint (= (f #x16c2e8d9e4e6055b) #x5b0ba3679398156a))
(check-synth)
