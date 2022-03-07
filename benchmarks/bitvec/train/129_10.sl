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
(constraint (= (f #x3cde844eee46e113) #x79bd089ddc8dc227))
(constraint (= (f #xad8dce0d950ed7be) #x5b1b9c1b2a1daf7d))
(constraint (= (f #x938aa22a5e7509c3) #x27154454bcea1387))
(constraint (= (f #x197130e6e2abee15) #x32e261cdc557dc2b))
(constraint (= (f #x3b784e15b78c08a2) #x76f09c2b6f181145))
(constraint (= (f #x0ee2d90aeb1e5409) #x1dc5b215d63ca813))
(constraint (= (f #xba7a0b90bc2b4955) #x74f41721785692ab))
(constraint (= (f #xdcc0e8896d5a53ce) #xb981d112dab4a79d))
(constraint (= (f #x63ee11461db9e310) #xc7dc228c3b73c621))
(constraint (= (f #xad9910232c4de6bd) #x5b322046589bcd7b))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (bvsub x (bvnot x)))
