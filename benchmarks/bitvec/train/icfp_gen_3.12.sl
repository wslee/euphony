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
(constraint (= (f #xD135F372502B5945) #xD135F372502B5947))
(constraint (= (f #x6FC2190131FEFCE9) #x6FC2190131FEFCEB))
(constraint (= (f #xCE110236835577BE) #xCE110236835577BE))
(constraint (= (f #x593685A94F441FB3) #x593685A94F441FB3))
(constraint (= (f #x92DBC1503E843D6B) #x92DBC1503E843D6B))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #xFFFFFFFFFFFFFFFF))
(constraint (= (f #x000000000001B803) #x000000000003F807))
(constraint (= (f #x0000000000018534) #x0000000000038F7C))
(constraint (= (f #x000000000001AD2D) #x000000000003FF7F))
(constraint (= (f #x0000000000012DCB) #x0000000000037FDF))
(constraint (= (f #x000000000001EBCF) #x000000000003FFDF))
(constraint (= (f #x9CFA02905FE8F3C8) #x9CFA02905FE8F3C8))
(constraint (= (f #xE11178246B78D2AB) #xE11178246B78D2AB))
(constraint (= (f #x5DC47CAB28FD1B49) #x5DC47CAB28FD1B4B))
(constraint (= (f #xD386C460E523A473) #xD386C460E523A473))
(constraint (= (f #x6EAB252C343D3EB7) #x6EAB252C343D3EB7))
(constraint (= (f #x81AB085D3E3A6BFA) #x81AB085D3E3A6BFA))
(constraint (= (f #x29E8FF88A7A72942) #x29E8FF88A7A72942))
(constraint (= (f #x3F92704D0D3D1D3F) #x3F92704D0D3D1D3F))
(constraint (= (f #xE62B682115E64F5A) #xE62B682115E64F5A))
(constraint (= (f #x8C3D8B7B1118E3FB) #x8C3D8B7B1118E3FB))
(constraint (= (f #x000000000001B0B5) #x000000000003F1FF))
(constraint (= (f #x000000000001217A) #x00000000000363FE))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (ite (= (bvor #x0000000000000004 x) x) (ite (= (bvor #x0000000000000010 x) x) (bvor (bvadd x x) x) (ite (= (bvor #x0000000000000008 x) x) (bvor (bvadd x x) x) (bvxor #x0000000000000002 x))) (ite (= (bvor #x0000000000000001 x) x) (bvxor #x0000000000000002 x) x)) (ite (= (bvor #x0000000000000010 x) x) (ite (= (bvor #x0000000000000001 x) x) x (ite (= (bvor #x000000000000000e x) x) x (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvor (bvadd x x) x) x))) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x000000000000000e x) x) (bvor (bvadd x x) x) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvor (bvadd x x) x) (ite (= (bvor #x0000000000000008 x) x) x (bvor (bvadd x x) x)))) x))))
