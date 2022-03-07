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
(constraint (= (f #x7ae6e89bceabea30) #x0000007ae6e89bce))
(constraint (= (f #x4c1d10e3542b7b59) #x983a21c6a856f6b0))
(constraint (= (f #x06ea177047e59e6d) #x0dd42ee08fcb3cd8))
(constraint (= (f #x7d48ba79dd2a578d) #xfa9174f3ba54af18))
(constraint (= (f #x6e1327bd87241083) #x0000006e1327bd87))
(constraint (= (f #x02700e1ed96ad31d) #x04e01c3db2d5a638))
(constraint (= (f #xdaeb644158573713) #x000000daeb644158))
(constraint (= (f #x2ed5be278659e2ed) #x5dab7c4f0cb3c5d8))
(constraint (= (f #xa3e518eb9ee32de4) #x000000a3e518eb9e))
(constraint (= (f #xac96c241231ea9ee) #x592d8482463d53dc))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000001 x) x) (bvlshr (bvlshr x #x0000000000000010) #x0000000000000008) (bvadd x x)) (ite (= (bvor #x0000000000000001 x) x) (bvxor (bvadd x x) #x0000000000000002) (bvlshr (bvlshr x #x0000000000000010) #x0000000000000008))))
