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
(constraint (= (f #xc0611e2e6795204c) #x0000000000000000))
(constraint (= (f #x62029ce8be48e4e7) #x0000031014e745f2))
(constraint (= (f #xee56e343ec474c9c) #x0000000000000000))
(constraint (= (f #xe8abee56db33643e) #x0000000000000000))
(constraint (= (f #x19e89d165a227092) #x0000000000000000))
(constraint (= (f #x16e04700c6ec5647) #x000000b702380637))
(constraint (= (f #xb8dad884c2eb4317) #x000005c6d6c42617))
(constraint (= (f #xae54de673255e139) #x00000572a6f33992))
(constraint (= (f #x5dd0c29bc2aac571) #x000002ee8614de15))
(constraint (= (f #x47852ca031891ede) #x0000000000000000))
(check-synth)
