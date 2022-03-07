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
(constraint (= (f #x84aae1da2c5ccd64) #x8dffe3fe7cfddfee))
(constraint (= (f #x01b04334d6a7ebd3) #x00d8219a6b53f5e8))
(constraint (= (f #x92364ce9909c74c4) #xb67eddfbb1bcfdce))
(constraint (= (f #x8442bb3e6032ec93) #x42215d9f30197648))
(constraint (= (f #x65ed4301e69c6d7c) #xefffc703efbcfffe))
(constraint (= (f #x30aebe7c9dc565a7) #x18575f3e4ee2b2d2))
(constraint (= (f #x9eb13da1be5cc56e) #xbff37fe3fefdcffe))
(constraint (= (f #x6e0b139b9addd15a) #xfe1f37bfbffff3fe))
(constraint (= (f #xa478bb348039ecee) #xecf9ff7d807bfdfe))
(constraint (= (f #x24a35e5b7562e098) #x6de7feffffe7e1ba))
(check-synth)
