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
(constraint (= (f #x8bab9dd87e49bce3) #x8fffddfc7f69fce3))
(constraint (= (f #x82d4e2b3b3d33b57) #xfbe958ea62616625))
(constraint (= (f #x9dd383ea163ea0a8) #x9dfb83ff163ff0ac))
(constraint (= (f #x16b50630e1d55ce2) #x16b58630e1dffee3))
(constraint (= (f #x621e2aeecc5462c8) #x631e3bffee7663cc))
(constraint (= (f #x9ed424e94c5088b8) #xfb095ed8b59d7bba))
(constraint (= (f #x05a8577ae0ea9642) #x05ac57fbf0efd662))
(constraint (= (f #xe17eceebe77ee84e) #xe17feefff77ffc4e))
(constraint (= (f #xe8c59d20e4186e70) #xf8b9d316f8df3c8c))
(constraint (= (f #xe953ce70bca3e0e8) #xed5bce70bce3f0ec))
(check-synth)
