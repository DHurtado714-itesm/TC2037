#lang racket

;; Author: Daniel Hurtado
;; Profesor: Dr. Pedro O. Perez

;; Programacion funcional, parte 2

;; Problema 1
;; La funcion insert toma dos entradas: un n ́umero n y una lista lst que contiene n ́umeros en orden ascendente.
;; Devuelve una nueva lista con los mismos elementos de lst pero con n insertado en su lugar correspondiente.

;; Ejemplo:
;;; (insert 4 '(5 6 7 8))
;;; ⇒ '(4 5 6 7 8)

(define insert
  (lambda (n lst)
    (cond ((empty? lst) (list n))
          ((< n (car lst)) (cons n lst))
          (else (cons (car lst) (insert n (cdr lst)))))))

;; Problema 2
;;; La funcion insertion-sort toma una lista desordenada de n ́umeros como entrada y devuelve una nueva lista
;;; con los mismos elementos pero en orden ascendente. Se debe usar la funci ́on de insert definida en el ejercicio
;;; anterior para escribir insertion-sort. No se debe utilizar la funci ́on sort o alguna similar predefinida.

;; Ejemplo:
;;; (insertion-sort '(4 3 6 8 3 0 9 1 7))
;;; ⇒ (0 1 3 3 4 6 7 8 9)

(define insertion-sort
  (lambda (lst)
    (cond ((empty? lst) '())
          (else (insert (car lst) (insertion-sort (cdr lst)))))))


;; Problema 3 -> Probar
;;; La funcion rotate-left toma dos entradas: un n ́umero entero n y una lista lst. Devuelve la lista que resulta
;;; de rotar lst un total de n elementos a la izquierda. Si n es negativo, rota hacia la derecha.

;;; Ejemplo:
;;; (rotate-left 0 '(a b c d e f g))
;;; ⇒ (a b c d e f g)

(define rotate-left
  (lambda (n lst)
    (cond [(empty? lst) '()]
          [(= n 0) lst]
          [(< n 0) (rotate-left (- n) lst)]
          )))

;; Problema 4
;;; La funcion prime-factors toma un numero entero n como entrada (n ¿ 0) y devuelve una lista que contiene
;;; los factores primos de n en orden ascendente. Los factores primos son los n ́umeros primos que dividen a un
;;; n ́umero de manera exacta. Si se multiplican todos los factores primos se obtiene el n ́umero original

;; Ejemplo:
;;; (prime-factors 96)
;;; ⇒ (2 2 2 2 2 3)

;;; (define prime-factors
;;;   (lambda (n)
;;;     (cond
;;;       ((= n 1) '())
;;;       ())))



;; Problema 5
;;; La funci ́on gcd toma dos n ́umeros enteros positivos a y b como entrada, donde a > 0 y b > 0. Devuelve el
;;; m ́aximo com ́un divisor (GCD por sus siglas en ingl ́es) de a y b. No se debe usar la funci ́on gcd o similar
;;; predefinida.

;; Ejemplo:
;;; (gcd 13 7919)
;;; ⇒ 1

(define gcd
  (lambda (a b)
    (cond
      ((= a b) a)
      ((> a b) (gcd (- a b) b))
      (else (gcd a (- b a)))
      )))

;; Problema 6
;;; La funci ́on deep-reverse toma una lista como entrada. Devuelve una lista con los mismos elementos que su
;;; entrada pero en orden inverso. Si hay listas anidadas, estas tambi ́en deben invertirse.

;; Ejemplo:
;;;   (deep-reverse '((1 2) 3 (4 (5 6))))
;;; ⇒ (((6 5) 4) 3 (2 1))

(define deep-reverse
  (lambda (lst)
    (cond
      ((empty? lst) '())
      ((list? (car lst)) (cons (deep-reverse (car lst)) (deep-reverse (cdr lst))))
      (else (cons (car lst) (deep-reverse (cdr lst))))
      )))

;; Problema 7
;;; La funci ́on insert-anywhere toma dos entradas: un objeto x y una lista lst. Devuelve una nueva lista con
;;; todas las formas posibles en que se puede insertar x en cada posici ́on de lst.

;; Ejemplo:
;;; (insert-everywhere 1 '(a b c d e))
;;; ⇒ ((1 a b c d e)
;;; (a 1 b c d e)
;;; (a b 1 c d e)
;;; (a b c 1 d e)
;;; (a b c d 1 e)
;;; (a b c d e 1))

(define insert-anywhere
  (lambda (x lst)
    (cond
      ((empty? lst) (list (list x)))
      (else (cons (cons x lst) (map (lambda (l) (cons (car l) (cons x (cdr l)))) (insert-anywhere x (cdr lst)))))
      )))

;; Problema 8
;;; La funci ́on pack toma una lista lst como entrada. Devuelve una lista de listas que agrupan los elementos
;;; iguales consecutivos.

;; Ejemplo:
;;; (pack '(a a a a b c c a a d e e e e))
;;; ⇒ ((a a a a) (b) (c c) (a a) (d) (e e e e))



;; Problema 9
;;; La funci ́on compress toma una lista lst como entrada. Devuelve una lista en la que los elementos repetidos
;;; consecutivos de lst se reemplazan por una sola instancia. El orden de los elementos no debe modificarse.

;; Ejemplo:
;;; (compress '(a a a a b c c a a d e e e e))
;;; ⇒ (a b c a d e)

(define compress
  (lambda (lst)
    (cond
      ((empty? lst) '())
      ((empty? (cdr lst)) lst)
      ((= (car lst) (cadr lst)) (compress (cdr lst)))
      (else (cons (car lst) (compress (cdr lst))))
      )))


;; Problema 10
;;; La funci ́on encode toma una lista lst como entrada. Los elementos consecutivos en lst se codifican en listas
;;; de la forma: (n e), donde n es el n ́umero de ocurrencias del elemento e.

;; Ejemplo:
;;; (encode '(a a a a b c c a a d e e e e))
;;; ⇒ ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e))




;; Problema 11


;; Problema 12


;; Problema 13
