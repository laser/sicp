(load "src/Optional_Assignments_02.scm")
(in-test-group
  Optional_Assignments_02
  (define-each-test
    (assert-= 1024 (A 1 10) "Exercise 1.10: Solve the following: 2^10")
    (assert-= 65536 (A 2 4) "Exercise 1.10: Solve the following: 2^16")
    (assert-= 65536 (A 3 3) "Exercise 1.10: Solve the following: 2^16")
  )
)
