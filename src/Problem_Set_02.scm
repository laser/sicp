;; Pset 2
;;
;;

(define (id x) (identity x))

(define (next x) (+ x 1))

(define (square x) (* x x))

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

(define (wallis-product)
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

(wallis-product)

;;;b.
(define (product2 term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

;;;
