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
(constraint (= (f #xdc07568507beda16) #xb80ead0a0f7db42c))
(constraint (= (f #x19481d0200571ab7) #x0000000000000001))
(constraint (= (f #xdce951283ae95ed9) #xb9d2a25075d2bdb2))
(constraint (= (f #xa61dbe03dab5b6d2) #x4c3b7c07b56b6da4))
(constraint (= (f #xbad6165b60a89e61) #xbad6165b60a89e61))
(constraint (= (f #x180c94216ce407a8) #x180c94216ce407a8))
(constraint (= (f #xcca3e151b99be015) #x9947c2a37337c02a))
(constraint (= (f #x2232cac3248c6499) #x446595864918c932))
(constraint (= (f #xe37bb395c6a89120) #xe37bb395c6a89120))
(constraint (= (f #x8ac6c70581e4deeb) #x8ac6c70581e4deeb))
(check-synth)
