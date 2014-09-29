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
(define (good-enough? guess x)
  (< (/ (abs (- (square guess) x)) guess) 0.001))

;; Improve a guess by averaging the guess and the result
;; of dividing the radicand by the guess.
;;
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

;; Recurse, improving guess if our guess was not good
;; enough.
;;
(define (sqrtz guess x)
  (if (good-enough? guess x)
    guess
    (sqrtz (improve guess x) x)))

(define (sqrt x)
  (sqrtz 1.0 x))
