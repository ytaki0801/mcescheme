# Meta-Circular Evaluator by using lambda with lexical scope

## mce.scm, mcemce.scm

`mce.scm` is a Meta-Circular Evaluator, just by using the following special forms and builtin functions in Scheme, **without *define* special form**.

* Special forms: `lambda` with lexical scope, `quote`, `cond`
* Builtin functions: `car`, `cdr`, `cons`, `eq?`, `pair?`

U combinators are mainly used to implement Eval, Apply and other utilities.

`mcemce.scm` is derived from `mce.scm` and shows the Meta-Circular Evaluator on the Meta-Circular Evaluator.

## eval-mce.scm

`eval-mce.scm` is a short Scheme code of Evaluator to run `mce.scm`, by using the above 8 basics with single quote notation as `quote`, `let`, `append`, `null?`, `map`, `memq`, `assq`, `call-with-input-file`, `read`, `display`, `newline` and utility accessors, without *define* special form. It is just a reference implementation.

## Quine code for mce.scm

* GNU Guile, Chibi-Scheme, SCM

```
((lambda (X) (cons X (cons (cons (quote quote) (cons X (quote ()))) (quote ())))) (quote (lambda (X) (cons X (cons (cons (quote quote) (cons X (quote ()))) (quote ()))))))
```

* Gauche, Racket

```
((lambda (X) (cons X (cons (cons 'quote (cons X '())) '())))
 '(lambda (X) (cons X (cons (cons 'quote (cons X '())) '()))))
```

## mce2.scm, S2C.scm, ASSQ-sample.scm, mce2mce2.com

`mce2.scm` is a Meta-Circular Evaluator, just by using `lambda`, `quote`, `if`, `eq?` and `procedure?`. Lambda expressions as closures are used to implement `cons` equivalent. `S2C.scm` is a translator to derive from S-expression code to `cons` equivalent code. `ASSQ-sample.scm` is a sample code for `mce2.scm` before translating.

`mce2mce2.scm` is derived from `mce2.scm` and shows the Meta-Circular Evaluator on the Meta-Circular Evaluator.

## Licence

The codes in this repository are licensed under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

