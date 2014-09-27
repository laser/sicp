;; Pset 1
;;
;;

(define p1
  (lambda (x y)
    (+ (p2 x y) (p3 x y))))

(define p2
  (lambda (z w)
    (* z w)))

(define p3
  (lambda (a b)
    (+ (p2 a) (p2 b))))

(define fold
  (lambda (x y)
    (* (spindle x)
       (+ (mutilate y) (spindle x))
    )
  )
)

(define spindle
  (lambda (w) (* w w)))

(define mutilate
  (lambda (z)
    (+ (spindle z) z)))

(define fact
  (lambda (n)
    (if (= n 0) 1 (* n (fact (- n 1))))))

(define comb
  (lambda (n k)
    (/ (fact n) (* (fact k) (fact (- n k))))))

(define raise
  (lambda (n pow)
    (cond ((= pow 0) 1)
          ((= pow 1) n)
          (else (* n (raise n (- pow 1)))))))

(define square
  (lambda (n)
    (raise n 2)))

(define cube
  (lambda (n)
    (raise n 3)))

(define sum-of-cubes
  (lambda (x y)
    (+ (cube x) (cube y))))

(define biggest
  (lambda (x y)
    (if (> x y) x y)))

(define biggest-of-three
  (lambda (x y z)
    (biggest x (biggest y z))))

(define cube-biggest-of-three
  (lambda (x y z)
    (cube (biggest-of-three x y z))))

(define f
  (lambda (x a0 a1 a2 a3)
    (+ a0 (* a1 x) (* a2 (square x)) (* a3 (cube x)))))
