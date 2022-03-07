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
(constraint (= (f #x29b5ce505c4ebb04) #x29b5ce505c4ebb05))
(constraint (= (f #x12810cad518e8ca9) #x12810cad518e8caa))
(constraint (= (f #xc2b4bee92a4b4227) #x7a96822dab697bb1))
(constraint (= (f #x1c24d0b9cbb7762a) #xc7b65e8c689113ab))
(constraint (= (f #xe60ce5178052bb0e) #xe60ce5178052bb0f))
(constraint (= (f #xde96e435eb9dead8) #xde96e435eb9dead9))
(constraint (= (f #x5950edc7b9e8be45) #x5950edc7b9e8be46))
(constraint (= (f #x525eaba42b17293a) #x5b42a8b7a9d1ad8b))
(constraint (= (f #x0ee65966a7c9a03e) #x0ee65966a7c9a03f))
(constraint (= (f #x32aa8c70e534752d) #x9aaae71e359715a5))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000003 x) x) (bvnot (bvadd x x)) (ite (= (bvor #x0000000000000008 x) x) (ite (= (bvor #x0000000000000005 x) x) (bvnot (bvadd x x)) (ite (= (bvor #x0000000000000004 x) x) (bvxor #x0000000000000001 x) (ite (= (bvor #x0000000000000002 x) x) (bvnot (bvadd x x)) (bvneg (bvnot x))))) (bvneg (bvnot x)))))
