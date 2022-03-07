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
(constraint (= (f #x407342b4898da67e) #x607be3fecdcff77f))
(constraint (= (f #xa454175d3cb6e7a2) #xf67e1fffbefff7f3))
(constraint (= (f #xe426ed5261cac26e) #xf637fffb71efe37f))
(constraint (= (f #xbeecd7cb22e535ab) #x5f766be591729ad5))
(constraint (= (f #x469724129ed193c0) #x67dfb61bdff9dbe0))
(constraint (= (f #x3e7c6de6d950ca21) #x1f3e36f36ca86510))
(constraint (= (f #x4095ab0ea98867eb) #x204ad58754c433f5))
(constraint (= (f #xa020c51c71dac296) #xf030e79e79ffe3df))
(constraint (= (f #x8eb8e91016deb707) #x475c74880b6f5b83))
(constraint (= (f #xd17cb63dbd94e05b) #x68be5b1edeca702d))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvudiv x #x0000000000000002) (bvor (bvudiv x #x0000000000000002) x)))
