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
(constraint (= (f #x39333a33cea27561) #xfffffffffffffffe))
(constraint (= (f #x875ecd02934eb458) #x01d872a3e128b08c))
(constraint (= (f #xe280ac2ca0b16551) #xfffffffffffffffe))
(constraint (= (f #xdd5ec05ac5337bbd) #xfffffffffffffffe))
(constraint (= (f #x2253056ebde55d01) #xfffffffffffffffe))
(constraint (= (f #x63d67b49ee595645) #xfffffffffffffffe))
(constraint (= (f #x83a777109a70880d) #xfffffffffffffffe))
(constraint (= (f #x51d0e144a10ec149) #xfffffffffffffffe))
(constraint (= (f #xcdae3a5c0531702e) #x02a436c46fc2b1be))
(constraint (= (f #x1deaee9e5e26569c) #x0367033174765411))
(check-synth)
