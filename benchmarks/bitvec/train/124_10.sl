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
(constraint (= (f #x321e6678937339ed) #x321e6678937339ec))
(constraint (= (f #x671e9ae978b2c33d) #x671e9ae978b2c33c))
(constraint (= (f #x3ab0a234339486be) #x3ab0a234339486bd))
(constraint (= (f #x358c11cce9a53ee8) #x358c11cce9a53ee7))
(constraint (= (f #xec82acc416ee1d51) #xd90559882ddc3aa3))
(constraint (= (f #x06a698ac31a03bed) #x06a698ac31a03bec))
(constraint (= (f #xede73acaa9c8b0ca) #xdbce759553916195))
(constraint (= (f #x2eaca61a413e8145) #x5d594c34827d028b))
(constraint (= (f #xab919b00659e40a6) #xab919b00659e40a5))
(constraint (= (f #xbaa99b84e74630b8) #xbaa99b84e74630b7))
(check-synth)
