(define (list-union l1 l2)
  (cond ((null? l1) l2)
        ((member (car l1) l2)
         (list-union (cdr l1) l2))
        (else
         (cons (car l1)
               (list-union (cdr l1) l2)))))

(define (list-intersection l1 l2)
  (cond ((null? l1) '())
        ((member (car l1) l2)
         (cons (car l1)
               (list-intersection (cdr l1) l2)))
        (else (list-intersection (cdr l1) l2))))

(define (reduce combiner initial-value list)
  (define (loop list)
    (if (null? list)
        initial-value
        (combiner (car list) (loop (cdr list)))))
  (loop list))

; by making each symbol a list, list-union will remove duplicates without removing subsets
; i.e. 3 from '(1 2 3) but nothing from ((+ 3 4) (* 3 4))
(define (proc symbols)
  (reduce list-union
          '()
          (map list symbols)))
