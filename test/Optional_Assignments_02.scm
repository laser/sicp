(load "src/Optional_Assignments_02.scm")
(in-test-group
  Optional_Assignments_02
  (define-test (ackermans-number)
    (assert-equal 1024 (A 1 10) "Exercise 1.10: Solve the following: 2^10")
    (assert-equal 65536 (A 2 4) "Exercise 1.10: Solve the following: 2^16")
    (assert-equal 65536 (A 3 3) "Exercise 1.10: Solve the following: 2^16")
  )
  (define-test (fast-multiply-test)
    (assert-equal 10 (fast-multiply 5 2) "Fast multiply works just as good as multiply")
  )
)
