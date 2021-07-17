# Meta-Circular Evaluator by using lambda with lexical scope

## mce.scm

This Scheme code is a Meta-Circular Evaluator, JUST by using the following special forms and builtin functions, **without *define* special form**.

* Special forms: `lambda` with lexical scope, `quote`, `cond`
* Builtin functions: `car`, `cdr`, `cons`, `eq?`, `pair?`

U combinators are mainly used to implement Eval, Apply and other utilities.

## mcemce.scm

This code is derived from mce.scm and shows the Meta-Circular Evaluator on the Meta-Circular Evaluator.

## Quine code

* GNU Guile, Chibi-Scheme, SCM

```
((lambda (X) (cons X (cons (cons (quote quote) (cons X (quote ()))) (quote ())))) (quote (lambda (X) (cons X (cons (cons (quote quote) (cons X (quote ()))) (quote ()))))))
```

* Gauche, Racket

```
((lambda (X) (cons X (cons (cons 'quote (cons X '())) '())))
 '(lambda (X) (cons X (cons (cons 'quote (cons X '())) '()))))
```

## Licence

The codes in this repository are licensed under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

