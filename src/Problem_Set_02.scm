;; Pset 2
;;
;;
(define (id x) x)
(define (step n) (+ n 1))

;; 1.30: sum is defined using linear recursion:
;;
;; (define (sum f a next b)
;;   (if (> a b)
;;     0
;;     (+ (f a)
;;        (sum f (next a) next b))))
;;
;; Can you redefine it to use iteration?
;;
(define (sum f a step b)
  (define (iter a result)
    (if (> a b)
      result
      (iter
        (step a)
        (+ result
           (f a)))))
  (iter a 0))

;; 1.31: Write an procedure called product that returns the
;; product of the values of a function at points over a
;; given range.
;;
(define (product f a step b)
  (define (iter a result)
    (if (> a b)
      result
      (iter
        (step a)
        (* result
           (f a)))))
  (iter a 1))

;; 1.31: Show how to define factorial in terms of product.
;;
(define (factorial n)
  (product id 1 step n))

;; 1.31: Use product to compute approximations to PI/4 using
;; Wallis' product:
;;
;; PI/4 = (/ (* 2 4 4 6 6 8) (* 3 3 5 5 7))
;;

(define (wallis-product)
  (define (wallify n)
    (* (/ (* 2 n) (- (* 2 n) 1)) (/ (* 2 n) (+ (* 2 n) 1))))
  (* 2 (product wallify 1 step 10000)))

;; 1.31b: Implement your product function using linear
;; recursion if you used iteration (or iteration if you
;; used linear recursion)
;;
(define (product-recur f a step b)
  (if (> a b)
    1
    (* (f a) (product f (step a) step b))))

;; 1.32 Write a function 'accumulate' that combines a
;; collection of terms. It should have the signature:
;;
;; (accumulate combiner null-value term a next b)
;;
(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
              (accumulate combiner null-value term (step a) next b))))

;; 1.33: Write a function 'filtered-accumulate' that takes
;; same arguments as accumulate, together with an
;; additional predicate of one argument that specifies the
;; filter to apply to values in the range.
;;
(define (filtered-accumulate predicate combiner null-value term a next b)
  (define (filter-term x)
    (if (predicate x) (term x) null-value))
  (accumulate combiner null-value filter-term a next b))

;; 1.33a: Use filtered-accumulate to compute the sum of the
;; squares of the prime numbers in the interval a to b.
;; Assume that 'prime?' has already been written.
;;
(define (prime? n)
  (if (even? n)
    #f
    (filtered-accumulate
      odd?
      (lambda (x y) (and x y))
      #t
      (lambda (x) (= 1 (gcd x n)))
      1
      step
      (sqrt n))))

(define (sum-squares-primes a b)
  (filtered-accumulate prime? + 0 (lambda (x) (* x x)) a step b))

;; 1.33b: Use filtered-accumulate to compute the product of
;; all the positive integers less than n that are
;; relatively prime to n (i.e., all positive integers i < n
;; such that GCD(i, n) = 1.
;;
(define (product-positive-integers-relatively-prime n)
  (filtered-accumulate (lambda (x) (= 1 (gcd x n))) * 1 id 1 step (- n 1)))

;; Ex 5: Procedure 'repeated' is defined as
;;
(define (repeated p n)
  (cond ((= n 0) (lambda (x) x))
        ((= n 1) p)
        (else (lambda (x) (p ((repeated p (- n 1)) x))))))

;; Determine the value of the expressions:
;; ((repeated square 2) 5)
;;
;(((lambda (x) (square ((repeated square (-n 1)) x)))))
;(((lambda (x) (square (square x)))))
;(square (square 5))
;625

;;((repeated square 5) 2)
;;(((lambda (x) (square ((repeated square (1)) x)))))
;;(((lambda (x) (square (square (square (square (square 2))))))))
;;4294967296


;; Ex 6: Suppose that 'n' and 'd' are procedures of one
;; argument (the term index) that return the n_i and d_i of
;; the terms of the continued fraction.
;;
;;(define (f (/ n1 (+ d1 (n2 / (+ d2 (n3 / (+ d3 ...))))))))
;;
;; Define procedures 'cont-frac-recur' and 'cont-frac-iter'
;; such that evaluating (cont-frac-recur n d k) and
;; (cont-frac-iter n d k) each compute the value of the
;; k-term finite continued fraction. Check your procedures
;; by approximating 1/THETA using:
;;
;; (cont-frac (lambda (i) 1) (lambda (i) 1) k)
;;
;; ...for successive values of k. How large must you make
;; k in order to get an approximation that is accurate to 4
;; decimal places?
;;
;; requires 8 iterations
(define (cont-frac-iter n d k)
  (define (iter a result)
    (if (> a k)
      result
      (/
        (n a)
        (+
          (d a)
          (iter (+ a 1) result)))))
  (iter 1 0))

;; requires 8 iterations
(define (cont-frac-recur n d k)
  (if (= k 0)
    0
    (/
      (n k)
      (+
        (d k)
        (cont-frac-recur n d (- k 1))))))

;; Ex 7: For approximating PI using the Brouncker formula:
;;
(define (estimate-pi k)
  (/ 4 (+ (brouncker k) 1)))

(define (square x) (* x x))

(define (brouncker k)
  (cont-frac-iter (lambda (i) (square (- (* 2 i) 1)))
                  (lambda (i) 2)
                  k))

(define (estimate-pi-recur k)
  (/ 4 (+ (brouncker-recur k) 1)))

(define (brouncker-recur k)
  (cont-frac-recur (lambda (i) (square (- (* 2 i) 1)))
                   (lambda (i) 2)
                   k))

;; Ex 8/9: Define a procedure (atan-cf k x) that computes
;; an approximation to the inverse tangent function based
;; on a k-term continued fraction representation of arctan
;; x given as:
;;
;; arctan x = (/ x (+ 1 (/ (square (* 1 x)) (+ 3 (/ (square (* 2 x)) ...
;;
(define (arctan-cf k x)
  (define (n i)
    (if (= i 1)
      x
      (square (* (- i 1) x))))
  (define (d i)
    (if (= i 1)
      1
      (- (* 2 i) 1)))
  (cont-frac-iter n d k))
