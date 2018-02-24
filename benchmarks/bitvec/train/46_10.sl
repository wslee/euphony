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
(constraint (= (f #x8a58ae9717d6609e) #x0000000000000000))
(constraint (= (f #x95ecde6028563645) #x00000095ecde6028))
(constraint (= (f #xe984b6e7d44eeb66) #x0000000000000000))
(constraint (= (f #x17be5d03173c2103) #x00000017be5d0317))
(constraint (= (f #x293464579a6bc09a) #x0000000000000000))
(constraint (= (f #x550e81a29ab3da53) #x000000550e81a29a))
(constraint (= (f #x665924aae4267679) #x000000665924aae4))
(constraint (= (f #xec16561c7952ad1b) #x000000ec16561c79))
(constraint (= (f #x6e395d22e2a26718) #x0000000000000000))
(constraint (= (f #xec8b67e0c40e5829) #x000000ec8b67e0c4))
(check-synth)
