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
(constraint (= (f #x55E97C3BC6BF21B6) #x55E97C3BC6BF21B8))
(constraint (= (f #xDF62CE2F85427DB1) #xDF62CE2F85427DB1))
(constraint (= (f #x7E1EC7EC70213256) #x7E1EC7EC70213258))
(constraint (= (f #xC96383CB21D7BEDC) #xC96383CB21D7BEDE))
(constraint (= (f #xAC958BE1A5581A56) #xAC958BE1A5581A58))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #xFFFFF00000000000))
(constraint (= (f #x966DFABDEC3549CF) #x966DF3DB339E970C))
(constraint (= (f #xD6A520B899A46AE3) #xD6A52DD2CBAFE379))
(constraint (= (f #xAC266D035F783146) #xAC2667C139A804B1))
(constraint (= (f #xC095608DD3368427) #xC0956C84853E5914))
(constraint (= (f #xCCBFE5F0A59BEF23) #xCCBFE93B5BC4E57A))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #x0000000000000002) #x0000000000000002))
(constraint (= (f #x0000000000000003) #x0000000000000003))
(constraint (= (f #x84C722DE3A5C20DF) #x84C722DE3A5C20DF))
(constraint (= (f #x700A2BAA3E20C952) #x700A2BAA3E20C954))
(constraint (= (f #x01877BD7C34D41C8) #x01877BCFB4F03DFC))
(constraint (= (f #x02D0E83F1A531E75) #x02D0E83F1A531E75))
(constraint (= (f #x98DCEFB05594D934) #x98DCEFB05594D936))
(constraint (= (f #x62383925770C97DA) #x62383925770C97DC))
(constraint (= (f #xA56B321B17179CA3) #xA56B384DA4362DD2))
(constraint (= (f #x61889C97F3822D72) #x61889C97F3822D74))
(constraint (= (f #x521CDD14A88D28A4) #x521CD835655C622C))
(constraint (= (f #xF0D86AA0F73C3C95) #xF0D86AA0F73C3C95))
(constraint (= (f #x0000000000000000) #x0000000000000000))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #xFFFFF00000000000))
(constraint (= (f #x7FFFFFFFFFFFFFFF) #x7FFFFFFFFFFFFFFF))
(constraint (= (f #xFFFFFFFFFFFFFFFE) #x0000000000000000))
(constraint (= (f #x0000000000000002) #x0000000000000002))
(check-synth)
