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
(constraint (= (f #x28085a970e13e12c) #x28085a970e13e12d))
(constraint (= (f #xbe5341bebd2a0749) #xbe5341bebd2a0749))
(constraint (= (f #xe239460eed2cc34e) #xe239460eed2cc34f))
(constraint (= (f #xac5b1b5e9b236b10) #xac5b1b5e9b236b11))
(constraint (= (f #x4069a4c7173e1786) #x4069a4c7173e1786))
(constraint (= (f #x39419062091119a6) #x39419062091119a6))
(constraint (= (f #x49aeeca628644ee0) #x49aeeca628644ee0))
(constraint (= (f #x75e5bc2a07c77c97) #x75e5bc2a07c77c97))
(constraint (= (f #x4c5ee4be98c5ee7d) #x4c5ee4be98c5ee7d))
(constraint (= (f #xcd67bd5beaac575e) #xcd67bd5beaac575e))
(check-synth)
