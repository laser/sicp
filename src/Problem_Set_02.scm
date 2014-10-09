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
(define (map-accum-range-iter f a step b seed combine)
  (define (iter a result)
    (if (> a b)
      result
      (iter
        (step a)
        (combine result
                 (f a)))))
  (iter a seed))

(define (sum f a next b)
  (map-accum-range-iter f a next b 0 +))

;; 1.31: Write an procedure called product that returns the
;; product of the values of a function at points over a
;; given range.
;;
(define (product f a next b)
  (map-accum-range-iter f a next b 1 *))

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
(define (map-accum-range-recur f a step b acc combine)
  (if (> a b)
    acc
    (combine (f a)
       (map-accum-range-recur f (step a) step b acc combine))))

(define (product-2 a next b)
  (map-accum-range-recur f a next b 1 *))
