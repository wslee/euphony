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
(constraint (= (f #x6bedbd49e6e3b640) #xdaa6cd3af11b1a48))
(constraint (= (f #x3433b756b98b2a5b) #x68676ead731654b6))
(constraint (= (f #x3166448e9564eb01) #x62cc891d2ac9d602))
(constraint (= (f #x53c94279ed9bbed0) #xadebacbce6840a7a))
(constraint (= (f #x7c9090944b2daab1) #xf9212128965b5562))
(constraint (= (f #x14e7a33ecc3bc6d6) #x2b53b21a41f0f576))
(constraint (= (f #xead60a47dd0ee4ba) #xc8f6d5c741bc15e2))
(constraint (= (f #x37cc81b866519cc3) #x6f990370cca33986))
(constraint (= (f #x1c5e12c8800d2c9e) #x3b37e7c8101bfcae))
(constraint (= (f #x8ea3a7177232c706) #x0c933acc0a23d6ec))
(check-synth)
