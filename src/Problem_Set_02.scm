;; Pset 2
;;
;;

(define (id x) (identity x))

(define (next x) (+ x 1))

(define (square x) (* x x))

(define (evne? x) (= 0 (remainder x 2)))

;; 1.30
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

;(= 6 (sum id 0 next 3))

;; 1.31
;;;a.
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

;(= 120 (product id 1 next 5))

(define (factorial x)
  (product id 1 next 10))

;(factorial 10)

(define (wallis-product2)
  (* 4 (product (lambda (x) (/ (* x (+ x 2.0))
                               (square (+ x 1.0))))
                2
                (lambda (x) (+ x 2.0))
                10000)))

;;; This was hard. I had to cheat. In retrospect, knowing that wallis's research was basically the following would have been helpful.
;;; (*
;;; (/ 8 9)
;;; (/ 24 25)
;;; (/ 48 49)
;;; (/ 80 81)
;;; (/ 99 100)
;;; ...)

;;; Wrote a wallis product that was more readable (thanks Neil!)
(define (wallis-product)
  (* 4 (product (lambda (x)
                  (if (even? x)
                      (/ x (+ x 1.0))
                      (/ (+ x 1) x)))
                2
                (lambda (x) (+ x 1.0))
                10000)))

;;;b.
(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

;; 1.32
;;; a.
(define (accumulate combiner null-value term a next b)
  (define (accu-iter a result)
    (if (> a b)
        result
        (accu-iter (next a) (combiner (term a) result))))
  (accu-iter a null-value))

(define (sum-accu term a next b)
  (accumulate + 0 term a next b))

(define (sum-rec term a next b)
  (accumulate-rec + 0 term a next b))

;;; b.
(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-rec combiner null-value term (next a) next b))))

;; 1.33
(define (filtered-accumulate filter combiner nv term a next b)
  (define (accu-iter a result)
    (if (> a b)
        result
        (accu-iter (next a) (combiner (if (filter a) (term a) nv) result))))
  (accu-iter a nv))

(define (even-sum term a next b)
  (filtered-accumulate even? + 0 term a next b))

;;; a.
;;; (filtered-accumulate prime? + 0 square a next b)
;;; ^^ I don't have a prime? predicate defined

;; Exercise 5
(define (repeated p n)
  (cond ((= n 0) (lambda (x) x))
        ((= n 1) p)
        (else (lambda (x) (p ((repeated p (- n 1)) x))))))

;; (= 4294967296 ((repeated square 5) 2))

;; (= 625 ((repeated square 2) 5))

;; Exercise 6

(define (cont-frac-i n d k)
  (define (cf-iter cnt result)
    (if (= cnt 0)
        result
        (cf-iter (- cnt 1) (/ (n cnt) (+ (d cnt) result)))))
  (cf-iter k 0))

;;; The math on the recursive version doesn't seem to equal the iterative one...??

(define (cont-frac-r n d k)
  (define (recursive n d k cnt)
   (if (= cnt k)
       0
       (/ (n cnt) (+ (d cnt) (recursive n d k (+ cnt 1))))))
  (recursive n d k 1))

;; Exercise 7

(define (brouncker k)
  (cont-frac-i (lambda (i) (square (- (* 2 i) 1)))
               (lambda (i) 2)
               k))

(define (estimate-pi k)
  (/ 4 (+ (brouncker k) 1)))

;; Exercise 8

(define (atan-cf k x)
  (cont-frac-i (lambda (i) (if (= i 1) x (square (* (- i 1) x))))
               (lambda (i) (- (* i 2) 1))
               k))

;; Exercise 9

(define (test-tangent x times)
  (< (abs (- (atan x) (atan-cf times x))) .0001))

;;; The following is true
(test-tangent 30 155)

;; Exercise 10
