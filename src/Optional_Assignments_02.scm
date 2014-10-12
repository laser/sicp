;; Exercise 1.10
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
;; f(n) = (A 0 n) => f(n) = 2*n
;; g(n) = (A 1 n) => g(n) = 2^n
;; h(n) = (A 2 n) => h(n) = 2^(2^...n times) i.e h(4) = 2^(2^(2^2)) = 2^(2^4) = 2^16 = 65536

;; Exercise 1.18
(define (fast-multiply a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (multiply-iter a b product)
    (cond
     ((= b 0) product)
     ((even? b) (multiply-iter (double a) (halve b) product))
     (else (multiply-iter a (- b 1) (+ a product)))))
  (multiply-iter a b 0)
)
