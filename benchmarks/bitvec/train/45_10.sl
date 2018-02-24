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
(constraint (= (f #xed5eee4004416702) #x0000000000000000))
(constraint (= (f #x59a7e2ee2a47d16e) #x0000000000000000))
(constraint (= (f #xa9616e3dac571c3a) #x0000000000000000))
(constraint (= (f #x6ac6c6e143ce3bc5) #x00009539391ebc31))
(constraint (= (f #x6c6eb64dedeedce2) #x0000000000000000))
(constraint (= (f #x8a25e96cd52e2ec5) #x000075da16932ad1))
(constraint (= (f #x31e8d0a38a4e167e) #x0000000000000000))
(constraint (= (f #xe4272013c59595ac) #x0000000000000000))
(constraint (= (f #x38e5937596e06d47) #x0000c71a6c8a691f))
(constraint (= (f #x9eeeadb04d099ea8) #x0000000000000000))
(check-synth)
