((lambda (ASSQ CONS CAR CDR C3) ;;;; => Y
   (CDR (ASSQ (quote B)
	      (C3 (CONS (quote A) (quote X))
		  (CONS (quote B) (quote Y))
		  (CONS (quote C) (quote Z)) CONS)
	      CAR CDR CONS)))
 ((lambda (U) (U U))
  (lambda (U)
    (lambda (K V CAR CDR CONS)
      (if (eq? V (quote ())) (quote ())
	  (if (eq? K (CAR (CAR V))) (CAR V)
	      ((U U) K (CDR V) CAR CDR CONS))))))
 (lambda (X Y) (lambda (F) (F X Y)))
 (lambda (C) (C (lambda (X Y) X)))
 (lambda (C) (C (lambda (X Y) Y)))
 (lambda (A B C CONS) (CONS A (CONS B (CONS C (quote ()))))))
