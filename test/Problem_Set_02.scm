(load "src/Problem_Set_02.scm")

;; helpers
(define (id x) x)
(define (next x) (+ x 1))
(define PI 3.14159)
(define (one x) 1)

(in-test-group
  Problem_Set_02
  (define-each-test
    (assert-= 6 (sum id 0 next 3) "ex 1.30: write a higher-order 'sum' function using iteration")
    (assert-= 120 (product id 1 next 5) "ex: 1.31: write a higher-order 'product' function")
    (assert-= 3628800 (factorial 10) "ex: 1.31: write 'factorial' in terms of 'product'")
    (assert-= 120 (product-rec id 1 next 5) "ex: 1.31b: write a higher-order recursive 'product' function")
    (assert-= 6 (sum-rec id 0 next 3) "ex 1.32b: write a higher-order recursive 'sum' function using iteration")
    (assert-equal 30 (even-sum id 0 next 10) "ex 1.33: filtered-accumulate")
    (assert-true (< (abs (- PI (wallis-product))) 0.001) "ex: 1.31: write a 'wallis-product' function to approximate PI using 'product'")
    (assert-equal 625 ((repeated square 2) 5) "Problem 5: evaluate")
    (assert-equal 4294967296 ((repeated square 5) 2) "Problem 5: evaluate")
    (assert-true (< (abs (- 0.618 (cont-frac-i one one 10))) .0001) "Sufficiently close to the golden ratio approximation of 0.618")
    (assert-true (< (abs (- PI (estimate-pi 997))) .001) "Brouncker's approximation should be good to 3 decimal places")
  )
  (define-test (atan-tests)
    (define (compare k x) (< (abs (- (atan x) (atan-cf k x))) .001))
    (assert-true (compare 4 1) "Scheme's atan(1) vs our atan(1)")
    (assert-true (compare 39 10) "Scheme's atan(10) vs our atan(10)")
  )
)
