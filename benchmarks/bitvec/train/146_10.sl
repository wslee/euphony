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
(constraint (= (f #x057b494d47c86436) #x0af6929a8f90c86d))
(constraint (= (f #xa3b05289dc347d26) #xa3b05289dc347d26))
(constraint (= (f #xaec1e4ce32a79336) #xaec1e4ce32a79336))
(constraint (= (f #x221ca8b7490eaa6e) #x4439516e921d54dd))
(constraint (= (f #x0e5e645ae81ba346) #x0e5e645ae81ba346))
(constraint (= (f #x866723d29e0d05e3) #x866723d29e0d05e3))
(constraint (= (f #x998d30ede66b88b5) #x998d30ede66b88b5))
(constraint (= (f #x4533148bc4913e4e) #x4533148bc4913e4e))
(constraint (= (f #x13c6a8c49aeee9a6) #x13c6a8c49aeee9a6))
(constraint (= (f #x23ee0489de1ebee3) #x23ee0489de1ebee3))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvurem x #x0000000000000009) #x0000000000000000) (bvsub x (bvnot x)) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) x (ite (= (bvor #x0000000000000005 x) x) x (ite (= (bvurem x #x000000000000000b) #x0000000000000000) x (bvsub x (bvnot x)))))))
