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
(constraint (= (f #xa17786ed31a6e983) #x548801100c411064))
(constraint (= (f #xc23dd03148950a79) #x31c022cca362a500))
(constraint (= (f #x1d580634321d0383) #xe22279888cc22c44))
(constraint (= (f #x0e87dc233541d363) #xf110021cc8aa2088))
(constraint (= (f #x9066deeb92e18765) #x6699001044106088))
(constraint (= (f #x053e043e354c3e39) #xfa801b8008a30004))
(constraint (= (f #xe21557d61574c836) #x1deaa829ea8b37c9))
(constraint (= (f #xd458484d230b9ceb) #x22a233320cc44210))
(constraint (= (f #x9d6333334d838e5d) #x6208cccc82244102))
(constraint (= (f #x78decdc1a43610b3) #x8020122241888e44))
(check-synth)
