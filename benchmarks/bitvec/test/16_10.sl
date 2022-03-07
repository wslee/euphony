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
(constraint (= (f #xb3c79edee2095aed) #x9870c2423bed4a26))
(constraint (= (f #x76ed5eee31143254) #x122542239dd79b54))
(constraint (= (f #x21a53457d7654c7e) #x10d29a2bebb2a63f))
(constraint (= (f #x535aaae1c56215c5) #x594aaa3c753bd476))
(constraint (= (f #x3d6b06edc5e5deb0) #x8529f2247434429c))
(constraint (= (f #xee385e33e0e31233) #x771c2f19f071891a))
(constraint (= (f #xe11ba934ae84d2ad) #x3dc8ad96a2f65aa6))
(constraint (= (f #x3527c488dee7d6a1) #x95b076ee423052be))
(constraint (= (f #xe8e1be4ee47d47e5) #x2e3c836237057036))
(constraint (= (f #x5684914527a22c91) #x52f6dd75b0bba6de))
(check-synth)
