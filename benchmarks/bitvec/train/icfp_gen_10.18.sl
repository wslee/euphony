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
(constraint (= (f #x115960A3892807B5) #x000022B2C1471250))
(constraint (= (f #x505E2042E4D83A09) #x0000A0BC4085C9B0))
(constraint (= (f #x11CC9EC51C1C77F5) #x000023993D8A3838))
(constraint (= (f #x5C316B1509CED021) #x0000B862D62A139D))
(constraint (= (f #xC13A2DA9672E37BB) #x000082745B52CE5C))
(constraint (= (f #xF0F0F0F0F0F0F0F1) #x0000E1E1E1E1E1E1))
(constraint (= (f #x3FFFFFFFFFFFFFFF) #x0000000000000000))
(constraint (= (f #x0000000000000003) #x0000000000000000))
(constraint (= (f #x000000000001FFFF) #x0000000000000000))
(constraint (= (f #x00000000000001FF) #x0000000000000000))
(constraint (= (f #x000000000000003F) #x0000000000000000))
(constraint (= (f #xB89B3AF4B74CA0FA) #xB89B3AF4B74CA0FB))
(constraint (= (f #x74B74189F0895F02) #x74B74189F0895F03))
(constraint (= (f #x5519D27EAD81EB3C) #x5519D27EAD81EB3D))
(constraint (= (f #x9D5E03882D4E0E24) #x9D5E03882D4E0E25))
(constraint (= (f #x8D9C1935678D2184) #x8D9C1935678D2185))
(constraint (= (f #x0000000000000000) #x0000000000000001))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #x203C4DDFF195C2FE) #x203C4DDFF195C2FF))
(constraint (= (f #x320AC2B545BFC2D3) #x00006415856A8B7F))
(constraint (= (f #xD3B9641C1752FAA4) #xD3B9641C1752FAA5))
(constraint (= (f #x59A6C03F7DAD0D24) #x59A6C03F7DAD0D25))
(constraint (= (f #x1232027630DFB3B0) #x1232027630DFB3B1))
(constraint (= (f #xCE46626149EAFF6E) #xCE46626149EAFF6F))
(constraint (= (f #x45CA4BCA7E37AA4D) #x00008B949794FC6F))
(constraint (= (f #x3E47F7876B83FAC6) #x3E47F7876B83FAC7))
(constraint (= (f #xAB92512CBEE83698) #xAB92512CBEE83699))
(constraint (= (f #xE19327119CE740C7) #x0000C3264E2339CE))
(constraint (= (f #x0000000000000000) #x0000000000000001))
(constraint (= (f #x000000000001FFFF) #x0000000000000000))
(constraint (= (f #x0000000000019ED9) #x0000000000000003))
(constraint (= (f #x000000000000FFFF) #x0000000000000000))
(constraint (= (f #x000000000000B5DB) #x0000000000000001))
(constraint (= (f #x00000000003FFFFF) #x0000000000000000))
(constraint (= (f #x3FFFFFFFFFFFFFFF) #x0000000000000000))
(constraint (= (f #x00007FFFFFFFFFFF) #x0000000000000000))
(constraint (= (f #xF0F0F0F0F0F0F0F1) #x0000E1E1E1E1E1E1))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000006 x) x) (ite (= (bvor #x0000000000000008 x) x) #x0000000000000000 (bvlshr (bvadd x x) #x0000000000000010)) (bvlshr (bvadd x x) #x0000000000000010)) (bvxor #x0000000000000001 x)))
