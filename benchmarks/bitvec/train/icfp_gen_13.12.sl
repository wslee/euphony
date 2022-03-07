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
(constraint (= (f #xAA4D4BF32F249246) #x549A97E65E49248C))
(constraint (= (f #xDC62CFCB423634AE) #xB8C59F96846C695C))
(constraint (= (f #x4F389408EC173996) #x9E712811D82E732C))
(constraint (= (f #xCFE621E4E7E2E1C0) #x9FCC43C9CFC5C380))
(constraint (= (f #x3540CBBD6BD70FDE) #x6A81977AD7AE1FBC))
(constraint (= (f #xFFFFFFFFFFFFFFF8) #xFFFFFFFFFFFFFFF0))
(constraint (= (f #xFFFFFFFFFFFFFFFA) #xFFFFFFFFFFFFFFF4))
(constraint (= (f #x0000000000034736) #x0000000000000004))
(constraint (= (f #x0000000000036C1C) #x0000000000000000))
(constraint (= (f #x00000000000202FA) #x0000000000000004))
(constraint (= (f #x00000000000232C4) #x0000000000000000))
(constraint (= (f #x000000000002FD32) #x0000000000000004))
(constraint (= (f #xFF497EFD57109301) #xFF497EFD57109301))
(constraint (= (f #x2B41EA2C27E7BB75) #x2B41EA2C27E7BB75))
(constraint (= (f #x467725175E832AF7) #x467725175E832AF7))
(constraint (= (f #x1955227ACD508647) #x1955227ACD508647))
(constraint (= (f #x5929ABF0E0D4933F) #x5929ABF0E0D4933F))
(constraint (= (f #xFFFFFFFFFFFFFFF9) #xFFFFFFFFFFFFFFF9))
(constraint (= (f #xFFFFFFFFFFFFFFFB) #xFFFFFFFFFFFFFFFB))
(constraint (= (f #x000000000003B015) #x000000000003B015))
(constraint (= (f #x0000000000030A0D) #x0000000000030A0D))
(constraint (= (f #x000000000002D12D) #x000000000002D12D))
(constraint (= (f #x000000000003B865) #x000000000003B865))
(constraint (= (f #x00000000000243C9) #x00000000000243C9))
(constraint (= (f #x7C28B9B668C33370) #xF851736CD18666E0))
(constraint (= (f #xEB04BC68D9C304F8) #xD60978D1B38609F0))
(constraint (= (f #x72E392D3C62DE761) #x72E392D3C62DE761))
(constraint (= (f #x89B35B3B86E2F38A) #x1366B6770DC5E714))
(constraint (= (f #x6DAF95CE22D71F76) #xDB5F2B9C45AE3EEC))
(constraint (= (f #xC4F1FB882A47D298) #x89E3F710548FA530))
(constraint (= (f #xD8D26746D36CE695) #xD8D26746D36CE695))
(constraint (= (f #xFFED6C56696A9EC5) #xFFED6C56696A9EC5))
(constraint (= (f #x7FB6F0A196175E4F) #x7FB6F0A196175E4F))
(constraint (= (f #x4B348B6CE7067D5B) #x4B348B6CE7067D5B))
(constraint (= (f #x00000000000366B6) #x0000000000000004))
(constraint (= (f #x00000000000222A8) #x0000000000000000))
(constraint (= (f #xFFFFFFFFFFFFFFFB) #xFFFFFFFFFFFFFFFB))
(constraint (= (f #xFFFFFFFFFFFFFFFA) #xFFFFFFFFFFFFFFF4))
(constraint (= (f #x0000000000025C25) #x0000000000025C25))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) x (ite (= (bvand #x0000000000000002 x) #x0000000000000000) (ite (= (bvashr x x) #x0000000000000000) (ite (= (bvand #x000000000000000c x) #x0000000000000000) (bvadd x x) #x0000000000000000) (bvadd x x)) (ite (= (bvurem x #x0000000000000007) #x0000000000000001) #x0000000000000004 (ite (= (bvor #x0000000000000004 x) x) (bvadd x x) (ite (= (bvurem x #x0000000000000003) #x0000000000000001) (bvadd x x) #x0000000000000004))))))
