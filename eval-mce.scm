;;;;
;;;; Evaluator written in Scheme, without define, to run mce.scm
;;;;
;;;; This code is licensed under CC0.
;;;; https://creativecommons.org/publicdomain/zero/1.0/
;;;;

(display
 (((lambda (U) (U U))
   (lambda (U)
     (lambda (S E)
       (cond ((pair? S)
	      (let ((T (car S)) (V (cdr S)))
		(cond ((eq? T 'quote) (car V))
		      ((eq? T 'lambda) (append S `(,E)))
		      ((eq? T 'cond)
		       (((lambda (M) (M M))
			 (lambda (M)
			   (lambda (P E)
			     (cond ((null? P) '())
				   (((U U) (caar P) E) ((U U) (cadar P) E))
				   (else ((M M) (cdr P) E)))))) V E))
		      (else
		       (let ((F ((U U) T E))
			     (A (map (lambda (X) ((U U) X E)) V)))
			 (cond ((pair? F)
				((U U) (caddr F)
				 (append (map cons (cadr F) A) (cadddr F))))
			       ((eq? F 'car) (caar A))
			       ((eq? F 'cdr) (cdar A))
			       ((eq? F 'cons) (cons (car A) (cadr A)))
			       ((eq? F 'eq?) (eq? (car A) (cadr A)))
			       ((eq? F 'pair?) (pair? (car A)))))))))
             (else (cond ((memq S '(car cdr cons eq? pair? else)) S)
			 (else (cdr (assq S E)))))))))
  (call-with-input-file "mce.scm" read) '())) (newline)
