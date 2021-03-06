
(set-logic BV)


(define-fun origCir ( (LN1 Bool) (LN39 Bool) (k7 Bool) (LN48 Bool)  )  Bool    
          (xor (xor  LN39(and  LN1 k7 ) ) LN48 )
)


(synth-fun skel ( (LN1 Bool) (LN39 Bool) (k7 Bool) (LN48 Bool)  )  Bool    
          ((Start Bool (
		                                  (and depth1 depth1)
		                                  (not depth1)
		                                  (or depth1 depth1)
		                                  (xor depth1 depth1)
          ))
          (depth1 Bool (
		                                  (and depth2 depth2)
		                                  (not depth2)
		                                  (or depth2 depth2)
		                                  (xor depth2 depth2)
          ))
          (depth2 Bool (
		                                  (and depth3 depth3)
		                                  (not depth3)
		                                  (or depth3 depth3)
		                                  (xor depth3 depth3)
          ))
          (depth3 Bool (
		                                  (and depth4 depth4)
		                                  (not depth4)
		                                  (or depth4 depth4)
		                                  (xor depth4 depth4)
          ))
          (depth4 Bool (
		                                  (and depth5 depth5)
		                                  (not depth5)
		                                  (or depth5 depth5)
		                                  (xor depth5 depth5)
          ))
          (depth5 Bool (
		                                  (and depth6 depth6)
		                                  (not depth6)
		                                  (or depth6 depth6)
		                                  (xor depth6 depth6)
          ))
          (depth6 Bool (
		                                  (and depth7 depth7)
		                                  (not depth7)
		                                  (or depth7 depth7)
		                                  (xor depth7 depth7)
		                                  LN39
          ))
          (depth7 Bool (
		                                  (and depth8 depth8)
		                                  (not depth8)
		                                  (or depth8 depth8)
		                                  (xor depth8 depth8)
		                                  LN1
		                                  LN48
          ))
          (depth8 Bool (
		                                  k7
          )))
)


(declare-var LN1 Bool)
(declare-var LN39 Bool)
(declare-var k7 Bool)
(declare-var LN48 Bool)

(constraint (= (origCir LN1 LN39 k7 LN48 ) (skel LN1 LN39 k7 LN48 )))


(check-synth)

(define-fun skel_1 ((LN1 Bool) (LN39 Bool) (k7 Bool) (LN48 Bool)) Bool (not (not (not (not (xor (xor (and (and k7 k7) LN1) (not LN48)) (not LN39)))))))
