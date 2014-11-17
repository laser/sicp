;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Exercise 3.1
;
; Define (make-accumulator n) to return
; a function that, when called multiple
; multiple times with arguments m1, m2, m3...
; returns n+m1, n+m1+m2, n+m1+m2+m3...
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-accumulator n)
  (let ((acc n))
    (lambda (m)
      (begin (set! acc (+ acc m)) acc))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Exercise 3.2
;
; A procedure that takes as input a procedure,
; f, that itself takes one input. The result
; returned by make-monitored is a third procedure,
; say mf, that keeps track of the number of
; times it has been called by maintaining an
; internal counter. If the input to mf is the
; special symbol how-many-calls?, then mf returns
; the value of the counter. If the input is
; the special symbol reset-count, then mf resets
; the counter to zero. For any other input,
; mf returns the result of calling f on that
; input and increments the counter.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-monitored f)
  (let ((count 0))
    (lambda (x)
      (cond
        ((eq? x 'how-many-calls?) count)
        ((eq? x 'reset-count) (set! count 0))
        (else (begin (set! count (+ count 1)) (f x)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Exercise 3.3
;
; Write a password protected make-account
; that requires a password prior to the method.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-account balance password)
  (define passwords (list password))
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (join new-password)
    (set! passwords (cons new-password passwords))
    dispatch)
  (define (dispatch password-guess m)
    (cond
      ((not (memq password-guess passwords)) (lambda (x) "Incorrect password"))
      ((eq? m 'withdraw) withdraw)
      ((eq? m 'deposit) deposit)
      ((eq? m 'join) join)
      (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Exercise 3.5
;
; Estimate the area of an area defined by a
; predicate within a given region using
; the monte carlo technique.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (area x1 x2 y1 y2) (* (- x1 x2) (- y1 y2)))

(define (integral-sample predicate x1 x2 y1 y2)
  (lambda () (predicate
    (+ x2 (* (random (- x1 x2))))
    (+ y2 (* (random (- y1 y2)))))))

(define (estimate-integral predicate x1 x2 y1 y2 trials)
  (*
    (monte-carlo trials (integral-sample predicate x1 x2 y1 y2))
    (area x1 x2 y1 y2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Exercise 3.7
;
; Create a joint account with multiple passwords.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-joint account existing-password new-password)
  ((account existing-password 'join) new-password))

