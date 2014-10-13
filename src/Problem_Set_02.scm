; Exercise 1.30
(define (sum term a next b)
  (accumulate term a next b + 0))

; Exercise 1.31
(define (product term a next b)
  (accumulate term a next b * 1))

(define (term x) x)
(define (next x) (+ x 1))

(define (pi-term x)
  (if (even? x)
      (/ (+ x 2) (+ x 1))
      (/ (+ x 1) (+ x 2))))

; PI = 4 * (2/3 * 4/3 ...)
(define (wallis-product)
  (* (product pi-term 1 next 10000) 4))

(define (factorial x)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) x))

; Exercise 1.32
(define (accumulate term a next b combiner null-value)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

; Exercise 1.31b/32b
(define (sum-rec term a next b)
  (accumulate-rec term a next b + 0))

(define (product-rec term a next b)
  (accumulate-rec term a next b * 1))

(define (accumulate-rec term a next b combiner null-value)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-rec term (next a) next b combiner null-value))))

(define (filtered-accumulate term a next b combiner null-value filter)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (if (filter a)
                           (combiner (term a) result)
                           result))))
  (iter a null-value))

(define (even-sum term a next b)
  (filtered-accumulate term a next b + 0 even?))

(define (repeated p n)
  (cond
   ((= n 0) (lambda (x) x))
   ((= n 1) p)
   (else (lambda (x) (p ((repeated p (- n 1)) x))))))

(define (cont-frac-i n d k)
  (define (iter i res)
    (if (= i 0)
        res
        (iter (- i 1) (/ (n i) (+ (d i) res)))))
  (iter k 0))

; Helper function to find the answer required for HW
(define (find-golden-ratio k)
  (define (one x) 1)
  (if (< (abs (- 0.618 (cont-frac-i one one k))) 0.0001)
      k
      (find-golden-ratio (+ k 1))))

(define (estimate-pi k)
  (/ 4 (+ (brouncker k) 1)))

(define (square x) (* x x))

(define (brouncker k)
  (cont-frac-i (lambda (i) (square (- (* 2 i) 1)))
               (lambda (i) 2)
               k))

; Helper function to find the answer required for HW
(define (find-estimate-pi k)
  (if (< (abs (- 3.14159 (estimate-pi k))) 0.001)
      k
      (find-estimate-pi (+ k 1))))

(define (atan-cf k x)
  (define (N k) (square (* k x)))
  (define (D k) (+ (* 2 k) 1))
  (/ x (+ 1 (cont-frac-i N D k))))

(define (find-atan-k k x)
  (if (< (abs (- (atan x) (atan-cf k x))) 0.001)
      k
      (find-atan-k (+ k 1) x)))

(define (nested-acc op r term k)
  (define (nested-iter i)
    (if (> i k)
        r
        ((op i) (term i) (nested-iter (+ i 1)))))
    (nested-iter 1))

; for i = 1, we want to return sqrt, i = 2 a +, ...
; choose r value that doesn't affect the equation (in this case addition, so additive identity which is zero)
; for term, we're always return x
(define (square-root-acc k x)
  (nested-acc (lambda (i) (if (odd? i) (lambda (a b) (sqrt b)) +))
              0
              (lambda (i) x)
              k))

(define (build n d b)
  (/ n (+ d b)))

(define (repeated-build k n d b)
  ((repeated (lambda (x) (build n d x)) k) b))

(define (find-inverse-golden k)
  (if (< (abs (- 0.618 (repeated-build k 1 1 0))) 0.0001)
      k
      (find-inverse-golden (+ k 1))))

(define (r k)
  (lambda (x)
    (repeated-build k 1 1 x)))
