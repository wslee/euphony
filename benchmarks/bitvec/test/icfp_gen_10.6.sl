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
(constraint (= (f #x8AD2FD62FF6C67E4) #x018223E163F92D5F))
(constraint (= (f #xE8D2FFC68720C234) #x031A23FED1DA7AE6))
(constraint (= (f #xC94A61D77F495AC4) #x0290857619F89042))
(constraint (= (f #xDBC3F68CADA41304) #x024EEF91A8244F2B))
(constraint (= (f #x44B90813E4A8378C) #x00C8D39F2F481E9D))
(constraint (= (f #x0000000000190F7A) #x03FFFFFFFFFF53B9))
(constraint (= (f #x0000000000161BD8) #x03FFFFFFFFFF174E))
(constraint (= (f #x000000000014AC4E) #x03FFFFFFFFFF082C))
(constraint (= (f #x0000000000191424) #x03FFFFFFFFFF530E))
(constraint (= (f #x00000000001C766A) #x03FFFFFFFFFF6D95))
(constraint (= (f #x00000001F02FCF44) #x000000000841C147))
(constraint (= (f #x000000017BBD9D82) #x000000000E331A9A))
(constraint (= (f #x000000015AC82818) #x000000000FBD61E0))
(constraint (= (f #x000000013BC23346) #x000000000D311957))
(constraint (= (f #x00000001A6402F42) #x000000000BAB01C7))
(constraint (= (f #x1705A5B4717E834B) #x000000001705A5B5))
(constraint (= (f #x6501F4FC795B3EAF) #x000000006501F4FD))
(constraint (= (f #x2E53DB2CC6FB9FF7) #x000000002E53DB2D))
(constraint (= (f #x82B0BBEF3430DE5D) #x0000000082B0BBEF))
(constraint (= (f #x07824464212A7D31) #x0000000007824465))
(constraint (= (f #x000000000016A521) #x0000000000000001))
(constraint (= (f #x0000000000185B25) #x0000000000000001))
(constraint (= (f #x0000000000147A59) #x0000000000000001))
(constraint (= (f #x0000000000117847) #x0000000000000001))
(constraint (= (f #x0000000000199BA5) #x0000000000000001))
(constraint (= (f #x0000000199E5D379) #x0000000000000001))
(constraint (= (f #x0000000123939693) #x0000000000000001))
(constraint (= (f #x00000001F28E1831) #x0000000000000001))
(constraint (= (f #x00000001D3989509) #x0000000000000001))
(constraint (= (f #x00000001A11AD8B3) #x0000000000000001))
(check-synth)
