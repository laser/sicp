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

; Redefined below
;(define (make-new-hand first-card)
;  (make-hand first-card first-card))

;(define (make-hand up-card total)
;  (cons up-card total))

(define (hand-up-card hand)
  (car hand))

;(define (hand-total hand)
;  (cdr hand))

;(define (hand-add-card hand new-card)
;  (make-hand (hand-up-card hand)
;             (+ new-card (hand-total hand))))

(define (hit? your-hand opponent-up-card)
  (newline)
  (display "Opponent up card ")
  (display opponent-up-card)
  (newline)
  (display "Your Cards: ")
  (display (card-list your-hand))
  (display " Total: ")
  (display (hand-total your-hand))
  (newline)
  (user-wants-hit?))

(define (user-wants-hit?)
  (let ((x (prompt-for-command-char "Hit? ")))
    (display x)
    (eq? x '#\y))) ;prompt-for-command char returns #\ before char

(define (stop-at total)
  (lambda (hand opponent-up-card)
    (< (hand-total hand) total)))

(define (test-strategy player-strategy house-strategy count)
  (if (< count 1) 0 (+
    (twenty-one player-strategy house-strategy)
    (test-strategy player-strategy house-strategy (- count 1)))))

(define (watch-player strategy)
  (lambda (hand opponent-up-card)
    (let ((hit? (strategy hand opponent-up-card)))
      (display "Opponent up card ")
      (display opponent-up-card)
      (display "  Your Total: ")
      (display (hand-total hand))
      (display "  Decision: ")
      (display (if hit? "hit" "stay"))
      (newline)
      hit?)))

(define louis
  (lambda (hand opponent-up-card)
    (and (not (and (= (hand-total hand) 16) (= opponent-up-card 10)))
      (or
        (< (hand-total hand) 12)
        (and (= (hand-total hand) 12) (< opponent-up-card 4))
        (and (< (hand-total hand) 17) (> opponent-up-card 6))))))


(define (grid-test-strategy strategy total opponent-up-card)
  (cond
    ((> opponent-up-card 10) (newline) (grid-test-strategy strategy (+ total 1) 1))
    ((> total 21) (newline))
    (else
      (display (if (strategy (cons 1 total) opponent-up-card) " H" " ."))
      (grid-test-strategy strategy total (+ opponent-up-card 1)))))

(define (both strategy1 strategy2)
  (lambda (hand opponent-up-card)
    (and
      (strategy1 hand opponent-up-card)
      (strategy2 hand opponent-up-card))))

(define (make-new-hand first-card)
  (make-hand first-card first-card (list first-card)))

(define (make-hand up-card total card-list)
  (append (list up-card total) card-list))

(define (hand-total hand)
  (car (cdr hand)))

(define (card-list hand)
  (cdr (cdr hand)))

(define (hand-add-card hand new-card)
  (make-hand (hand-up-card hand)
             (+ new-card (hand-total hand))
             (cons new-card (card-list hand))))
