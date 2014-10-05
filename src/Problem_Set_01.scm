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
       (+ (mutilate y)
	  (spindle x)))))

(define spindle
  (lambda (w) (* w w)))

(define mutilate
  (lambda (z)
    (+ (spindle z) z)))

(define fact
  (lambda (n)
    (if (= n 0)
      1
	   (* n (fact (- n 1))))))

(define comb
  (lambda (n k)
    (/
      (fact n)
      (* (fact k) (fact (- n k))))))

(define cube
  (lambda (x)
    (* x x x)))

(define sum-of-cubes
  (lambda (x y)
    (+ (cube x) (cube y))))

(define biggest-of-three max)

(define cube-biggest-of-three
  (lambda (x y z)
    (biggest-of-three (cube x) (cube y) (cube z))))

(define f
  (lambda (x a b c d e)
    (+
      a
      (* b x)
      (* c (square x))
      (* d (cube x)))))