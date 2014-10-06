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
    (+ (p2 a b) (p2 b a))))

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
    (/ (fact n) (* (fact k) (fact (- n k))))))

(define cube
  (lambda (x)
    (* x x x)))

(define sum-of-cubes
  (lambda (x y)
    (+ (cube x) (cube y))))

(define biggest-of-two
  (lambda (x y)
    (if (> x y) x y)))

(define biggest-of-three
  (lambda (x y z)
    (biggest-of-two x (biggest-of-two y z))))

(define cube-biggest-of-three
  (lambda (x y z)
    (cube (biggest-of-three x y z))))

(define f
  (lambda (x a0 a1 a2 a3)
    (+ a0 (* a1 x) (* a2 x x) (* a3 (cube x)))))


