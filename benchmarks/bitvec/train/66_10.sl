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
(constraint (= (f #x3d73ab5edad76a9c) #xf5cead7b6b5daa70))
(constraint (= (f #x9a378cd3ae7cadd4) #xfffffffffffffffe))
(constraint (= (f #x1bb7cc2eec047cdd) #xfffffffffffffffd))
(constraint (= (f #xd1575300c8c778e2) #x455d4c03231de388))
(constraint (= (f #x01d588651c756949) #x0756219471d5a524))
(constraint (= (f #xd973d0d6e3dccb72) #xfffffffffffffffe))
(constraint (= (f #xc1356dadeee4dd46) #xfffffffffffffffe))
(constraint (= (f #x04952d5eab9c6ba1) #xfffffffffffffffd))
(constraint (= (f #x8a56a4e7e3d52061) #x295a939f8f548184))
(constraint (= (f #x5b2ee7b77d750de9) #x6cbb9eddf5d437a4))
(check-synth)
