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
(constraint (= (f #xc7b50625b38b3d97) #x0000000000000001))
(constraint (= (f #x7db2ed908ed01205) #xc1268937b897f6fc))
(constraint (= (f #x2ae94c2b23e3cd79) #x0000000000000001))
(constraint (= (f #x3b8d94ea7d03e216) #x00003b8d94ea7d04))
(constraint (= (f #xeab381d47c86b2ed) #x8aa63f15c1bca688))
(constraint (= (f #x3e6d5dded43d849b) #x0000000000000001))
(constraint (= (f #x20e37c512e44e4e9) #xef8e41d768dd8d8a))
(constraint (= (f #x317a3e9298946612) #x0000317a3e929895))
(constraint (= (f #xbe9160bde8eed92d) #xa0b74fa10b889368))
(constraint (= (f #x9bd9866ce63eb972) #x00009bd9866ce63f))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000010 x) x) #x0000000000000001 (bvnot (bvxor (bvudiv x #x0000000000000002) #x0000000000000001))) (ite (= (bvor #x0000000000000006 x) x) (bvxor (bvlshr x #x0000000000000010) #x0000000000000007) (bvxor (bvlshr x #x0000000000000010) #x0000000000000001))))
