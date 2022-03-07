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
(constraint (= (f #x1a5465e6ded59d1a) #x072d5cd0c9095317))
(constraint (= (f #x82c812e32014aba7) #x82c812e32014aba6))
(constraint (= (f #x5d27238ceda6eaec) #x5d27238ceda6eaed))
(constraint (= (f #x084d96d972a85e52) #x084d96d972a85e53))
(constraint (= (f #x2155e9e78287952c) #x06f550b0c3ebc356))
(constraint (= (f #x90b0b38958b5b8e6) #x037a7a63b53a5238))
(constraint (= (f #x251865a4ed5387c1) #x06d73cd2d89563c1))
(constraint (= (f #x8e85cda9ae87c23e) #x038bd192b28bc1ee))
(constraint (= (f #x8ade8e2ec1e53599) #x03a90b8e89f0d653))
(constraint (= (f #x0626ce3beee88dea) #x0626ce3beee88deb))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (bvxor #x0000000000000001 x) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvand #x0000000000000009 x) #x0000000000000000) (bvnot (bvashr x #x0000000000000005)) (bvxor #x0000000000000001 x)) (bvlshr (bvnot x) #x0000000000000005)) (bvlshr (bvnot x) #x0000000000000005))))
