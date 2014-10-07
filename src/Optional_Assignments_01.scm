;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1.1.6 (Conditional Expressions and Procedures)
;;
;;

;; Exercise 1.4
;;
;;
(define a-plus-abs-b
  (lambda (a b)
    ((if (< b 0) - +) a b)))

;; Exercise 1.5
;;
;; Q: What behavior is observed with an interpreter that
;; uses applicative-order evaluation? What about normal-
;; order evaluation?
;;
;; (test 0 (p))
;;
;; A: Applicative-order evaluation will never terminate,
;; since p will be evaluated, which is defined in terms of
;; itself. With normal-order evaluation, p would not be
;; called unless it was needed.
(define (p) (p))

(define (test x y)
  (if (= x 0) 0 y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1.1.7 (Square Roots by Newton's Method)
;;
;;

;; Exercise 1.7
;;
;;

;; Improve a guess by averaging the guess and the result
;; of dividing the radicand by the guess.
;;

(define (find-square-root x)
  (define (sqrtz guess x)
    (define (improve guess x)
      (/ (+ guess (/ x guess)) 2))
    (define (good-enough? guess x)
      (< (/ (abs (- (* guess guess) x)) guess) 0.001))
    (if (good-enough? guess x)
      guess
      (sqrtz (improve guess x) x)))
  (sqrtz 1.0 x))


;; Exercise 1.8
;;
;; Write a function that finds the cube-root of a given
;; number. The "improve" function is given.

(define (find-cube-root x)
  (define (cubez guess x)
    (define (improve guess x)
      (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
    (define (good-enough? guess x)
      (< (/ (abs (- (* guess guess guess) x)) guess) 0.001))
    (if (good-enough? guess x)
      guess
    (cubez (improve guess x) x)))
  (cubez 1.0 x))
