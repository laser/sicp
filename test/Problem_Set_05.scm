(load "src/Problem_Set_05_match.scm")
(load "src/Problem_Set_05_adv.scm")
(load "src/Problem_Set_05.scm")

(in-test-group
 ProblemSet5:PaperExercises
 (define-each-test
   (assert-equal (append '(1 2 3) '(4 5 6)) (list-union '(1 2 3) '(4 5 6)) "an example where append and list-union return the same thing")
   (assert-false (equal? (append '(1 2 3 4) '(4 5 6))
                         (list-union '(1 2 3 4) '(4 5 6))) "an example where append and list-union don't return the same thing")
   (assert-equal 720 (reduce * 1 '(2 3 4 5 6)) "reduce to compute the product")
   (assert-equal 14 (reduce + 0 (map (lambda (x) (* x x)) '(1 2 3))) "mapreduce example")
   (assert-equal '(1 2 2 3 4 6 5 4) (reduce append '() '((1 2) (2 3) (4 6) (5 4))) "duplicates exist")
   (assert-equal '(1 2 3 6 5 4) (reduce list-union '() '((1 2) (2 3) (4 6) (5 4))) "the last occurrence of a member makes it into the reduced listm")
   (assert-equal '((2 3) (4 6) (5 4) (1 2)) (proc '((1 2) (2 3) (4 6) (5 4) (1 2))) "only unique symbols remain...like some kind of set...make-set sounds good")
   (assert-equal '(1 5 6 2 3 4) (proc '(1 2 3 4 5 6 2 3 4)) "another example of how proc removes duplicates")
   (assert-equal '((+ 1 2 3) (* 1 2 3)) (proc '((+ 1 2 3) (* 1 2 3))) "get it yet?")))

(in-test-group
 ProblemSet5:CodingExercises
 (define-each-test
   (assert-equal 5 (length (all-prerequisites 'geo104)) "there should be five prerequisites for geo104")
   (assert-true (check-circular-prerequisites '(geo104)) "no problem taking a class by itself")
   (assert-true (check-circular-prerequisites '(eecs101 math101 phys101)) "no problem with no conflicts")
   (assert-false (check-circular-prerequisites '(geo104 math203)) "detects conflicts")
   (assert-equal 13 (total-credits '(eecs101 math101 phys101)) "works as intended")))
