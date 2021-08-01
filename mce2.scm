;;;;
;;;; Meta-Circular Evaluator in Scheme, JUST by using
;;;; lambda, quote, if, eq? and procedure?
;;;;
;;;; This code is licensed under CC0.
;;;; https://creativecommons.org/publicdomain/zero/1.0/
;;;;

((lambda (EV AY AP AL AQ EA CS LN L1 S)
   (EV (S CS) (quote ()) AY AP AL AQ EA CS LN L1))

 ((lambda (U) (U U)) ;;;; EV: eval
  (lambda (U)
    (lambda (S E AY AP AL AQ EA CS LN L1)
      (if (procedure? S)
	  (if (eq? (L1 S) (quote quote)) (L1 (LN S))
	      (if (eq? (L1 S) (quote if))
		  (if ((U U) (L1 (LN S)) E AY AP AL AQ EA CS LN L1)
		      ((U U) (L1 (LN (LN S))) E AY AP AL AQ EA CS LN L1)
		      ((U U) (L1 (LN (LN (LN S)))) E AY AP AL AQ EA CS LN L1))
		  (if (eq? (L1 S) (quote lambda))
		      (AP S (CS E (quote ())) CS LN L1)
		      (AY ((U U) (L1 S) E AY AP AL AQ EA CS LN L1)
			  (EA (LN S) E U AY AP AL AQ EA CS LN L1)
			  U AY AP AL AQ EA CS LN L1))))
	  (if (eq? S (quote eq?)) (quote eq?)
	      (if (eq? S (quote procedure?)) (quote procedure?)
		  (LN (AQ S E LN L1))))))))

 (lambda (F A U AY AP AL AQ EA CS LN L1) ;;;; AY: apply
   (if (procedure? F)
       ((U U) (L1 (LN (LN F)))
	(AP (AL (L1 (LN F)) A CS LN L1) (L1 (LN (LN (LN F)))) CS LN L1)
	AY AP AL AQ EA CS LN L1)
       (if (eq? F (quote eq?)) (eq? (L1 A) (L1 (LN A))) (procedure? (L1 A)))))

 ((lambda (U) (U U)) ;;;; AP: append equivalent
  (lambda (U)
    (lambda (A B CS LN L1)
      (if (eq? A (quote ())) B
	  (CS (L1 A) ((U U) (LN A) B CS LN L1))))))
 
 ((lambda (U) (U U)) ;;;; AL: make alist
  (lambda (U)
    (lambda (A B CS LN L1)
      (if (eq? A (quote ())) (quote ())
	  (if (eq? B (quote ())) (quote ())
	      (CS (CS (L1 A) (L1 B)) ((U U) (LN A) (LN B) CS LN L1)))))))

 ((lambda (U) (U U)) ;;;; AQ: assq equivalent
  (lambda (U)
    (lambda (K V LN L1)
      (if (eq? V (quote ())) (quote ())
	  (if (eq? K (L1 (L1 V))) (L1 V)
	      ((U U) K (LN V) LN L1))))))

 ((lambda (M) (M M)) ;;;; EA: eval args
  (lambda (M)
    (lambda (A E U AY AP AL AQ EA CS LN L1)
      (if (eq? A (quote ())) (quote ())
	  (CS ((U U) (L1 A) E AY AP AL AQ EA CS LN L1)
	      ((M M) (LN A) E U AY AP AL AQ EA CS LN L1))))))

 (lambda (X Y) (lambda (F) (F X Y))) ;;;; CS: cons
 (lambda (C) (C (lambda (X Y) Y))) ;;;; LN: cdr
 (lambda (C) (C (lambda (X Y) X))) ;;;; L1: car

 (lambda (CS) ;;;; S: sample code by closures

(CS (CS (quote lambda) (CS (CS (quote ASSQ) (CS (quote CONS) (CS (quote CAR) (CS (quote CDR) (CS (quote C3) (quote ())))))) (CS (CS (quote CDR) (CS (CS (quote ASSQ) (CS (CS (quote quote) (CS (quote B) (quote ()))) (CS (CS (quote C3) (CS (CS (quote CONS) (CS (CS (quote quote) (CS (quote A) (quote ()))) (CS (CS (quote quote) (CS (quote X) (quote ()))) (quote ())))) (CS (CS (quote CONS) (CS (CS (quote quote) (CS (quote B) (quote ()))) (CS (CS (quote quote) (CS (quote Y) (quote ()))) (quote ())))) (CS (CS (quote CONS) (CS (CS (quote quote) (CS (quote C) (quote ()))) (CS (CS (quote quote) (CS (quote Z) (quote ()))) (quote ())))) (CS (quote CONS) (quote ())))))) (CS (quote CAR) (CS (quote CDR) (CS (quote CONS) (quote ()))))))) (quote ()))) (quote ())))) (CS (CS (CS (quote lambda) (CS (CS (quote U) (quote ())) (CS (CS (quote U) (CS (quote U) (quote ()))) (quote ())))) (CS (CS (quote lambda) (CS (CS (quote U) (quote ())) (CS (CS (quote lambda) (CS (CS (quote K) (CS (quote V) (CS (quote CAR) (CS (quote CDR) (CS (quote CONS) (quote ())))))) (CS (CS (quote if) (CS (CS (quote eq?) (CS (quote V) (CS (CS (quote quote) (CS (quote ()) (quote ()))) (quote ())))) (CS (CS (quote quote) (CS (quote ()) (quote ()))) (CS (CS (quote if) (CS (CS (quote eq?) (CS (quote K) (CS (CS (quote CAR) (CS (CS (quote CAR) (CS (quote V) (quote ()))) (quote ()))) (quote ())))) (CS (CS (quote CAR) (CS (quote V) (quote ()))) (CS (CS (CS (quote U) (CS (quote U) (quote ()))) (CS (quote K) (CS (CS (quote CDR) (CS (quote V) (quote ()))) (CS (quote CAR) (CS (quote CDR) (CS (quote CONS) (quote ()))))))) (quote ()))))) (quote ()))))) (quote ())))) (quote ())))) (quote ()))) (CS (CS (quote lambda) (CS (CS (quote X) (CS (quote Y) (quote ()))) (CS (CS (quote lambda) (CS (CS (quote F) (quote ())) (CS (CS (quote F) (CS (quote X) (CS (quote Y) (quote ())))) (quote ())))) (quote ())))) (CS (CS (quote lambda) (CS (CS (quote C) (quote ())) (CS (CS (quote C) (CS (CS (quote lambda) (CS (CS (quote X) (CS (quote Y) (quote ()))) (CS (quote X) (quote ())))) (quote ()))) (quote ())))) (CS (CS (quote lambda) (CS (CS (quote C) (quote ())) (CS (CS (quote C) (CS (CS (quote lambda) (CS (CS (quote X) (CS (quote Y) (quote ()))) (CS (quote Y) (quote ())))) (quote ()))) (quote ())))) (CS (CS (quote lambda) (CS (CS (quote A) (CS (quote B) (CS (quote C) (CS (quote CONS) (quote ()))))) (CS (CS (quote CONS) (CS (quote A) (CS (CS (quote CONS) (CS (quote B) (CS (CS (quote CONS) (CS (quote C) (CS (CS (quote quote) (CS (quote ()) (quote ()))) (quote ())))) (quote ())))) (quote ())))) (quote ())))) (quote ())))))))

   ))

