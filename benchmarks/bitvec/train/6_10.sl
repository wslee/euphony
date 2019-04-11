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
(constraint (= (f #xb0b2cba4276ad9a6) #xfffdf75ffd9d767d))
(constraint (= (f #xab3a93b9bde29c3c) #x00000ab3a93b9bde))
(constraint (= (f #x80e2462784378141) #xfffdfbddfffcffff))
(constraint (= (f #x8848bb7e1cc40e4e) #xf7ff74c9ff3bffbb))
(constraint (= (f #x1d753032cce42412) #x000001d753032cce))
(constraint (= (f #x23b59452ad91506b) #xfdceefbfd76eeffd))
(constraint (= (f #x226e09a45c71e776) #x00000226e09a45c7))
(constraint (= (f #x38448ad67016cc92) #x0000038448ad6701))
(constraint (= (f #x2cb3e1e79c6e96d5) #x000002cb3e1e79c6))
(constraint (= (f #xb69c7ce8e63dec24) #xfdf7bb3779de33ff))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000010 x) x) (bvudiv (bvlshr x #x0000000000000010) #x0000000000000010) (bvnot (bvand (bvudiv x #x0000000000000010) x))))
