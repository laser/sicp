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
  (list up-card total card-list))

(define (hand-up-card hand)
  (car hand))

(define (hand-total hand)
  (cadr hand))

;(cadr hand) == (car (cdr hand))

(define (list-of-cards hand)
  (caddr hand))

;(caddr hand) == (car (cdr (cdr hand)))

(define (hand-add-card hand new-card)
  (make-hand (hand-up-card hand)
             (+ new-card (hand-total hand))
             (cons new-card (list-of-cards hand))))

(define (hit? your-hand opponent-up-card)
  (newline)
  (display "Opponent up card ")
  (display opponent-up-card)
  (newline)
  (display "Your Total: ")
  (display (hand-total your-hand))
  (newline)
  (display " Your Hand: ")
  (display (list-of-cards your-hand))
  (newline)
  (user-wants-hit?))

(define (user-wants-hit?)
  (let ((x (prompt-for-command-char "Hit? ")))
    (display x)
    (eq? x '#\y))) ;prompt-for-command char returns #\ before char

; (strategy my-hand opponent-up-card)
(define (stop-at n)
  (lambda (my-hand opponent-up-card)
    (< (hand-total my-hand) n)))

(define (test-strategy strat1 strat2 numGames)
  (define (iter gamesPlayed gamesWon)
    (if (> gamesPlayed numGames)
        gamesWon
        (iter (+ 1 gamesPlayed) (+ (twenty-one strat1 strat2) gamesWon))))
  (iter 1 0))

(define (watch-player strategy)
  (lambda (my-hand opponent-up-card)
    (let ((stratResult (strategy my-hand opponent-up-card)))
      (display "Player's hand: ")
      (display (hand-total my-hand))
      (display " Opponent's hand: ")
      (display opponent-up-card)
      (newline)
      (cond
       (stratResult (display "Hit!"))
       (else (display "Hold!")))
      (newline)
      stratResult)))

(define louis
  (lambda (my-hand opponent-up-card)
    (cond
     ((< (hand-total my-hand) 12) #t)
     ((> (hand-total my-hand) 16) #f)
     ((and (= (hand-total my-hand) 12)
           (< opponent-up-card 4))
      #t)
     ((and (= (hand-total my-hand) 16)
           (= opponent-up-card 10)) #f)
     (else (> opponent-up-card 6)))))

(define (both strat1 strat2)
  (lambda (my-hand opponent-up-card)
    (and (strat1 my-hand opponent-up-card)
         (strat2 my-hand opponent-up-card))))
