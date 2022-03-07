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
(constraint (= (f #xae59e79a0d8280a5) #x28d30c32f93ebfad))
(constraint (= (f #x36db7ec494a7d256) #x492409db5ac16d4f))
(constraint (= (f #xa8de3de436916e42) #x2b90e10de4b748de))
(constraint (= (f #xaa179ba88a05e60c) #xaf4322bbafd0cf9f))
(constraint (= (f #x6a56168e613d3ab4) #xad4f4b8cf6162a5f))
(constraint (= (f #x9dbd4235419a7059) #x31215ee55f32c7d3))
(constraint (= (f #xc97ecb4bb3b76a20) #xb409a5a26244aeff))
(constraint (= (f #x6ec1997b2ea663e2) #x89f334268acce0ef))
(constraint (= (f #xea43150ed8e989a8) #x0ade7578938b3b2b))
(constraint (= (f #x52d196591487ea16) #x69734d375bc0af4f))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (bvnot (bvashr x #x0000000000000001)) (ite (= (bvor #x0000000000000004 x) x) (bvnot (bvmul #x0000000000000008 x)) (ite (= (bvurem x #x0000000000000003) #x0000000000000000) (bvnot (bvmul #x0000000000000008 x)) (ite (= (bvor #x0000000000000002 x) x) (bvnot (bvashr x #x0000000000000001)) (ite (= (bvor #x0000000000000008 x) x) (bvnot (bvashr x #x0000000000000001)) (bvnot (bvmul #x0000000000000008 x))))))))
