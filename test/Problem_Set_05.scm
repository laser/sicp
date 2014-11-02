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
