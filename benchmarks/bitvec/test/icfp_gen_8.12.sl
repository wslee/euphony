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
(constraint (= (f #xE965D4967EB0B79B) #x0000E965D4967EB0))
(constraint (= (f #x5ED589381EF34021) #x00005ED589381EF3))
(constraint (= (f #xD8CDF7B3799599D1) #x0000D8CDF7B37995))
(constraint (= (f #xBC1FE2AB21631E91) #x0000BC1FE2AB2163))
(constraint (= (f #xBF5A858AE860A39D) #x0000BF5A858AE860))
(constraint (= (f #xFFFFFFFFFFFFFFFF) #x0000FFFFFFFFFFFF))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #x83D28605B67EB9AA) #x83D2C7EEF98194E9))
(constraint (= (f #x9869D86484198FA2) #x986A2499704BD1AE))
(constraint (= (f #x4575AEE78838E088) #x4575D1A25FACA4A4))
(constraint (= (f #x46BE79D16BDB7D4E) #x46BE9D30A8C4333B))
(constraint (= (f #x455EE1926DF2177C) #x455F0441DEBB4E75))
(constraint (= (f #xF0F0F0F0F0F0F0F2) #xF0F169696969696A))
(constraint (= (f #xFD2D407D8A897DB4) #xFD2DBF142AC842F8))
(constraint (= (f #x42A7CD2D4A1525EA) #x42A7EE8130ABCAF4))
(constraint (= (f #x34D9DA7D9950822B) #x000034D9DA7D9950))
(constraint (= (f #x193B688655FAA87B) #x0000193B688655FA))
(constraint (= (f #x866B23BE0DDB2FEF) #x0000866B23BE0DDB))
(constraint (= (f #x6803B1E41E51FBB0) #x6803E5E5F7440AD8))
(constraint (= (f #xD14DBE2658970530) #xD14E26CD37AA317B))
(constraint (= (f #x43FC2E2CC604CC90) #x43FC502ADD1B2F92))
(constraint (= (f #x7EEC49517FB1B51D) #x00007EEC49517FB1))
(constraint (= (f #xA524F72BAA67FA47) #x0000A524F72BAA67))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #xF0F0F0F0F0F0F0F2) #xF0F169696969696A))
(check-synth)
