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
(constraint (= (f #xa2793ba0447489ee) #xfddeec5ffbbbf771))
(constraint (= (f #x2190c3de12635b0c) #xffefffe3ffddeeff))
(constraint (= (f #xe5ebea8de65bb421) #x0000e5ebefefeedf))
(constraint (= (f #x650402c24c0a5b17) #xfbfffffffbfffeee))
(constraint (= (f #x8ed342e62a50b171) #xf73effd9ddfffeee))
(constraint (= (f #x8b2066cac5a480e5) #x00008b20efeae7ee))
(constraint (= (f #x8647e54b7730c9ae) #xffbb9bbfc8cff775))
(constraint (= (f #x2bde841154e15b2b) #xfd637ffeebbfeedd))
(constraint (= (f #x203b9524ea07b1ce) #xfffc6effb5ffcef3))
(constraint (= (f #xe381a307106b9087) #x0000e381e387b36f))
(check-synth)
