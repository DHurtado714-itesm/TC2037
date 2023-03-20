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
    (cond
      [(empty? lst) (list n)]
      [(< n (car lst)) (cons n lst)]
      [else (cons (car lst) (insert n (cdr lst)))])))

;; Problema 2
;;; La funcion insertion-sort toma una lista desordenada de n ́umeros como entrada y devuelve una nueva lista
;;; con los mismos elementos pero en orden ascendente. Se debe usar la funci ́on de insert definida en el ejercicio
;;; anterior para escribir insertion-sort. No se debe utilizar la funci ́on sort o alguna similar predefinida.

;; Ejemplo:
;;; (insertion-sort '(4 3 6 8 3 0 9 1 7))
;;; ⇒ (0 1 3 3 4 6 7 8 9)

(define insertion-sort
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [else (insert (car lst) (insertion-sort (cdr lst)))])))

;; Problema 3
;;; La funcion rotate-left toma dos entradas: un n ́umero entero n y una lista lst. Devuelve la lista que resulta
;;; de rotar lst un total de n elementos a la izquierda. Si n es negativo, rota hacia la derecha.

;;; Ejemplo:
;;; (rotate-left 0 '(a b c d e f g))
;;; ⇒ (a b c d e f g)

(define rotate-left
  (lambda (n lst)
    (cond
      [(empty? lst) '()]
      [(= n 0) lst]
      [(= n 1) (append (rest lst) (list (first lst)))]
      [(> n 1) (rotate-left 1 (rotate-left (- n 1) lst))]
      [(< n 0) (rotate-left (+ (length lst) n) lst)])))

;; Problema 4
;;; La funcion prime-factors toma un numero entero n como entrada (n ¿ 0) y devuelve una lista que contiene
;;; los factores primos de n en orden ascendente. Los factores primos son los n ́umeros primos que dividen a un
;;; n ́umero de manera exacta. Si se multiplican todos los factores primos se obtiene el n ́umero original

;; Ejemplo:
;;; (prime-factors 96)
;;; ⇒ (2 2 2 2 2 3)

(define prime-factors
  (lambda (n)
    (cond
      [(= n 1) '()]
      [(= n 2) (list 2)]
      [(= n 3) (list 3)]
      [(= n 5) (list 5)]
      [(= (modulo n 2) 0) (cons 2 (prime-factors (/ n 2)))]
      [(= (modulo n 3) 0) (cons 3 (prime-factors (/ n 3)))]
      [(= (modulo n 5) 0) (cons 5 (prime-factors (/ n 5)))]
      [else (cons n '())])))

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
      [(= a b) a]
      [(> a b) (gcd (- a b) b)]
      [else (gcd a (- b a))])))

;; Problema 6
;;; La funci ́on deep-reverse toma una lista como entrada. Devuelve una lista con los mismos elementos que su
;;; entrada pero en orden inverso. Si hay listas anidadas, estas tambi ́en deben invertirse.

;; Ejemplo:
;;;   (deep-reverse '((1 2) 3 (4 (5 6))))
;;; ⇒ (((6 5) 4) 3 (2 1))

(define deep-reverse
  (lambda (lst)
    (cond
      [(not (list? lst)) lst]
      [(empty? lst) '()]
      [else (append (deep-reverse (rest lst)) (list (deep-reverse (first lst))))])))

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

(define insert-at
  (lambda (x lst pos)
    (cond
      [(> pos (length lst)) (append lst (list x))]
      [else
       (foldr (lambda (e acc)
                (cond
                  [(= (- (length lst) (length acc)) pos) (cons x (cons e acc))]
                  [else (cons e acc)]))
              '()
              lst)])))

(define insert-everywhere
  (lambda (x lst)
    (append
     (foldr (lambda (_ acc) (cons (insert-at x lst (- (length lst) (length acc))) acc)) '() lst)
     (list (insert-at x lst (+ (length lst) 1))))))

;; Problema 8
;;; La funci ́on pack toma una lista lst como entrada. Devuelve una lista de listas que agrupan los elementos
;;; iguales consecutivos.

;; Ejemplo:
;;; (pack '(a a a a b c c a a d e e e e))
;;; ⇒ ((a a a a) (b) (c c) (a a) (d) (e e e e))

(define pack
  (lambda (lst)
    (foldr (lambda (x acc)
             (cond
               [(empty? acc) (cons (list x) acc)]
               [(eq? x (first (first acc))) (cons (cons x (first acc)) (rest acc))]
               [else (cons (list x) acc)]))
           '()
           lst)))

;; Problema 9
;;; La funci ́on compress toma una lista lst como entrada. Devuelve una lista en la que los elementos repetidos
;;; consecutivos de lst se reemplazan por una sola instancia. El orden de los elementos no debe modificarse.

;; Ejemplo:
;;; (compress '(a a a a b c c a a d e e e e))
;;; ⇒ (a b c a d e)

(define compress
  (lambda (lst)
    (foldr (lambda (x acc)
             (cond
               [(empty? acc) (cons x acc)]
               [(eq? x (first acc)) acc]
               [else (cons x acc)]))
           '()
           lst)))

;; Problema 10
;;; La funci ́on encode toma una lista lst como entrada. Los elementos consecutivos en lst se codifican en listas
;;; de la forma: (n e), donde n es el n ́umero de ocurrencias del elemento e.

;; Ejemplo:
;;; (encode '(a a a a b c c a a d e e e e))
;;; ⇒ ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e))

(define encode
  (lambda (lst)
    (foldr (lambda (x acc)
             (cond
               [(empty? acc) (cons (list 1 x) acc)]
               [(eq? x (cadar acc)) (cons (list (+ (caar acc) 1) (cadar acc)) (rest acc))]
               [else (cons (list 1 x) acc)]))
           '()
           lst)))

;; Problema 11
;;; La funcion encode-modified toma una lista lst como entrada. Funciona igual que el problema anterior,
;;; pero si un elemento no tiene duplicados simplemente se copia en la lista resultante. Solo los elementos que
;;; tienen repeticiones consecutivas se convierten en listas de la forma: (n e).

;; Ejemplo:
;;; (encode-modified '(a a a a b c c a a d e e e e))
;;; ⇒ ((4 a) b (2 c) (2 a) d (4 e))

(define encode-modified
  (lambda (lst)
    (foldr (lambda (x acc)
             (cond
               [(= 1 (first x)) (cons (cadr x) acc)]
               [else (cons x acc)]))
           '()
           (encode lst))))

;; Problema 12
;;; La funci ́on de decode toma como entrada una lista codificada lst que tiene la misma estructura que la lista
;;; resultante del problema anterior. Devuelve la versi ́on decodificada de lst

;; Ejemplo:
;;; (decode '((4 a) b (2 c) (2 a) d (4 e)))
;;; ⇒ (a a a a b c c a a d e e e e)

(define decode
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [(list? (car lst)) (append (make-list (caar lst) (cadr (car lst))) (decode (cdr lst)))]
      [else (cons (car lst) (decode (cdr lst)))])))

;; Problema 13
;;; La funci ́on args-swap toma como entrada una funci ́on de dos argumentos f y devuelve una nueva funci ́on
;;; que se comporta como f pero con el orden de sus dos argumentos intercambiados. En otras palabras:

;; (args-swap f) x y = f y x

;; Ejemplo:
;;; ((args-swap list) 1 2)
;; ⇒ (2 1)

(define args-swap (lambda (f) (lambda (x y) (f y x))))

;; Problema 14
;;; La funci ́on there-exists-one? toma dos entradas: una funci ́on booleana de un argumento pred y una lista
;;; lst. Devuelve verdadero si hay exactamente un elemento en lst que satisface pred, en otro caso devuelve
;;; falso.

;; Ejemplo:
;;; (there-exists-one? positive? '(-1 -10 4 -5 -2 -1))
;;; ⇒ #t

(define there-exists-one?
  (lambda (pred lst [found #f])
    (cond
      [(empty? lst) found]
      [(pred (first lst)) (if found #f (there-exists-one? pred (rest lst) #t))]
      [else (there-exists-one? pred (rest lst) found)])))

;; Problema 15
;;; La funci ́on linear-search toma tres entradas: una lista lst, un valor x, y una funci ́on de igualdad eq-fun.
;;; Busca secuencialmente x en lst usando eq-fun para comparar x con los elementos contenidos en lst. La
;;; funci ́on eq-fun debe aceptar dos argumentos, a y b, y devolver verdadero si se debe considerar que a es igual
;;; a b, o falso en caso contrario

;;; La funci ́on linear-search devuelve el  ́ındice donde se encuentra la primera ocurrencia de x en lst (el primer
;;; elemento de la lista se encuentra en el  ́ındice 0), o falso si no se encontr ́o

;; Ejemplo:
;;; (linear-search '(48 77 30 31 5 20 91 92 69 97 28 32 17 18 96) 5 =)
;;; ⇒ 4

(define linear-search
  (lambda (lst x eq-fun)
    (cond
      [(empty? lst) #f]
      [(eq-fun x (car lst)) 0]
      [else (if (linear-search (cdr lst) x eq-fun) (+ 1 (linear-search (cdr lst) x eq-fun)) #f)])))

;; Problema 16
;;; La derivada de una funci ́on f (x) con respecto a la variable x se define como:

;; f '(x) = lim h→0 (f(x + h) − f(x)) / h

;;; Donde f debe ser una funci ́on continua. Escribe la funci ́on deriv que toma f y h como entradas, y devuelve
;;; una nueva funci ́on que toma x como argumento, y que representa la derivada de f dado un cierto valor de h.

;; Ejemplo:
;;; (define f (lambda (x) (* x x x)))
;;; (define f' (deriv f 0.0001))

;; (df 2)
;;; ⇒ 75.021500100002545

(define deriv (lambda (f h) (lambda (x) (/ (- (f (+ x h)) (f x)) h))))

;; Problema 17

;;; El m ́etodo de Newton es un algoritmo para encontrar la ra ́ız de una funci ́on a partir del c ́alculo de aproximaciones
;;; sucesivamente mejores. Se puede resumir de la siguiente manera:

(define newton
  (lambda (f n)
    (define df (deriv f 0.0001))
    (define iter (lambda (i xn) (if (= i n) xn (iter (+ i 1) (- xn (/ (f xn) (df xn)))))))
    (iter 0 0)))
