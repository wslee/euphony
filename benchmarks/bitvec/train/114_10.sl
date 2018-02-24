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
(constraint (= (f #xb5d319e72c70b41e) #xb5d319e72c70b41f))
(constraint (= (f #x000a21910c417e93) #x000a729d94a38a87))
(constraint (= (f #x4dd41437805bc948) #x4dd41437805bc948))
(constraint (= (f #x870a55ec609d6896) #x870a55ec609d6897))
(constraint (= (f #xe2eb1cd253e24776) #xe2eb1cd253e24777))
(constraint (= (f #xd20ea744e72c09d8) #xd20ea744e72c09d9))
(constraint (= (f #x2762ed62e9ec9561) #x289e04ce013bfa0c))
(constraint (= (f #xc6cc66655cdc46a4) #xc6cc66655cdc46a4))
(constraint (= (f #x0ec1399e70dd2d07) #x0f37436b6464166f))
(constraint (= (f #x42e06e86367a4e8e) #x42e06e86367a4e8e))
(check-synth)
