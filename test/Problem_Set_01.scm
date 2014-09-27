(load "src/Problem_Set_01.scm")
(in-test-group
  Problem_Set_01
  (define-each-test
    (assert-= 120 (fact 5) "ex2: fact computes the factorial of a positive number")
    (assert-= 3 (comb 3 2) "ex3: combinations of n things taken k at a time")
    (assert-= 27 (cube 3) "ex10: return the cube of a value")
    (assert-= 54 (sum-of-cubes 3 3) "ex11: return the sum of cubing each argument")
    (assert-= 5 (biggest-of-three 2 5 1) "ex12: return the 'biggest' of three values")
    (assert-= 125 (cube-biggest-of-three 2 5 1) "ex13: return the cube of the 'biggest' of three")
    (assert-= 3.25 (f 0.5 1 2 3 4) "ex14: evaluating 3rd degree polynomials")
  )
)
