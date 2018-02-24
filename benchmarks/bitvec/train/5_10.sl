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
(constraint (= (f #x0b0ee88aa6d83e36) #x0000000000000000))
(constraint (= (f #x089e7415e53ded3a) #x0000f7618bea1ac2))
(constraint (= (f #x9d04373e13670706) #x000062fbc8c1ec98))
(constraint (= (f #xedb5d9e6d00e3e94) #x0000000000000000))
(constraint (= (f #xa5b25cb355c6587d) #x0000000000000000))
(constraint (= (f #xd210e2266521aee5) #xd210e2266521aee4))
(constraint (= (f #x1e5734cea9a5dee5) #x1e5734cea9a5dee4))
(constraint (= (f #x9a9ebedd7a7c1e3b) #x0000000000000000))
(constraint (= (f #x62d04368024530c0) #x00009d2fbc97fdba))
(constraint (= (f #xe26a0c51e2dcdd90) #x0000000000000000))
(check-synth)
