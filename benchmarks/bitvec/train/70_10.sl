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
(constraint (= (f #x1ac819241ab68b13) #x35903248356d1626))
(constraint (= (f #x15eb0b7e72304521) #x000015eb0b7e7230))
(constraint (= (f #x5d9a1de8546ddd7e) #x00005d9a1de8546d))
(constraint (= (f #x5848cc61e174e0ee) #x00005848cc61e174))
(constraint (= (f #x3e74bbd20aa72ed7) #x7ce977a4154e5dae))
(constraint (= (f #x0d4c057a339dd6ce) #x00000d4c057a339d))
(constraint (= (f #xc3c77c8ebdcd3e10) #x0000c3c77c8ebdcd))
(constraint (= (f #x74666d37aaeb5a40) #x000074666d37aaeb))
(constraint (= (f #xe7a4c9035ce78c62) #x0000e7a4c9035ce7))
(constraint (= (f #x4ecc4014540c93b8) #x00004ecc4014540c))
(check-synth)
