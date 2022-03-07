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
(constraint (= (f #xed7e441cc3b3e149) #x00009bc16612a26a))
(constraint (= (f #x9b673d051e3db93a) #x00009b673d051e3d))
(constraint (= (f #x7032d01decb9dd2e) #x00007032d01decb9))
(constraint (= (f #xc6ac10e6056b0e3e) #x0000c6ac10e6056b))
(constraint (= (f #x715e535ae7e9361a) #x0000715e535ae7e9))
(constraint (= (f #x5e6c6529c7b6cce3) #x000000026321080c))
(constraint (= (f #x1433d2c684588bab) #x0000000080961420))
(constraint (= (f #xec57bbe7e3366b41) #x00000002209d1f19))
(constraint (= (f #x5c0b70e35b389e31) #x0000000040030218))
(constraint (= (f #xee39a563d7e29255) #x0000000141090a1e))
(check-synth)
