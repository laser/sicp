(load "src/Optional_Assignments_03.scm")
(in-test-group
 Optional_Assignments_03
 (define-each-test
   (assert-equal -2 (numer (make-rat 2 -3)) "prove negatives get moved to the numerator")
   (assert-equal 2 (numer (make-rat 4 6)) "prove GCD gets applied")
   (assert-equal '(34) (last-pair '(23 72 149 34)) "the last element as a list")
   (assert-equal '() (last-pair '()) "null check")
   (assert-equal '(4 3 2 1) (reverse '(1 2 3 4)) "reverse list")
   (assert-equal '(1 3 5) (same-parity 1 2 3 4 5 6) "find all the odds")
 )
)
