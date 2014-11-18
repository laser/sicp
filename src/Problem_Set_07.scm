;; Exercise 3.1
(define (make-accumulator start)
  (let ((val start))
    (lambda (newval)
      (begin (set! val (+ val newval))
             val))))

;; Exercise 3.2
(define (make-monitored fn)
  (let ((count 0)
        (monitored-fn fn))
    (define (call-fn x)
      (begin (set! count (+ count 1))
             (monitored-fn x)))
    (define (how-many-calls?)
      count)
    (define (reset-count)
      (begin (set! count 0)
             count))
    (define (dispatch x)
      (cond ((eq? x 'how-many-calls?) (how-many-calls?))
            ((eq? x 'reset-count) (reset-count))
            (else (call-fn x))))
    dispatch))

;; Exercise 3.5
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (area x1 x2 y1 y2) (* (- x1 x2) (- y1 y2)))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (P (random-in-range x2 x1)
       (random-in-range y2 y1)))
  (* (monte-carlo trials experiment)
     (area x1 x2 y1 y2)))

;; Exercise 3.3, 3.7
(define (check-password password protected)
  (let ((count 0))
    (lambda (attempt m)
      (if (eq? attempt password)
          (begin (set! count 0)
                 (protected m))
          (begin (set! count (+ count 1))
                 (if (> count 6) "calling the cops")
                 (lambda (arg . args) "Incorrect password"))))))

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)))
  (check-password password dispatch))

(define (make-joint acc original new)
  (define (dispatch msg)
    (acc original msg))
  (check-password new dispatch))
