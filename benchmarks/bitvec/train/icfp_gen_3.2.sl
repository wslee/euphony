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
(constraint (= (f #xB36D9D767F80D3CA) #x0000B36D9D767F80))
(constraint (= (f #x3060A3581249C2F4) #x00003060A3581249))
(constraint (= (f #xD671AA81AE20474E) #x0000D671AA81AE20))
(constraint (= (f #xB2D5D08A55058540) #x0000B2D5D08A5505))
(constraint (= (f #x3AC52279E1F19A68) #x00003AC52279E1F1))
(constraint (= (f #x555D5AF55EABBADE) #x0000555D5AF55EAB))
(constraint (= (f #xD757AB6BD6DF7ED6) #x0000D757AB6BD6DF))
(constraint (= (f #x76B7FEAAB7AEABF6) #x000076B7FEAAB7AE))
(constraint (= (f #xABAFF55D7755D5AA) #x0000ABAFF55D7755))
(constraint (= (f #xD7D76AAB55F7B6EA) #x0000D7D76AAB55F7))
(constraint (= (f #x1EA747D8CE0BBE87) #x3D4E8FB19C177D10))
(constraint (= (f #xB62BE55B8D31F761) #x6C57CAB71A63EEC4))
(constraint (= (f #x93C6C687194D6329) #x278D8D0E329AC654))
(constraint (= (f #x7BEB35EAEC1A404D) #xF7D66BD5D834809C))
(constraint (= (f #x62BCF8B4AD3AE537) #xC579F1695A75CA70))
(constraint (= (f #x0000000000000001) #x0000000000000004))
(constraint (= (f #x1B7CEC75400A64A7) #x36F9D8EA8014C950))
(constraint (= (f #xF15A9234507DEE88) #x0000F15A9234507D))
(constraint (= (f #x0986E54B85C8F928) #x00000986E54B85C8))
(constraint (= (f #xDD8F95CBB70B1796) #x0000DD8F95CBB70B))
(constraint (= (f #x98BCC6045A84901B) #x31798C08B5092038))
(constraint (= (f #x20A22E8934ECF2B7) #x41445D1269D9E570))
(constraint (= (f #xC14C90AE74068A7E) #x0000C14C90AE7406))
(constraint (= (f #x26DBCF791280CEF8) #x000026DBCF791280))
(constraint (= (f #x77349BF84F83084C) #x000077349BF84F83))
(constraint (= (f #x43EA053AD4F1ECD7) #x87D40A75A9E3D9B0))
(constraint (= (f #x0000000000000001) #x0000000000000004))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvneg (bvmul (bvnot x) #x0000000000000002)) (bvlshr x #x0000000000000010)))
