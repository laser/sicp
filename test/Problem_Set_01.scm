(load "src/Problem_Set_01.scm")
(in-test-group
  Problem_Set_01
  (define-each-test
    (assert-= 4 (+ 2 2) "Two and two should make four.")))
