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
(constraint (= (f #xeed40423e830e30d) #x8895fdee0be78e79))
(constraint (= (f #x869d96c21cca0aeb) #x1f7f7f8c7bbc3ffe))
(constraint (= (f #x83d263239ecb1da3) #x0fedcecf7fbe7fce))
(constraint (= (f #x757278b1ec911824) #xffedf3e7fb6670d8))
(constraint (= (f #xa5288029843a5e1d) #xad6bbfeb3de2d0f1))
(constraint (= (f #xe64778a61a5eb27e) #xdd9ff3dc7dffedfc))
(constraint (= (f #x7a61a580854cad5d) #xc2cf2d3fbd59a951))
(constraint (= (f #x3ab21d42b8d4d1cc) #xe2a6f15ea3959719))
(constraint (= (f #xca68ad92b35451ed) #xbdf3ff6feff9e7fe))
(constraint (= (f #x7e8012eec6892947) #xc0bff6889cbb6b5c))
(check-synth)
