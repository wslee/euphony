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
(constraint (= (f #xd5752ee87720d71e) #x2a8ad11788df28e1))
(constraint (= (f #xe670aad84eee5ed9) #x0000000000000001))
(constraint (= (f #xc20133e172eabe7c) #x0000000000000000))
(constraint (= (f #x57b6e71e0e176250) #x0000000000000000))
(constraint (= (f #xc39eda372131903c) #x0000000000000000))
(constraint (= (f #x4d0e212b30c5c1ab) #xb2f1ded4cf3a3e55))
(constraint (= (f #xe336c0825b34e2b6) #x1cc93f7da4cb1d49))
(constraint (= (f #x092697eb5b6b61d5) #x0000000000000001))
(constraint (= (f #x03262104ebc638b6) #xfcd9defb1439c749))
(constraint (= (f #x8e8e7ac6504aea2c) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000002 x) x) (bvneg x) #x0000000000000001) (ite (= (bvor #x0000000000000002 x) x) (bvnot x) #x0000000000000000)))
