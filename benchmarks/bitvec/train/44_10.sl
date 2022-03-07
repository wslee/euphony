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
(constraint (= (f #xe8e48617023bc847) #x7472430b811de423))
(constraint (= (f #xa70c0a2bc6d4ed4a) #x53860515e36a76a5))
(constraint (= (f #x0ed05860d6e1e703) #x07682c306b70f381))
(constraint (= (f #xa5b01a942a9bcad6) #x52d80d4a154de56b))
(constraint (= (f #xe251dca9acc2d7eb) #x7128ee54d6616bf5))
(constraint (= (f #xb4e255bbe0332348) #x5a712addf01991a4))
(constraint (= (f #x6e38c450a5a725ba) #x371c622852d392dd))
(constraint (= (f #xb383ea0e9eeed2e7) #x59c1f5074f776973))
(constraint (= (f #xec36a2844d2e886e) #x761b514226974437))
(constraint (= (f #x85b2caae9ee05cb6) #x42d965574f702e5b))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (bvudiv x #x0000000000000002))
