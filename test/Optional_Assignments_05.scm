(load "src/Optional_Assignments_05.scm")

(in-test-group
 Chapter2.3:OptionalAssignments
 (define-each-test
   (assert-equal '(1 2 4 3) (union-set '(1 2 3) '(4 3)) "union")
   (assert-equal '(1 2 3 4) (adjoin-set 1 '(2 3 4)) "adjoin example")
   (assert-equal '(2 3 4 1) (adjoin-set 1 '(2 3 4 1)) "adjoin example where it refuses to cons the new item")
   (assert-equal '(1 2 3 4 1) (adjoin-set2 1 '(2 3 4 1)) "no check for uniqueness makes it a simple cons")
   (assert-equal '(1 2 3 4 3) (union-set2 '(1 2 3) '(4 3)) "no checks for uniqueness make for a simple append")
   (assert-equal '(1 2 3 4) (adjoin-to-ordered-set 2 '(1 3 4)) "puts it where it belongs")
   (assert-equal '(1 2 3 4 5 6) (union-of-ordered-sets '(1 3 5) '(2 4 6)) "ordering preserved")))
