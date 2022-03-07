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
(constraint (= (f #x948A0D1B7A8636CF) #xBD9E27526F92A46D))
(constraint (= (f #x29DE3BA366D58FF1) #x7D9AB2EA3480AFD3))
(constraint (= (f #x3253CEE970586E2D) #x96FB6CBC51094A87))
(constraint (= (f #x5ABDAC224984EAFD) #x10390466DC8EC0F7))
(constraint (= (f #x669977FE11949EF1) #x33CC67FA34BDDCD3))
(constraint (= (f #x28BB9068DB0EB2BE) #x028BB9068DB0EB2A))
(constraint (= (f #xA830298FC3F5755E) #x0A830298FC3F5754))
(constraint (= (f #xD2B8E57EA48E2B98) #x0D2B8E57EA48E2B8))
(constraint (= (f #xF3FF6C39ABFE329E) #x0F3FF6C39ABFE328))
(constraint (= (f #x0B88D46B9F709856) #x00B88D46B9F70984))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(constraint (= (f #x1763D2B5AA8F8D78) #x01763D2B5AA8F8D6))
(constraint (= (f #x62C457299B025DDE) #x062C457299B025DC))
(constraint (= (f #xFF43E35F4C72B201) #xFDCBAA1DE5581603))
(constraint (= (f #x7C40A85551F0546F) #x74C1F8FFF5D0FD4D))
(constraint (= (f #x2F7659D917DA275C) #x02F7659D917DA274))
(constraint (= (f #xDFF9092B88B1C4B0) #x0DFF9092B88B1C4A))
(constraint (= (f #x2A6D32D980BAFC4F) #x7F47988C8230F4ED))
(constraint (= (f #x56C6B53E701026E7) #x04541FBB503074B5))
(constraint (= (f #xAB8FA5A9D5D6F80A) #x0AB8FA5A9D5D6F80))
(constraint (= (f #x0B2D10C0EC22B2BB) #x21873242C4681831))
(constraint (= (f #x0000000000000001) #x0000000000000000))
(check-synth)
(define-fun f_1 ((x (BitVec 64))) (BitVec 64) (ite (= (bvor #x0000000000000001 x) x) (ite (= #x0000000000000001 x) #x0000000000000000 (bvmul #x0000000000000003 x)) (ite (= (bvor #x0000000000000004 x) x) (bvnot (bvneg (bvudiv x #x0000000000000010))) (ite (= (bvor #x0000000000000002 x) x) (bvudiv x #x0000000000000010) (bvnot (bvneg (bvudiv x #x0000000000000010)))))))
