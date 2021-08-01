(define (S2C-T s)
  (cond ((eq? s (quote ())) `(quote ()))
        ((pair? s) `(CS ,(S2C-T (car s)) ,(S2C-T (cdr s))))
        (else `(quote ,s))))

(display (S2C-T (call-with-input-file "sample.scm" read))) (newline)

