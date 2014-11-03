(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else
         (cons (car set1) (union-set (cdr set1) set2)))))

; allow duplicates
(define (adjoin-set2 x set)
  (cons x set))

; allow duplicates in union
(define (union-set2 set1 set2)
  (append set1 set2))

; Ordered set stuff
(define (element-of-ordered-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-of-ordered-sets set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-of-ordered-sets (cdr set1)
                                                      (cdr set2))))
              ((< x1 x2)
               (intersection-of-ordered-sets (cdr set1) set2))
              ((> x1 x2)
               (intersection-of-ordered-sets set1 (cdr set2)))))))

(define (adjoin-to-ordered-set x set)
  (cond ((null? set) (list x))
        ((< x (car set)) (cons x set))
        ((= x (car set)) set)
        (else (cons (car set) (adjoin-to-ordered-set x (cdr set))))))

(define (union-of-ordered-sets set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1)) (x2 (car set2)))
           (cond ((= x1 x2) (cons x1 (union-of-ordered-sets (cdr set1) (cdr set2))))
                 ((< x1 x2) (cons x1 (union-of-ordered-sets (cdr set1) set2)))
                 ((> x1 x2) (cons x2 (union-of-ordered-sets set1 (cdr set2)))))))))
