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
(constraint (= (f #x4a4e85e8c6ea8e2a) #x949d0bd18dd51c56))
(constraint (= (f #x8d9cb7e53c37917e) #x1b396fca786f22fe))
(constraint (= (f #x0cc6be549e771135) #x00000cc6be549e77))
(constraint (= (f #x25e7b608ebd6e358) #x4bcf6c11d7adc6b2))
(constraint (= (f #xb086795a31e75330) #x610cf2b463cea662))
(constraint (= (f #xc4a0e023eb9259e1) #x0000c4a0e023eb92))
(constraint (= (f #x4e07475142118aa7) #x00004e0747514211))
(constraint (= (f #x21ae4ebe5ee394ac) #x435c9d7cbdc7295a))
(constraint (= (f #xa7ed87165ba054e1) #x0000a7ed87165ba0))
(constraint (= (f #x435d6926745c40d9) #x0000435d6926745c))
(check-synth)
