#lang racket

;; Author: Daniel Hurtado
;; Co-author: Rodrigo Teran
;; Date: 06/03/2023

;; Problema 1

(define fahrenheit-to-celsius 
  (lambda (f)
    (/ (* 5 (- f 32)) 9)))

;; Problema 2

(define sign 
  (lambda (n)
    (cond
      [(< n 0) -1]
      [(> n 0) 1]
      [(= n 0) 0])))

;; Problema 3

(define roots
  (lambda (a b c)
    (let ([discriminat (- (* b b) (* 4 a c))])
    (cond
      [(> discriminat 0) (list (/(+ (- b) (sqrt discriminat)) (* 2 a)))]
      [(= discriminat 0) (list (/ (- b) (* 2 a)))]
      [else (list)]))))

;; Problema 4

  (define bmi
    (lambda (weight height)
        (cond
          [(< (/ weight (* height height)) 20) 'underweight]
          [(< (/ weight (* height height)) 25) 'normal]
          [(< (/ weight (* height height)) 30) 'obese1]
          [(< (/ weight (* height height)) 40) 'obese2]
          [else 'obese3])))

;; Problema 5

(define factorial
  (lambda (n)
    (cond
      [(= n 0) 1]
      [(> n 0) (* n (factorial (- n 1)))])))

;; Problema 6

(define duplicate
  (lambda (lst)
    (cond 
      [(empty? lst) '()]
      [else (cons (list (car lst) (car lst)) (duplicate (cdr lst)))])))

;; Problema 7

(define pow
  (lambda (a b)
    (cond
      [(= b 0) 1]
      [else (* a (pow a (- b 1)))]
      )))

;; Probema 8

(define fib
  (lambda (n)
    (cond
      [(= n 0) 0]
      [(= n 1) 1]
      [(= n 2) 1]
      [else (+ (fib (- n 1)) (fib (- n 2)))])))

;; Problema 9

(define enlist
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [else (cons (list (car lst)) (enlist (cdr lst)))])))

;; Problema 10

(define positives
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [(> (car lst) 0) (cons (car lst) (positives (cdr lst)))]
      [else (positives (cdr lst))])))

;; Problema 11

(define add-list
  (lambda (lst)
    (cond
      [(empty? lst) 0]
      [else (+ (car lst) (add-list (cdr lst)))])))

;; Problema 12

;; La funcion invert-pairs toma como entrada una 
;; lista cuyo contenido son listas de dos elementos. 
;; Devuelve una nueva lista con cada pareja invertida.


(define invert-pairs_aux
  (lambda (lst)
    (append (cdr lst) (list (car lst)))
  )
)


(define invert-pairs 
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [else (append (list (invert-pairs_aux (car lst))) (invert-pairs (cdr lst)))]
    )
  )
)



;; Problema 13

;;; La funcion de list-of-symbols? toma una lista 
;;; lst como entrada. Devuelve verdadero si todos los 
;;; elementos (posiblemente cero) contenidos en lst son 
;;; sımbolos, o falso en caso contrario.

(define list-of-symbols?
  (lambda (lst)
    (cond
      [(empty? lst) #t]
      [(number? (car lst)) #f]
      [else (list-of-symbols? (cdr lst))]
    )
  )
)

;; Problema 14 

;;; El funcion swapper toma tres entradas: dos valores a y b, 
;;; y una lista lst. Devuelve una nueva lista en la que
;;; cada ocurrencia de a en lst se intercambia por b, y 
;;; viceversa. Cualquier otro elemento de lst permanece
;;; igual. Se puede suponer que lst no contiene listas anidadas.

(define swapper
  (lambda (a b lst)
    (cond
      [(empty? lst) '()]
      [(eq? (car lst) a) (cons b (swapper a b (cdr lst)))]
      [(eq? (car lst) b) (cons a (swapper a b (cdr lst)))]
      [else (cons (car lst) (swapper a b (cdr lst)))])))

;; Problema 15

;;; La funcion dot-product toma dos entradas: las listas 
;;; a y b. Devuelve el resultado de realizar el producto
;;; punto de a por b. El producto punto es una operacíon 
;;; algebraica que toma dos secuencias de n ́umeros de
;;; igual longitud y devuelve un solo numero que se obtiene 
;;; multiplicando los elementos en la misma posici ́on y
;;; luego sumando esos productos. Su formula es:

;;; (a1 * b1) + (a2 * b2) + ... + (an * bn)

(define dot-product
  (lambda (a b)
    (cond
      [(empty? a) 0]
      [else (+ (* (car a) (car b)) (dot-product (cdr a) (cdr b)))])))


;; Problema 16

;;; La funcion average recibe una lista de numeros lst como 
;;; entrada. Devuelve la media aritm ́etica de los
;;; elementos contenidos en lst, o 0 si lst est ́a vacıa. 
;;; La media aritḿetica ( ̄x) se define como:

;;;  ̄x = (x1 + x2 + ... + xn) / n

(define average
  (lambda(lst)
    (cond
      [(empty? lst) 0]
      [else (/ (add-list lst) (length lst))])))


;; Problema 17

(define (my-length lst)
  (if (empty? lst)
      0
      (+ 1 (my-length (rest lst)))))

(define sigma
    (lambda (lstSigma avg)
        (cond
            [(empty? lstSigma) 0]
            [(+ 
                (pow 
                    (- (car lstSigma) avg)
                    2
                )
                (sigma (cdr lstSigma) avg)
                )
            ]
        )
    )
)

(define standard-deviation
    (lambda (lst)
        (cond
            [(empty? lst) 0]
            [else (sqrt (/ (sigma lst (average lst)) (my-length lst) ))]
        )
    )
)

;; Problema 18

;;; La funci ́on replic toma dos entradas: una lista lst y un n ́umero entero n, 
;;; donde n ≥ 0. Devuelve una nueva
;;; lista que replica n veces cada elemento contenido en lst.


(define replic_aux
  (lambda (element n)
    (cond
        [(= n 0) '()]
        [else (append (list element) (replic_aux element (- n 1)))]
        )))


(define replic
  (lambda (n lst)
    (cond
      [(empty? lst) '()]
      [else (append
                (replic_aux (car lst) n)
                (replic n (cdr lst))
             )
      ]
     )
   )
 )


;; Problema 19

(define expand_aux
  (lambda (lst i)
    (cond
      [(empty? lst) '()]
      [else (append
                (replic_aux (car lst) i)
                (expand_aux (cdr lst) (+ i 1))
             )
      ]
     )
  )
)

(define expand
  (lambda (lst)
    (expand_aux lst 1)
  )
)


;; Problem 20

(define binary
  (lambda (n)
    (cond
      [(= n 0) '()]
      [else (append
                  (binary (quotient n 2))
                  (list (remainder n 2))
             )
      ]
    )
  )
)
