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
(constraint (= (f #x1abba9be668cda41) #x0340cc14f551aa44))
(constraint (= (f #xe923a0a8d16b270e) #x03126c781a310a5b))
(constraint (= (f #x2cee5c341e8b3eed) #x022b346e8f718af3))
(constraint (= (f #x16b658c11b7c4912) #xfffffe949a73ee48))
(constraint (= (f #xe792ee1ebdd4c941) #x035d233770e60a90))
(constraint (= (f #x62ebebedad01d4a1) #x01630f0f2423f608))
(constraint (= (f #x8ddeeea6e3ebb584) #x01a67330536f0c85))
(constraint (= (f #x0855465e336995b1) #xffffff7aab9a1cc9))
(constraint (= (f #x864eb2188184eedb) #xfffff79b14de77e7))
(constraint (= (f #x3e089698ebc46bb7) #xfffffc1f76967143))
(check-synth)
