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
(constraint (= (f #x9C105517D22F8242) #x063EFAAE82DD07DB))
(constraint (= (f #x8D0DD822CEAA7174) #x072F227DD31558E8))
(constraint (= (f #x8C553053527A49C4) #x073AACFACAD85B63))
(constraint (= (f #x7BC60C7F1A3D3770) #x08439F380E5C2C88))
(constraint (= (f #xF304E95BC792995A) #x00CFB16A4386D66A))
(constraint (= (f #x07D9EE0DDA242703) #x07D9EE0DDA242705))
(constraint (= (f #xB07FEF89B26B9AE7) #xB07FEF89B26B9AE9))
(constraint (= (f #xBF6988F89924D9AB) #xBF6988F89924D9AD))
(constraint (= (f #x51D0574730B6106F) #x51D0574730B61071))
(constraint (= (f #x2B517D8163D276D7) #x2B517D8163D276D9))
(constraint (= (f #x0000000000000001) #x0000000000000003))
(constraint (= (f #x0502875F1D3D46FA) #x0FAFD78A0E2C2B90))
(constraint (= (f #xFD4CF553AD9DE833) #xFD4CF553AD9DE835))
(constraint (= (f #x5DE014E2A25BAF6D) #x5DE014E2A25BAF6F))
(constraint (= (f #x7152605380E7FC73) #x7152605380E7FC75))
(constraint (= (f #xEE24456D21A7E60F) #xEE24456D21A7E611))
(constraint (= (f #x8D037E9686F9B1B3) #x8D037E9686F9B1B5))
(constraint (= (f #x01525F23ADC15DC7) #x01525F23ADC15DC9))
(constraint (= (f #xE9D69228E88F7AB9) #xE9D69228E88F7ABB))
(constraint (= (f #x2F4C70001A8A1E6E) #x0D0B38FFFE575E19))
(constraint (= (f #x8078DE79E99B5CC6) #x07F8721861664A33))
(constraint (= (f #x0000000000000001) #x0000000000000003))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvadd #x0000000000000002 x) (bvudiv (bvnot x) #x0000000000000010)))
