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
(constraint (= (f #x85c12c65236e72be) #x85c1ade52f6f73fe))
(constraint (= (f #xe1207ed6c7320aa4) #x70903f6b63990553))
(constraint (= (f #x748b82c95946458e) #x748bf6cbdbcf5dce))
(constraint (= (f #x0b0003596ea5995d) #x058001acb752ccaf))
(constraint (= (f #xb9e5beb5996d60e6) #x5cf2df5accb6b073))
(constraint (= (f #x972d6beb1e70e93d) #x4b96b5f58f38749f))
(constraint (= (f #x7aab56992019613b) #x3d55ab4c900cb09d))
(constraint (= (f #xe00e4ba6954cce75) #xe00e4ba6954cce75))
(constraint (= (f #x023eee407d28b485) #x023eee407d28b485))
(constraint (= (f #x0b439aacbb976580) #x05a1cd565dcbb2c1))
(check-synth)
