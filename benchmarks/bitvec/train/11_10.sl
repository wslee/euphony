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
(constraint (= (f #x9db91b67d1eee4b4) #x00009db91b67d1ee))
(constraint (= (f #x211526232b50ea1d) #xdeead9dcd4af15e2))
(constraint (= (f #xedcec1de604e94ec) #x0000edcec1de604e))
(constraint (= (f #xede1841179ee3684) #x0000ede1841179ee))
(constraint (= (f #x9c623bcc40d252bd) #x639dc433bf2dad42))
(constraint (= (f #x4601c6d84a50d01b) #xb9fe3927b5af2fe4))
(constraint (= (f #x0c5ed1e748c4e26c) #x00000c5ed1e748c4))
(constraint (= (f #x6bb653229e60ee94) #x00006bb653229e60))
(constraint (= (f #x483db90b3dee6596) #x0000483db90b3dee))
(constraint (= (f #x55376e703c4a1ea8) #x000055376e703c4a))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvnot x) (bvlshr x #x0000000000000010)))
