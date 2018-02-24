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
(constraint (= (f #x07DC746F252E6CDE) #x07DC77811F19FE49))
(constraint (= (f #x5DE0A416F7C0CFF8) #x5DE08AE6A5CBB418))
(constraint (= (f #x1C68B6F4B4226CBE) #x1C68B8C0EF5836AF))
(constraint (= (f #x26C61C69AE2D7226) #x26C60F0AA019A530))
(constraint (= (f #xB38ED5110989022E) #xB38E8CD6630186EA))
(constraint (= (f #xFDFB5F6F87F7EFAE) #xFDFB219228402C55))
(constraint (= (f #xFC7BE7DB4FFEDB68) #xFC7B99E6BC137C97))
(constraint (= (f #xFCB5F5F1EDFBDFCA) #xFCB58BAB17032937))
(constraint (= (f #xFE5AF2DF2DF3ED6A) #xFE5A8DF2549C7B93))
(constraint (= (f #xF1FCB4F4BE1EDBEC) #xF1FCCC0AE46484E3))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #x3D753C1978EDFFCD) #x3D753C1978EDFFCF))
(constraint (= (f #xD9587C0314751A9F) #xD9587C0314751A9D))
(constraint (= (f #x698B46CB1D2E4555) #x698B46CB1D2E4557))
(constraint (= (f #x411B0AC827AA089D) #x411B0AC827AA089F))
(constraint (= (f #xA72FDCDEC59358CD) #xA72FDCDEC59358CF))
(constraint (= (f #x0000000000000002) #x0000000000000002))
(constraint (= (f #x0000000000000003) #x0000000000000002))
(constraint (= (f #x5EBEB3B40E8CB7E8) #x5EBE9CEB5756B0AE))
(constraint (= (f #xBF0BC7FBDD43972B) #xBF0BC7FBDD439729))
(constraint (= (f #x50F7DAC64E2D64B5) #x50F7DAC64E2D64B7))
(constraint (= (f #x9C0A5ABD0D80EDBD) #x9C0A5ABD0D80EDBF))
(constraint (= (f #x0C6540EE19182806) #x0C6546DCB96F248A))
(constraint (= (f #x188BBAA00276803B) #x188BBAA002768039))
(constraint (= (f #xC25C28631AEC9322) #xC25C494D0EDD1E54))
(constraint (= (f #x8950F17BC04FF9C3) #x8950F17BC04FF9C1))
(constraint (= (f #xE71A1235A39E701F) #xE71A1235A39E701D))
(constraint (= (f #xFE6E3FE5D5D1392E) #xFE6E40D2CA23D3C6))
(constraint (= (f #x0000000000000003) #x0000000000000002))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(check-synth)
