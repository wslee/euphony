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
(constraint (= (f #x66724b71e3b8a452) #x66724b71e3b8a454))
(constraint (= (f #x6b566e6d3670d9ce) #x6b566e6d3670d9d0))
(constraint (= (f #xd3e1ac6bb2e995c3) #x0000000000000002))
(constraint (= (f #x0226c8a04ebeea5e) #x0226c8a04ebeea60))
(constraint (= (f #x9489e05b83e0784c) #x9489e05b83e0784e))
(constraint (= (f #x87de2ed85dc94818) #x43ef176c2ee4a40c))
(constraint (= (f #x3352ea4b75c79e83) #x0000000000000002))
(constraint (= (f #x2970e37c57ad922e) #x14b871be2bd6c917))
(constraint (= (f #xbba2644d2de32e14) #x5dd1322696f1970a))
(constraint (= (f #xe481b69326876ec3) #x0000000000000002))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) #x0000000000000002 (ite (= (bvand #x000000000000000c x) #x0000000000000000) (bvxor #x0000000000000006 x) (ite (= (bvurem x #x0000000000000007) #x0000000000000000) (bvudiv x #x0000000000000002) (ite (= (bvor #x0000000000000004 x) x) (bvadd #x0000000000000002 x) (bvudiv x #x0000000000000002))))))
