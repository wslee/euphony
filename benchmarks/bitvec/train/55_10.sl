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
(constraint (= (f #x82ac45ee3c37420c) #x05588bdc786e8418))
(constraint (= (f #xe4e188020b9ed5ee) #xc9c31004173dabdc))
(constraint (= (f #x08e8671a92d701b4) #x11d0ce3525ae0368))
(constraint (= (f #xdeec3c623654c432) #xbdd878c46ca98864))
(constraint (= (f #x84a859670eba3de2) #x0950b2ce1d747bc4))
(constraint (= (f #x43de90ad71b616ed) #x21ef4856b8db0b76))
(constraint (= (f #xd3b12c8e96b8e5b6) #xa762591d2d71cb6c))
(constraint (= (f #xdeb7620a9a5bd31d) #x6f5bb1054d2de98e))
(constraint (= (f #xae1deae8eea5d752) #x5c3bd5d1dd4baea4))
(constraint (= (f #x934ab303a7c787e9) #x49a55981d3e3c3f4))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvudiv x #x0000000000000002) (bvadd x x)))
