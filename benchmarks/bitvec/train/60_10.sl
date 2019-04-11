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
(constraint (= (f #x3b81adde9e2802c9) #x00003b81adde9e28))
(constraint (= (f #xcb9e80912e7d08e3) #xcfbfe8993effd8ef))
(constraint (= (f #x9e01d13ee33d3cc6) #x9fe1dd3fef3fffce))
(constraint (= (f #x02e0aed199e76a3c) #x000002e0aed199e7))
(constraint (= (f #x7d02be70b5e0ce54) #x7fd2bff7bffecef5))
(constraint (= (f #xec87e20dac318b04) #xeecffe2dfef39bb4))
(constraint (= (f #xa87a1bc84ee1e6b6) #xaaffbbfcceeffeff))
(constraint (= (f #xd886c4080cd4a6e7) #xdd8eec488cddeeef))
(constraint (= (f #x8e9a4ea08e4cb7c5) #x8efbeeea8eecfffd))
(constraint (= (f #xd40eacb8ccb87540) #xdd4eeefbccfbf754))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000008 x) x) (bvlshr x #x0000000000000010) (bvor (bvudiv x #x0000000000000010) x)))
