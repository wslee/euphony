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
(constraint (= (f #xea72d9508ddee7b7) #x0000d4e5b2a11bbd))
(constraint (= (f #x1423b7e1e38305b1) #x075ee240f0e3e7d2))
(constraint (= (f #x397be52b796e2456) #x063420d6a4348edd))
(constraint (= (f #x63c19e9d309eeee4) #x04e1f30b167b0888))
(constraint (= (f #xa49e9e74a2470610) #x0000493d3ce9448e))
(constraint (= (f #xe62213447e7982de) #x0000cc442688fcf3))
(constraint (= (f #xe78e89273859600a) #x0000cf1d124e70b2))
(constraint (= (f #x42cdeee85e2b0730) #x0000859bddd0bc56))
(constraint (= (f #x3338c1dbd2994d63) #x0000667183b7a532))
(constraint (= (f #x11984da0daeaee43) #x000023309b41b5d5))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000008 x) x) (bvlshr (bvadd x x) #x0000000000000010) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000002 x) x) (bvlshr (bvadd x x) #x0000000000000010) (bvlshr (bvnot x) #x0000000000000005)) (ite (= (bvor #x0000000000000004 x) x) (bvlshr (bvnot x) #x0000000000000005) (bvlshr (bvadd x x) #x0000000000000010)))))
