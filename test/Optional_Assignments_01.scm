(load "src/Optional_Assignments_01.scm")
(in-test-group
  Optional_Assignments_01
  (define-each-test
    (assert-= (/ (- 37) 150) (prob-1-2) "Exercise 1.2: turn expression into prefix form")
    (assert-= 25 (largest-squares-sum 1 4 3) "Excercise 1.3: takes three numbers and returns the sum of squares of the larger two")
    (assert-= 25 (largest-squares-sum 4 1 3) "Excercise 1.3: takes three numbers and returns the sum of squares of the larger two")
    (assert-= 25 (largest-squares-sum 4 3 1) "Excercise 1.3: takes three numbers and returns the sum of squares of the larger two")
  )
)
