;;;;
;;;; Meta-Circular Evaluator in Scheme, JUST by using:
;;;; [special forms] lambda with lexical scope, quote, cond
;;;; [builtin functions] car, cdr, cons, eq?, pair?
;;;;
;;;; This code is Licensed under CC0.
;;;; https://creativecommons.org/publicdomain/zero/1.0/
;;;;

((lambda (EVL APY APD ALS ASQ ECD EAG S)
   (EVL S
	(quote ;;;; initial env
	 ((car . car) (cdr . cdr) (cons . cons) (eq? . eq?) (pair? . pair?)))
	APD ALS ASQ ECD EAG APY))

 ((lambda (U) (U U)) ;;;; EVL: eval
  (lambda (U)
    (lambda (S E APD ALS ASQ ECD EAG APY)
      (cond ((pair? S)
             (cond ((eq? (car S) (quote quote))
		    (car (cdr S)))
		   ((eq? (car S) (quote cond))
		    (ECD (cdr S) E U APD ALS ASQ ECD EAG APY))
		   ((eq? (car S) (quote lambda))
		    (APD S (cons E (quote ()))))
		   (else (APY ((U U) (car S) E APD ALS ASQ ECD EAG APY)
			      (EAG (cdr S) E U APD ALS ASQ ECD EAG APY)
			      U APD ALS ASQ ECD EAG APY))))
            (else (cdr (ASQ S E)))))))

 (lambda (F A U APD ALS ASQ ECD EAG APY) ;;;; APY: apply
   (cond
    ((pair? F)
     ((U U) (car (cdr (cdr F)))
      (APD (ALS (car (cdr F)) A)
	   (car (cdr (cdr (cdr F))))) APD ALS ASQ ECD EAG APY))
    ((eq? F (quote car))   (car (car A)))
    ((eq? F (quote cdr))   (cdr (car A)))
    ((eq? F (quote cons))  (cons (car A) (car (cdr A))))
    ((eq? F (quote eq?))   (eq? (car A) (car (cdr A))))
    ((eq? F (quote pair?)) (pair? (car A)))))
 
 ((lambda (U) (U U)) ;;;; APD: append equivalent
  (lambda (U)
    (lambda (A B)
      (cond ((eq? A (quote ())) B)
	    (else (cons (car A) ((U U) (cdr A) B)))))))
 
 ((lambda (U) (U U)) ;;;; ALS: make alist
  (lambda (U)
    (lambda (A B)
      (cond ((eq? A (quote ())) (quote ()))
	    ((eq? B (quote ())) (quote ()))
	    (else (cons (cons (car A) (car B))
			((U U) (cdr A) (cdr B))))))))

 ((lambda (U) (U U)) ;;;; ASQ: assq equivalent
  (lambda (U)
    (lambda (K V)
      (cond ((eq? V (quote ())) (quote ()))
	    ((eq? K (car (car V))) (car V))
	    (else ((U U) K (cdr V)))))))

 ((lambda (M) (M M)) ;;;; ECD: eval cond-ret lists
  (lambda (M)
    (lambda (P E U APD ALS ASQ ECD EAG APY)
      (cond ((eq? P (quote ())) (quote ()))
	    ((eq? (car (car P)) (quote else))
	     ((U U) (car (cdr (car P))) E APD ALS ASQ ECD EAG APY))
	    (((U U) (car (car P)) E APD ALS ASQ ECD EAG APY)
	     ((U U) (car (cdr (car P))) E APD ALS ASQ ECD EAG APY))
	    (else ((M M) (cdr P) E U APD ALS ASQ ECD EAG APY))))))

 ((lambda (M) (M M)) ;;;; EAG: eval args
  (lambda (M)
    (lambda (A E U APD ALS ASQ ECD EAG APY)
      (cond ((eq? A (quote ())) (quote ()))
	    (else (cons ((U U) (car A) E APD ALS ASQ ECD EAG APY)
			((M M) (cdr A) E U APD ALS ASQ ECD EAG APY)))))))

 '(((lambda (U) (U U)) ;;;; S: sample code
    (lambda (U)
      (lambda (X R)
	(cond ((eq? X (quote ())) R)
	      (else
	       ((U U) (cdr X) (cons X R)))))))
   (quote (O O O O O))
   (quote ())) ;;;; => ((O) (O O) (O O O) (O O O O) (O O O O O))

 )
