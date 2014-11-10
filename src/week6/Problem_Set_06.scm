(load "Problem_set_06_put-get.scm")
(load "Problem_set_06_types.scm")
(load "Problem_set_06_generic.scm")

;;;;;;;;;;;;;;;;;;;
;   Exercise 1
;;;;;;;;;;;;;;;;;;;

; =number: (RepNum, RepNum) -> Sch-Bool
(define (=number x y) (= x y))
(put 'equ? '(number number) =number)

;;;;;;;;;;;;;;;;;;;
;   Exercise 2
;;;;;;;;;;;;;;;;;;;

; equ?: (Generic-Num, Generic-Num) -> Sch-Bool
(define (equ? x y) (apply-generic 'equ? x y))

;;;;;;;;;;;;;;;;;;;
;   Exercise 3
;;;;;;;;;;;;;;;;;;;

(define r5/13 (create-rational (make-number 5) (make-number 13)))
(define r2 (create-rational (make-number 2) (make-number 1)))

(define rsq (square (add r5/13 r2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; ⎡¯¯¯¯¯¯¯¯¯¯¯|¯¯¯⎤   ⎡¯¯¯|¯¯¯⎤   ⎡¯¯¯¯¯¯¯¯¯|¯¯¯¯¯⎤
; | 'rational | *---->| * | *---->| 'number | 169 |
; ⎣___________|___⎦   ⎣_|_|___⎦   ⎣_________|_____⎦
;                       ⋎
;                     ⎡¯¯¯¯¯¯¯¯¯|¯¯¯¯¯⎤
;                     | 'number | 961 |
;                     ⎣_________|_____⎦
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;
;   Exercise 4
;;;;;;;;;;;;;;;;;;;

; equ-rat?: (RepRat, RepRat) -> Sch-Bool
(define (equ-rat? x y) (equ?
  (mul (numer x) (denom y))
  (mul (numer y) (denom x))))

(put 'equ? '(rational rational) equ-rat?)

;;;;;;;;;;;;;;;;;;;
;   Exercise 5
;;;;;;;;;;;;;;;;;;;

(define (repnum->reprat n) (create-rational n (make-number 1)))

;;;;;;;;;;;;;;;;;;;
;   Exercise 6
;;;;;;;;;;;;;;;;;;;

; Redefine to something that works with apply generic
(define (RRRaw->NRRaw method)
  (lambda (rawnum rawrat)
    (method
     (contents (repnum->reprat (make-number rawnum)))
     rawrat)))

(define (NRRaw->RRRaw method)
  (lambda (rawrat rawnum)
    (method rawrat
      (contents (repnum->reprat (make-number rawnum))))))

(put 'add '(number rational) (RRRaw->NRRaw +rational))
(put 'add '(rational number) (NRRaw->RRRaw +rational))
(put 'sub '(number rational) (RRRaw->NRRaw -rational))
(put 'sub '(rational number) (NRRaw->RRRaw -rational))
(put 'mul '(number rational) (RRRaw->NRRaw *rational))
(put 'mul '(rational number) (NRRaw->RRRaw *rational))
(put 'div '(number rational) (RRRaw->NRRaw /rational))
(put 'div '(rational number) (NRRaw->RRRaw /rational))
(put 'equ? '(number rational) (RRRaw->NRRaw equ-rat?))
(put 'equ? '(rational number) (NRRaw->RRRaw equ-rat?))

;;;;;;;;;;;;;;;;;;;
;   Exercise 7
;;;;;;;;;;;;;;;;;;;

(define (create-numerical-polynomial var numbers)
  (create-polynomial var (map make-number numbers)))

(define p1 (create-numerical-polynomial 'x (list 3 5 0 -2)))

;;;;;;;;;;;;;;;;;;;
;   Exercise 8
;;;;;;;;;;;;;;;;;;;

; map-terms: ((RepTerm) -> RepTerm, List(RepTerm)) -> List(RepTerm)
(define map-terms map)

;;;;;;;;;;;;;;;;;;;
;   Exercise 9
;;;;;;;;;;;;;;;;;;;

(define p2
  (create-polynomial 'z (list
    p1
    (create-polynomial 'x (list (create-number 3)))
    (create-polynomial 'x (list (create-number 5))))))

(define rp1 (create-rational
  (create-polynomial 'y (list (create-number 3)))
  (create-polynomial 'y (map create-number (list 1 0)))))

(define rp2 (create-rational
  (create-polynomial 'y (map create-number (list 1 0 1)))
  (create-polynomial 'y (map create-number (list 1 0)))))

(define rp3 (create-rational
  (create-polynomial 'y (map create-number (list 1)))
  (create-polynomial 'y (map create-number (list 1 -1)))))

(define rp4 (create-rational
  (create-polynomial 'y (list (create-number 2)))
  (create-polynomial 'y (list (create-number 1)))))

(define rp0 (create-rational
  (create-polynomial 'y (list (create-number 0)))
  (create-polynomial 'y (list (create-number 1)))))

(define p3 (create-polynomial 'x (list rp1 rp0 rp2 rp3 rp4)))

;;;;;;;;;;;;;;;;;;;
;   Exercise 10
;;;;;;;;;;;;;;;;;;;

(pretty-print (square p2))
(pretty-print (square p3))
(pretty-print (square (square p2)))

;;;;;;;;;;;;;;;;;;;
;   Exercise 11
;;;;;;;;;;;;;;;;;;;

; negate-terms : List(RepTerm) -> List(RepTerm)
(define (negate-terms terms)
  (map-terms (lambda (term) (make-term (order term) (negate (coeff term)))) terms))

; negate-poly : RepPoly -> RepPoly
(define (negate-poly poly)
  (make-poly (variable poly) (negate-terms (term-list poly))))

;;;;;;;;;;;;;;;;;;;
;   Exercise 12
;;;;;;;;;;;;;;;;;;;

; sub-poly : RepPoly -> RepPoly
(define (sub-poly poly1 poly2)
  (add-poly poly1 (negate-poly poly2)))

; sub-polynomial : RepPoly --> ({polynomial} X RepPoly)
(define (sub-polynomial p1 p2)
  (make-polynomial (sub-poly p1 p2)))

; equ-poly? : RepPoly -> Sch-Bool
(define (equ-polynomial? p1 p2)
  (=zero-poly? (sub-poly p1 p2)))

;;;;;;;;;;;;;;;;;;;
;   Exercise 13
;;;;;;;;;;;;;;;;;;;

(put 'negate '(polynomial) negate-polynomial)
(put 'sub '(polynomial polynomial) sub-polynomial)
(put 'equ? '(polynomial polynomial) equ-polynomial?)

