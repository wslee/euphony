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
(constraint (= (f #x82d9650b78553887) #x00007d269af487aa))
(constraint (= (f #xd72d372c255ad082) #x0572d372c255ad08))
(constraint (= (f #xb7501b799e51d430) #x000048afe48661ae))
(constraint (= (f #x5eb3055a4e216978) #x0000a14cfaa5b1de))
(constraint (= (f #xce05dec85a3ee20c) #x04e05dec85a3ee20))
(constraint (= (f #xea55919ad2b9bab6) #x000015aa6e652d46))
(constraint (= (f #x0712bbb47277d5a0) #x0000f8ed444b8d88))
(constraint (= (f #x9243d5177d7e828d) #x04921ea8bbebf414))
(constraint (= (f #x70a7eadbb26c4ea0) #x070a7eadbb26c4ea))
(constraint (= (f #x78701c0e5c34ebc5) #x03c380e072e1a75e))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvand #x0000000000000001 x) #x0000000000000000) (ite (= (bvor #x0000000000000010 x) x) (bvlshr (bvnot x) #x0000000000000010) (ite (= (bvurem x #x000000000000000d) #x0000000000000000) (bvlshr (bvnot x) #x0000000000000010) (bvlshr (bvadd x x) #x0000000000000005))) (ite (= (bvor #x0000000000000003 x) x) (bvnot (bvashr x #x0000000000000010)) (bvlshr x #x0000000000000005))))
