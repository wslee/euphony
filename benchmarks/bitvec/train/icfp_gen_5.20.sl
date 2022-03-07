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
(constraint (= (f #x942DA0A0BA088AEC) #x942DA0A0BA088AEE))
(constraint (= (f #x160F89341CADDA58) #x160F89341CADDA5A))
(constraint (= (f #x9BBFD5C55F4DAC0C) #x9BBFD5C55F4DAC0E))
(constraint (= (f #x74EA35BDA70F7A5A) #x74EA35BDA70F7A5C))
(constraint (= (f #xACC1A07475C88744) #xACC1A07475C88746))
(constraint (= (f #x47949B26453D5739) #x000047949B26453E))
(constraint (= (f #x7836D1D3C9B249C7) #x00007836D1D3C9B3))
(constraint (= (f #x69305770687AF1D5) #x000069305770687B))
(constraint (= (f #x7F2877C0B1E1A983) #x00007F2877C0B1E2))
(constraint (= (f #x2B6A5BDDD36477CD) #x00002B6A5BDDD365))
(constraint (= (f #x0954829214108555) #x0000095482921411))
(constraint (= (f #xA1414A0022809451) #x0000A1414A002281))
(constraint (= (f #x8AA2A10512AA1485) #x00008AA2A10512AB))
(constraint (= (f #x4A5015290928A945) #x00004A5015290929))
(constraint (= (f #xA54454A9452A0885) #x0000A54454A9452B))
(constraint (= (f #x0000000000000001) #x0000000000000001))
(constraint (= (f #xFC362C76EB3A98E1) #x0000FC362C76EB3B))
(constraint (= (f #x61EC37E76B7131E3) #x000061EC37E76B72))
(constraint (= (f #xEA2296D41B271478) #xEA2296D41B27147A))
(constraint (= (f #x0A624A8EEAE93351) #x00000A624A8EEAEA))
(constraint (= (f #x15F8CF16AACF1F1B) #x000015F8CF16AAD0))
(constraint (= (f #xAB354461196ABF13) #x0000AB354461196B))
(constraint (= (f #x3960C3057E45AA62) #x3960C3057E45AA64))
(constraint (= (f #x27971FF315662F9F) #x000027971FF31567))
(constraint (= (f #xE793CFAD2ED6B622) #xE793CFAD2ED6B624))
(constraint (= (f #xB42FBD97B621BD56) #xB42FBD97B621BD58))
(constraint (= (f #xA892244802515081) #x0000A89224480252))
(constraint (= (f #x0000000000000001) #x0000000000000001))
(constraint (= (f #x018D720FF45F4006) #x018D720FF45F4008))
(constraint (= (f #x28BB05923E767218) #x28BB05923E76721A))
(constraint (= (f #x20D22F0D91DDC28C) #x20D22F0D91DDC28E))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvneg (bvnot (bvlshr x #x0000000000000010))) (ite (= (bvor #x0000000000000002 x) x) (ite (= (bvor #x0000000000000004 x) x) (bvxor #x000000000000000e x) (bvxor #x0000000000000006 x)) (bvxor #x0000000000000002 x))))
