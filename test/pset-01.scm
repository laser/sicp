(load "src/pset-01.scm")
(in-test-group 
  pset-01
  (define-each-test
    (assert-= 4 (+ 2 2) "Two and two should make four.")))
