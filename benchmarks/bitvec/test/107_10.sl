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
(constraint (= (f #xc7c78c355c3eb4ec) #x7070e79547829624))
(constraint (= (f #x582b3633a28793e4) #x0000582b3633a287))
(constraint (= (f #xacad5b76053e37ee) #xa6a54913f5839020))
(constraint (= (f #x889551ee25b285b7) #xeed55c23b49af492))
(constraint (= (f #x53cd253676e37e4a) #x000053cd253676e3))
(constraint (= (f #x412a7694e0b8dcc2) #x7dab12d63e8e4678))
(constraint (= (f #xd5c973a98792891c) #x546d18acf0daedc4))
(constraint (= (f #xb773418550a85c3e) #x91197cf55eaf4780))
(constraint (= (f #xe0ee505c5617d429) #x0000e0ef314aa674))
(constraint (= (f #x127ce8d7eaae1bcc) #xdb062e502aa3c864))
(check-synth)
