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
(constraint (= (f #x15cae98ece00d80b) #x0000000000000000))
(constraint (= (f #x4cc21d35a487ca9d) #x0000000000000000))
(constraint (= (f #x61e568e2070e28eb) #x0000000000000000))
(constraint (= (f #xdd68906be9ab8c64) #x0000000000000000))
(constraint (= (f #x3ebd9c8bc32e19e3) #x0000000000000000))
(constraint (= (f #x6ea98024d01c0a3a) #x0000000000000000))
(constraint (= (f #x32703dc8daee7209) #x032703dc8daee720))
(constraint (= (f #xc499278de4aacb16) #x0000000000000000))
(constraint (= (f #xe663b6bb29ec1e22) #x0000000000000000))
(constraint (= (f #x68a35dc1e6e782d1) #x068a35dc1e6e782d))
(check-synth)
