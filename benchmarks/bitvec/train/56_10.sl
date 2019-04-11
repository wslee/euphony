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
(constraint (= (f #x3e028b121ce9770b) #x01f0145890e74bb9))
(constraint (= (f #x2612baaa403edde9) #x013095d55201f6ef))
(constraint (= (f #xbaac9b72a25aeae5) #x05d564db9512d757))
(constraint (= (f #x41614953a3eed8d9) #x0000000000000001))
(constraint (= (f #xe8e28e56e35b9bb5) #x0000000000000001))
(constraint (= (f #xe876e15baebbbe9e) #xb964a4130c333bda))
(constraint (= (f #xd5b1e6be238d4c47) #x06ad8f35f11c6a63))
(constraint (= (f #x07c63e46a22ed5e1) #x003e31f2351176af))
(constraint (= (f #x8b18a86eeaeca52b) #x0458c54377576529))
(constraint (= (f #x66b3d68cb990c91e) #x341b83a62cb25b5a))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvor #x000000000000000a x) x) (bvmul #x0000000000000003 x) #x0000000000000001) (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (bvlshr x #x0000000000000005) (ite (= (bvurem x #x0000000000000007) #x0000000000000000) (bvlshr x #x0000000000000005) (bvxor (bvlshr x #x0000000000000005) #x0000000000000001)))))
