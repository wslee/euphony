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
(constraint (= (f #xd70894e15a6d6477) #x0ae1129c2b4dac8e))
(constraint (= (f #xb47b9809eb1e63c2) #xb933de894c6c7d84))
(constraint (= (f #x4c926e5787ec9514) #x57c947720f6dcbc2))
(constraint (= (f #x3b7a11e01c3a0c05) #x076f423c03874180))
(constraint (= (f #x9051719149096de6) #x974c5a783478d706))
(constraint (= (f #x84d52223ea329667) #x009aa4447d4652cc))
(constraint (= (f #x7a7b84ced6e08801) #x0f4f7099dadc1100))
(constraint (= (f #x0b9de3e38606aee1) #x0173bc7c70c0d5dc))
(constraint (= (f #xd3b8b711ed0de2e5) #x0a7716e23da1bc5c))
(constraint (= (f #xeb83c95898c23a22) #xeccb8cc30f36167e))
(check-synth)
