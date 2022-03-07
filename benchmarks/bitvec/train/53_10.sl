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
(constraint (= (f #x68d9e31c895c7a3c) #xd1b3c63912b8f478))
(constraint (= (f #xea7e9986b346b711) #xc07c110422042600))
(constraint (= (f #x56530dd5da13ee60) #xaca61babb427dcc0))
(constraint (= (f #x7b7e68db8293b0ad) #x727c409300032008))
(constraint (= (f #x81e66b6ced61ea6d) #x01c44248c841c048))
(constraint (= (f #xbbc1e3d784265e9c) #x7783c7af084cbd38))
(constraint (= (f #xc84a3aeeb018458a) #x909475dd60308b14))
(constraint (= (f #xbe58c11e2995176c) #x7cb1823c532a2ed8))
(constraint (= (f #x2be3665dd3e01cce) #x57c6ccbba7c0399c))
(constraint (= (f #x7e6261b6d15c5308) #xfcc4c36da2b8a610))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvand (bvadd x x) x) (bvadd x x)))
