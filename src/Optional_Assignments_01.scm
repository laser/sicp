;; Exercise 1.2
;; Translate the expression into prefix form
(define (prob-1-2)
  (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7))))

;; Exercise 1.3
;; Takes three numbers. Returns the sum of squares of the larger two numbers.
(define biggest-of-two
  (lambda (x y)
    (if (> x y) x y)))

(define sum-of-squares
  (lambda (x y)
    (+ (* x x) (* y y))))

(define largest-squares-sum
  (lambda (x y z)
    (if (= x (biggest-of-two x y))
        (sum-of-squares x (biggest-of-two y z))
        (sum-of-squares y (biggest-of-two x z)))))
