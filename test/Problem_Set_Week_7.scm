(load "src/Problem_Set_Week_7.scm")
(in-test-group

  Problem_Set_Week_7
  (define-test (make-accumulator-test)
    (define A (make-accumulator 5))
    (define B (make-accumulator 7))

    (assert-= (A 10) 15 "Adding 10 to accumulator A once is 15")
    (assert-= (A 10) 25 "Adding 10 to accumulator A twice is 25")
    (assert-= (B 4) 11 "Adding 4 to accumulator B once is 1"))

  (define-test (make-monitored-test)
    (define sqrt-monitored (make-monitored sqrt))
    (define square-monitored (make-monitored square))

    (assert-= (sqrt-monitored 36) 6 "sqrt-monitored works like sqrt")
    (assert-= (square-monitored 10) 100 "square-monitored works like sqrt")
    (assert-= (sqrt-monitored 'how-many-calls?) 1 "sqrt-monitored 'how-many-calls? returns the number of calls")
    (sqrt-monitored 64)
    (assert-= (sqrt-monitored 'how-many-calls?) 2 "sqrt-monitored 'how-many-calls? increments after another call")
    (assert-= (square-monitored 'how-many-calls?) 1 "square-monitored keeps its own count")
    (sqrt-monitored 'reset-count)
    (assert-= (sqrt-monitored 'how-many-calls?) 0 "after reset sqrt-monitored 'how-many-calls? is zero"))

  (define-test (make-account-test)
    (define account (make-account 100 'babylon))

    (assert-equal ((account 'password 'withdraw) 60) "Incorrect password" "Specifying the wrong password causes an error")
    (assert-= ((account 'babylon 'withdraw) 50) 50 "withdrawing $50 leaves $50")
    (assert-equal ((account 'babylon 'withdraw) 60) "Insufficient funds" "withdrawing an additional $50 leaves insufficient funds")
    (assert-equal ((account 'password 'deposit) 40) "Incorrect password" "Specifying the wrong password causes an error")
    (assert-= ((account 'babylon 'deposit) 40) 90 "depositing $40 leaves $90")
    (assert-= ((account 'babylon 'withdraw) 60) 30 "Now withdrawing $60 leaves $30"))
  )

  (define-test (estimate-integral-test)
    (define (unit-circle x y) (< (sqrt (+ (* x x) (* y y))) 1.0))
    (define (small-square x y) (and (< (abs x) .5) (< (abs y) .5)))

    (assert-in-delta 3.14159 (estimate-integral unit-circle 1.0 -1.0 1.0 -1.0 100000) .02 "Unit circle should estimate pi")
    (assert-in-delta 1.0 (estimate-integral small-square 1.0 -1.0 1.0 -1.0 100000) .02 "Small square should have area of 1")
  )

  (define-test (joint-account-test)
    (define peter-acc (make-account 100 'open-sesame))
    (define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

    (assert-equal "Incorrect password" ((paul-acc 'password 'withdraw) 60) "Specifying the wrong password causes an error")
    (assert-equal 200 ((paul-acc 'rosebud 'deposit) 100) "Paul can now add money")
    (assert-equal 150 ((peter-acc 'open-sesame 'withdraw) 50) "The money appears in peter's account")
    (assert-equal 50 ((paul-acc 'rosebud 'withdraw) 100) "Paul can withdraw money")
    (assert-equal 75 ((peter-acc 'open-sesame 'deposit) 25) "Peter sees the withdraw")
  )
