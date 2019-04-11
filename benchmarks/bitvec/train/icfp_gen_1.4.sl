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
(constraint (= (f #xA33D4C359BD2848F) #xA33D4C359BD2848F))
(constraint (= (f #x5608281ABA0588BD) #x5608281ABA0588BD))
(constraint (= (f #x880F8C3AD066FA2B) #x880F8C3AD066FA2B))
(constraint (= (f #xE0CCF465597CA3B5) #xE0CCF465597CA3B5))
(constraint (= (f #x94AB8444284DB885) #x94AB8444284DB885))
(constraint (= (f #x901C43786D97E944) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xFB12BD70CCFA99C4) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x5AB8E9611EC0E670) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xC9C08D9046AF08C6) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x9D4A87EF2E807632) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x0000000000000003) #x0000000000000003))
(constraint (= (f #xB198000000000001) #x0000000000000001))
(constraint (= (f #x8574000000000001) #x0000000000000001))
(constraint (= (f #xC267000000000001) #x0000000000000001))
(constraint (= (f #x2543000000000001) #x0000000000000001))
(constraint (= (f #xDD2A000000000001) #x0000000000000001))
(constraint (= (f #xDDE8E7B76E1CCFE2) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x0475C230E4EBF3B3) #x0475C230E4EBF3B3))
(constraint (= (f #x32CF09E43B7D3393) #x32CF09E43B7D3393))
(constraint (= (f #x2B0B30FC1F2463FE) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xADE87EAF3F7B89CB) #xADE87EAF3F7B89CB))
(constraint (= (f #x1FCF9633524DF927) #x1FCF9633524DF927))
(constraint (= (f #x633C2B6BA3FF379E) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xB4FC7E3A5D2EC9CC) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #xC8DE4D1CF80B1FDF) #xC8DE4D1CF80B1FDF))
(constraint (= (f #x93428D181F72EABE) #xFFFFFFFFFFFFFFFE))
(constraint (= (f #x23CF000000000001) #x0000000000000001))
(constraint (= (f #xB90FEE5A28795915) #xB90FEE5A28795915))
(constraint (= (f #x769044B6CA8EAAFD) #x769044B6CA8EAAFD))
(constraint (= (f #xDCAEDCAE88828083) #xDCAEDCAE88828083))
(constraint (= (f #x44A280FDF5CC4929) #x44A280FDF5CC4929))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvor #x0000000000000008 x) x) x (ite (= (bvor #x0000000000000002 x) x) x (ite (= (bvor #x0000000000000004 x) x) x #x0000000000000001))) (bvnot #x0000000000000001)))
