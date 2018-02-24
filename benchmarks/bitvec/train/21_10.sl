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
(constraint (= (f #xde63ae7ee7992973) #x798eb9fb9e64a5cc))
(constraint (= (f #xe4ad7ac0353dbe4c) #x92b5eb00d4f6f930))
(constraint (= (f #x194981e790292aac) #x6526079e40a4aab0))
(constraint (= (f #xd931e9eca0478582) #x64c7a7b2811e1608))
(constraint (= (f #xe59be1ccbe526633) #x0000000000000002))
(constraint (= (f #x5164d0772bbe47e5) #x0000000000000002))
(constraint (= (f #x21dc6d394818442e) #x21dc6d3948184430))
(constraint (= (f #x39ca9702b62bade0) #xe72a5c0ad8aeb780))
(constraint (= (f #x18e54e0623a2ae33) #x0000000000000002))
(constraint (= (f #xce9d217e849d93cd) #x3a7485fa12764f34))
(check-synth)
