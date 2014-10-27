;;; Scheme code for Twenty-One Simulator

(define (twenty-one player-strategy house-strategy)
  (let ((house-initial-hand (make-new-hand (deal))))
    (let ((player-hand
           (play-hand player-strategy
                      (make-new-hand (deal))
                      (hand-up-card house-initial-hand))))
      (if (> (hand-total player-hand) 21)
          0                                ; ``bust'': player loses
          (let ((house-hand
                 (play-hand house-strategy
                            house-initial-hand
                            (hand-up-card player-hand))))
            (cond ((> (hand-total house-hand) 21)
                   1)                      ; ``bust'': house loses
                  ((> (hand-total player-hand)
                      (hand-total house-hand))
                   1)                      ; house loses
                  (else 0)))))))           ; player loses

(define (play-hand strategy my-hand opponent-up-card)
  (cond ((> (hand-total my-hand) 21) my-hand) ; I lose... give up
        ((strategy my-hand opponent-up-card) ; hit?
         (play-hand strategy
                    (hand-add-card my-hand (deal))
                    opponent-up-card))
        (else my-hand)))                ; stay


(define (deal) (+ 1 (random 10)))

(define (make-new-hand first-card)
  (make-hand first-card first-card (list first-card)))

(define (make-hand up-card total card-list)
  (cons (cons up-card total)
        card-list))

(define (hand-up-card hand)
  (caar hand))

(define (hand-total hand)
  (cdar hand))

(define (hand-card-list hand)
  (cdr hand))

(define (hand-add-card hand new-card)
  (make-hand (hand-up-card hand)
             (+ new-card (hand-total hand))
             (cons new-card (hand-card-list hand))))

;;; The interactive strategy. Doesn't work in guile :(
(define (hit? your-hand opponent-up-card)
  (newline)
  (display "Opponent up card ")
  (display opponent-up-card)
  (newline)
  (display "Your Total: ")
  (display (hand-total your-hand))
  (newline)
  (display "Your Card List: ")
  (display (hand-card-list your-hand))
  (newline)
  (user-wants-hit?))

(define (user-wants-hit?)
  (let ((x (prompt-for-command-char "Hit? ")))
    (display x)
    (eq? x '#\y))) ;prompt-for-command char returns #\ before char

;;; Exercise 3
(define (stop-at limit)
  (lambda (your-hand opponent-up-card)
    (< (hand-total your-hand) limit)))

;;; Exercise 4
(define (test-strategy s1 s2 times)
  (define (ts t result)
    (if (= t 0)
        result
        (ts (- t 1) (+ result (twenty-one s1 s2)))))
  (ts times 0))

;;; This is roughly half-half. Sometimes I win, sometimes the house wins
;; (test-strategy (stop-at 16) (stop-at 15) 1000)

;;; Exercise 5
(define (watch-player strategy)
  (lambda (your-hand opponent-up-card)
    (let ((hit? (strategy your-hand opponent-up-card)))
      (display "Opponent up card ")
      (display opponent-up-card)
      (newline)
      (display "Your Total: ")
      (display (hand-total your-hand))
      (newline)
      (display "Strategy says: ")
      (display (if hit? "hit me!" "stay!"))
      (newline)
      hit?)))

;;; Exercise 6
(define (louis)
  (lambda (yh ouc)
    (let ((total (hand-total yh)))
      (cond ((< total 12) #t)
            ((> total 16) #f)
            ((= total 12) (< ouc 4))
            ((= total 16) (not (= ouc 10)))
            ((> ouc 6))))))

;; (test-strategy (louis) (stop-at 15) 1000)
;; => 435
;; (test-strategy (louis) (stop-at 16) 1000)
;; => 390
;; (test-strategy (louis) (stop-at 17) 1000)
;; => 394

;;; Exercise 7
(define (both s1 s2)
  (lambda (yh ouc)
    (and (s1 yh ouc) (s2 yh ouc))))

;;; Exercise 8 See procedure changes above. Used the following to
;;; simply fixup the selectors:

;; (caar (cons (cons 1 2) (cons 3 4)))
;; => 1
;; (cdar (cons (cons 1 2) (cons 3 4)))
;; => 2
;; (cadr (cons (cons 1 2) (cons 3 4)))
;; => 3
;; (cddr (cons (cons 1 2) (cons 3 4)))
;; => 4

;;; Exercise 9
;; Needed to reform the structure of the hand
;; (define (hand-add-card hand new-card)
;;   (make-hand (hand-up-card hand)
;;              (+ new-card (hand-total hand))
;;              (cons new-card (hand-card-list hand))))

;;; Exercise 11
(define (my-hand-after-new-card hand)
  (display "Up Card: ")
  (display (hand-up-card hand))
  (newline)
  (display "Total: ")
  (display (hand-total hand))
  (newline)
  (display "Card List: ")
  (display (hand-card-list hand))
  (newline))

;; (my-hand-after-new-card (hand-add-card (make-new-hand 5) 10))
;; Up Card: 5
;; Total: 15
;; Card List: (10 5)

;; (hand-add-card (make-new-hand 5) 10)
;; => ((5 . 15) 10 5)

;;; Exercise 12

;;; *Note* use of contraction selectors above
;; (define (hand-up-card hand)
;;   (car (car hand)))

;; (define (hand-total hand)
;;   (cdr (car hand)))

;; (define (hand-card-list hand)
;;   (cdr hand))

;;; Exercise 13

;;; Nothing needs to be changed in `twenty-one` IF you held true to
;;; the abstraction of the data. `twenty-one` knows nothing about how
;;; a hand is created or structured, or how to get an up card or total
;;; from a hand. The only thing that needed to be updated was the
;;; constructors and the selectors..

;;; Exercise 14

;; (twenty-one hit? (stop-at 16))

;; Opponent up card 8
;; Your Total: 2
;; Your Card List: (2)

;; Hit? yy
;; Opponent up card 8
;; Your Total: 9
;; Your Card List: (7 2)

;; Hit? yy
;; Opponent up card 8
;; Your Total: 10
;; Your Card List: (1 7 2)

;; Hit? yy
;; Opponent up card 8
;; Your Total: 13
;; Your Card List: (3 1 7 2)

;; Hit? yy
;; Opponent up card 8
;; Your Total: 18
;; Your Card List: (5 3 1 7 2)

;; Hit? nn
;; Value: 1

;;; Tutorial
