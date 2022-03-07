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
(constraint (= (f #x346e81ee5e6e7b8e) #x68dd03dcbcdcf71d))
(constraint (= (f #x1b953974763ce562) #x372a72e8ec79cac5))
(constraint (= (f #x97017b13600a38aa) #x2e02f626c0147155))
(constraint (= (f #x446be8317c4e7e55) #x77282f9d07630356))
(constraint (= (f #x00275721e39063de) #x004eae43c720c7bd))
(constraint (= (f #x3d7264e6ce8182bd) #x851b363262fcfa86))
(constraint (= (f #x1bd8572c94021e76) #x37b0ae5928043ced))
(constraint (= (f #xe153274d4eeed5ea) #xc2a64e9a9dddabd5))
(constraint (= (f #xe22ee857bb80e9c8) #xc45dd0af7701d391))
(constraint (= (f #xa203cd9864e5a014) #x44079b30c9cb4029))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvneg (bvadd x x)) (bvsub x (bvnot x))))
