; https=//stackoverflow.com/questions/28616046/excel-substrings/28618923%28618923
(set-logic SLIA)
(synth-fun f ((_arg_0 String)) String 
 ( (Start String (ntString)) 
 (ntString String (
	_arg_0
	"" " " "0" "1" "4" "5" "9"
	(str.++ ntString ntString) 
	(str.replace ntString ntString ntString) 
	(str.at ntString ntInt)
	(int.to.str ntInt)
	(str.substr ntString ntInt ntInt)
)) 
 (ntInt Int (
	
	1 0 -1
	(+ ntInt ntInt)
	(- ntInt ntInt)
	(str.len ntString)
	(str.to.int ntString)
	(str.indexof ntString ntString ntInt)
)) 
 (ntBool Bool (
	
	true false
	(= ntInt ntInt)
	(str.prefixof ntString ntString)
	(str.suffixof ntString ntString)
	(str.contains ntString ntString)
)) ))
(constraint (= (f "valentine day=1915=50==7.1=45") "valentine day"))
(constraint (= (f "movie blah=2blahblah, The=1914=54==7.9=17") "movie blah=2blahblah, The"))
(check-synth)
(define-fun f1 ((_arg_0 String)) String (str.substr _arg_0 0 (+ (str.indexof _arg_0 "1" 0) -1)))
