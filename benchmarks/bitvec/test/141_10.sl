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
(constraint (= (f #xee2c0ead82c20b4c) #x00000ee2c0ead82c))
(constraint (= (f #xd7e0057ceb8db5ed) #x00d400051c6184b6))
(constraint (= (f #x09781e1bb68872d1) #x0009000212900853))
(constraint (= (f #x8e83c28b0535ba0d) #x0080004000043501))
(constraint (= (f #xeecdc0e757031053) #x00c88800e2400201))
(constraint (= (f #xe7d0e3e25dd39e04) #x0000000000000000))
(constraint (= (f #x9a3ea60e26e6660e) #x000009a3ea60e26e))
(constraint (= (f #x910d0c6b73e90e93) #x0001010c6a712103))
(constraint (= (f #x6c72b60a078b4530) #x0000000000000000))
(constraint (= (f #x3c6489c1a0e9e75e) #x0000000000000000))
(check-synth)
