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
(constraint (= (f #x479eba22051d0a70) #xfb86145ddfae2f58))
(constraint (= (f #x306bde7a42803084) #x0000000000000000))
(constraint (= (f #xc06e62b54de98bd3) #xf3f919d4ab216742))
(constraint (= (f #xd5608e6e64a0eaae) #x0000000000000000))
(constraint (= (f #xad153b354ecd58e3) #x0000000000000001))
(constraint (= (f #x33902172a1ba5220) #x0000000000000000))
(constraint (= (f #xd6ca529c854a29eb) #x0000000000000001))
(constraint (= (f #x3bc64ea2c25eda4b) #x0000000000000001))
(constraint (= (f #x7d677dcbd4179e54) #xf829882342be861a))
(constraint (= (f #x176dc21ce004014a) #x0000000000000000))
(check-synth)
