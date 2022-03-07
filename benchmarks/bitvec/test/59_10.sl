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
(constraint (= (f #x1e17c3635ee6c154) #xfffffffffffffffe))
(constraint (= (f #xa061e2cb5dbe8b77) #xffffffffffffffff))
(constraint (= (f #xc3deb3da46cacc52) #xfffffffffffffffe))
(constraint (= (f #xe8439c6081092bc1) #x0d08738c10212579))
(constraint (= (f #x17cb8bbeded26d7c) #xfffffffffffffffe))
(constraint (= (f #xe23ee04ea72e25d5) #xffffffffffffffff))
(constraint (= (f #x09c91033ae2e3e13) #xffffffffffffffff))
(constraint (= (f #xcae8c579b244015d) #xffffffffffffffff))
(constraint (= (f #x637cb7a85ce28e74) #xfffffffffffffffe))
(constraint (= (f #x38c75c1a6d999ce1) #x0718eb834db3339d))
(check-synth)
