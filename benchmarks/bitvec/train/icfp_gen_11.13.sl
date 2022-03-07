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
(constraint (= (f #x6DFC68E0D96E01DB) #x9203971F2691FE23))
(constraint (= (f #x2926221AEAC013AD) #xD6D9DDE5153FEC51))
(constraint (= (f #xE8BF12A2FF02FFA7) #x1740ED5D00FD0057))
(constraint (= (f #xB16153BB7FCAB0C1) #x4E9EAC4480354F3D))
(constraint (= (f #xB91E4DF7B2A8B2AD) #x46E1B2084D574D51))
(constraint (= (f #xD35F9188C1674B9E) #x1A6BF231182CE972))
(constraint (= (f #xCB35A76CA60BA329) #x1966B4ED94C17464))
(constraint (= (f #x5A9281282B959154) #x0B5250250572B22A))
(constraint (= (f #x9DB84290AD8BB0CE) #x13B7085215B17618))
(constraint (= (f #x8AA866825A455DF7) #x11550CD04B48ABBE))
(constraint (= (f #x0000000000000001) #xFFFFFFFFFFFFFFFD))
(constraint (= (f #x0000000000000035) #xFFFFFFFFFFFFFF95))
(constraint (= (f #x000000000000003B) #xFFFFFFFFFFFFFF89))
(constraint (= (f #x0000000000000020) #xFFFFFFFFFFFFFFBF))
(constraint (= (f #x0000000000000022) #xFFFFFFFFFFFFFFBB))
(constraint (= (f #x000000000000002A) #xFFFFFFFFFFFFFFAB))
(constraint (= (f #xACEF0567782B3BC2) #x5310FA9887D4C43D))
(constraint (= (f #xACEF0567782B3BC5) #x5310FA9887D4C439))
(constraint (= (f #xFFFFFFFFFFFFFFFD) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000004 x) x) (bvnot (bvneg (bvudiv x #x0000000000000008))) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (bvnot (bvadd x x)) (bvnot (bvxor #x0000000000000007 x)))) (ite (= (bvor #x0000000000000004 x) x) (bvnot (bvxor #x0000000000000003 x)) (ite (= (bvor #x0000000000000008 x) x) (bvnot (bvneg (bvudiv x #x0000000000000008))) (bvnot (bvxor #x0000000000000003 x))))) (ite (= (bvor #x0000000000000004 x) x) (ite (= (bvand #x0000000000000010 x) #x0000000000000000) (ite (= (bvor #x0000000000000002 x) x) (bvnot (bvxor #x000000000000000f x)) (bvnot (bvxor #x0000000000000003 x))) (ite (= (bvnot #x0000000000000002) x) #x0000000000000000 (ite (= (bvor #x0000000000000002 x) x) (bvudiv x #x0000000000000008) (ite (= (bvand #x0000000000000003 x) #x0000000000000000) (bvudiv x #x0000000000000008) (bvnot (bvadd x x)))))) (ite (= (bvurem x #x0000000000000005) #x0000000000000000) (bvnot x) (bvnot (bvadd x x))))))
