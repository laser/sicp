; If the denominator is negative, move the negative to the top (also cancels out double negatives)
(define (make-rat n d)
  (let ((g ((if (< d 0) - +) (gcd n d))))
    (cons (/ n g) (/ d g))))

(define (numer r)
  (car r))

(define (denom r)
  (cdr r))

(define (print-rat r)
  (display (numer r))
  (display "/")
  (display (denom r))
  (newline))

(define (last-pair l)
  (define (remaining-items l) (cdr l))
  (cond
   ((null? l) '())
   ((null? (remaining-items l)) l)
   (else (last-pair (remaining-items l)))))

(define (reverse l)
  (cond
   ((null? l) (list))
   ((null? (cdr l)) l)
   (else (append (reverse (cdr l)) (list (car l))))))

(define (same-parity first . rest)
  (define parity? (if (even? first) even? odd?))
  (define (iter r acc)
    (if (null? r)
        acc
        (iter (cdr r) (if (parity? (car r))
                          (cons (car r) acc)
                          acc))))
  (reverse (iter rest (list first))))
