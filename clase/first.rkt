#lang racket

;;Author: Frida
;; Session 1


;;define - elnace a una etiqueta
;;no existe decalrar variables, solo trabajamos con funciones
;; asociaciones fijas

(define a 5) ;; f(x) = 5 

;;Función anónima
(define fn
  (lambda (x)
    (+ x 5)))

;;( (lambda (x) (+ x 5)) 5) = 10
;; ( (lambda (x) (+ x 5)) 1)6

(define fn2
  (lambda (x y)
    (+ x y)))


(define fn3 ;;Función x que genera una función y
  (lambda (x)
      (lambda (y)
        (+ x y))))

;;sum of squares: number number -> number
(define sum-of-square
  (lambda (x y)
          (+ (* x x)(* y y))))
(sum-of-square 1 2)

;;area-of-disk: number -> number
(define area-of-disk
  (lambda(radius)
    (* 3.1416 radius radius)))
(area-of-disk 10)

;; area of a ring: number number => number
(define area-of-ring
        (lambda (outer inner)
          (- (area-of-disk outer)
             (area-of-disk inner))))

;;wage: number number => number
(define wage
  (lambda (payment hours)
    (* payment hours)))
(wage 12 2)

;;tax: number bumber -> number
(define tax
  (lambda (wage rate)
    (* rate wage)))
(tax 100 0.15)

;;netpay: number number number -> number
(define netpay
  (lambda (payment hours rate)
    (- (wage payment hours)
       (tax (wage payment hours) rate))))
(netpay 12 40 0.15)

;; max: number number -> number
(define max
  (lambda (a b)
    (cond
      [(> a b) a] ;;[(es la condición) que regresar si sí se cumple]
      [else b])))
(max 10 5)


;;the interest for <$500 is $20
;;the interest for >$2000 is $90
;;the interest for >$10,000 is $500

(define interest
  (lambda (amount)
    (cond
      [(< amount 500)20]
      [(< amount 2000)90]
      [(< amount 10000)500])))

;;fact: number -> number
(define fact
  (lambda (n)
    (cond
      [(= 1 n) 1]
      [else (* n (fact (- n 1)))])))
(fact 5)

 ;;fibo: number -> number
  (define fibo
    (lambda (n)
      (cond
        [(= n 1) 1]
        [(= n 2) 1]
        [else (+ (fibo (- n 1))
                 (fibo (- n 2)))])))
  (fibo 7)


;;FUNCIONES RECURSIVAS
  
;;sum: number -> number
 (define sum
   (lambda (n)
     (cond
       [(= n 1)1]
       [else (+ n (sum(- n 1)))])))
  (sum 100)

;;number number -> number
 (define sum1
   (lambda (start end)
     (cond
       [(= end start) start]
       [else (+ end (sum1 start(- end 1)))])))
(sum1 2 10)

;;

;;Maximo común divisior
(define mcd
  (lambda (a b)
    (cond
      [(= b 0) a]
      [else (mcd b (remainder a b))])))

;;Recursón por cabeza
(define fact-head
  (lambda (n acc)
    (cond
      [(= n 1) acc]
      [else (fact-head (- n 1)(* acc n))])))

;;Para no tener que escribir siempre 1 en la función de arriba
(define fact2
  (lambda (n)
    (fact-head n 1)))
(fact2 5)


;;NOTAS
;;and es una fucnción (al igual que la suma) (and (>5 4) (< 2 3) (> 5 4))
;;of es una fucnción (al igual que la suma) (or (>5 4) (< 2 3) (> 5 4))
;;not es una fucnción (al igual que la suma) (not (>5 4))
;;cond es palabra reservada para las condicionales
;;lambda es la palabra reservada que dice que comienza una función
;;remainder - el residuo
;;Strinf es un atomo, se define en la terminal
;;( + 1 2 3) suma
;;( * 1 2 3) multiplicación
;; investigar recursón por cola
;; investigar recursón por cabeza
       
  



