(load "src/Problem_Set_02.scm")

;; helpers
(define (id x) x)
(define (next x) (+ x 1))
(define PI 3.14159)

(in-test-group
  Problem_Set_02
  (define-each-test
    (assert-= 6 (sum id 0 next 3) "ex 1.30: write a higher-order 'sum' function using iteration")
    (assert-= 120 (product id 1 next 5) "ex: 1.31: write a higher-order 'product' function")
    (assert-= 3628800 (factorial 10) "ex: 1.31: write 'factorial' in terms of 'product'")
    (assert-equal #t (< (abs (- PI (wallis-product))) 0.001) "ex: 1.31: write a 'wallis-product' function to approximate PI using 'product'")))
