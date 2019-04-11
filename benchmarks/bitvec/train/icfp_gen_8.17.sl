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
(constraint (= (f #x9528DB6E527EA959) #x00009128526E0058))
(constraint (= (f #xC489B94B97437D09) #x0000800991431501))
(constraint (= (f #x7178546C432C0D1F) #x00005068402C010C))
(constraint (= (f #x8EFCC833E8CED17B) #x00008830C802C04A))
(constraint (= (f #x8F54C1CFCEF912D3) #x00008144C0C902D1))
(constraint (= (f #xFFFFFFFFFFFFFFFD) #x0000000000000000))
(constraint (= (f #xD0145058150688A3) #x0000501010000002))
(constraint (= (f #x224D901745C02AA3) #x0000000500000080))
(constraint (= (f #xB813222A8182C033) #x0000200200028002))
(constraint (= (f #xB83028193645D121) #x0000281020011001))
(constraint (= (f #x1150004180D05933) #x0000004000400010))
(constraint (= (f #x7EE0673522259C88) #xFDC0CE6A444B3912))
(constraint (= (f #x2C790F655180D440) #x58F21ECAA301A882))
(constraint (= (f #x28333FBF782F827A) #x50667F7EF05F04F6))
(constraint (= (f #x60ED7187B5CBD2B2) #xC1DAE30F6B97A566))
(constraint (= (f #xDF2C7B2F78B87C8E) #xBE58F65EF170F91E))
(constraint (= (f #xFFFFFFFFFFFFFFFC) #xFFFFFFFFFFFFFFFA))
(constraint (= (f #xFFFFFFFFFFFFFFFE) #xFFFFFFFFFFFFFFFC))
(constraint (= (f #xA35F1853C90FB618) #x46BE30A7921F6C32))
(constraint (= (f #x5EF907092E63A781) #x0000060906012601))
(constraint (= (f #x192FECB6F62676D2) #x325FD96DEC4CEDA6))
(constraint (= (f #x161C323D01538E27) #x0000121C00110003))
(constraint (= (f #xFB0A613D8AE74E72) #xF614C27B15CE9CE6))
(constraint (= (f #x09EE71D0E1FC02D7) #x000001C061D000D4))
(constraint (= (f #xE3E40401AAB609EF) #x00000000000008A6))
(constraint (= (f #x40E753C6780347B8) #x81CEA78CF0068F72))
(constraint (= (f #xA1A6A7206EF6088C) #x434D4E40DDEC111A))
(constraint (= (f #x0B1F2F59591144FD) #x00000B1909114011))
(constraint (= (f #xFFFFFFFFFFFFFFFE) #xFFFFFFFFFFFFFFFC))
(constraint (= (f #xFFFFFFFFFFFFFFFD) #x0000000000000000))
(constraint (= (f #xFFFFFFFFFFFFFFFC) #xFFFFFFFFFFFFFFFA))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= (bvnot #x0000000000000002) x) #x0000000000000000 (bvand (bvlshr x #x0000000000000010) x)) (ite (= (bvnot #x0000000000000001) x) (bvnot #x0000000000000003) (bvxor (bvadd x x) #x0000000000000002))))
