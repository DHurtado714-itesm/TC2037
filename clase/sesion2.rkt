#lang racket

;; attendess: number -> number

(define attendees
  (lambda (ticket-price)
    (+ 120
       (* (/ 15 0.10) (- 5.00 ticket-price)))))
;; (attendees 4.90) => 134.99

;; revenue: number -> number
(define revenue
  (lambda (ticket-price)
       (* (attendees ticket-price) ticket-price)))
;; (revenue 4.90) => 661.49

;; cost: number -> number
(define cost
  (lambda (ticket-price)
    (+ 180
       (* 0.04 (attendees ticket-price)))))
;; (cost 4.90) => 185.40

;; best-ticket-price: number number -> number
(define best-ticket-price
  (lambda (ticket-price best)
    (cond
      [(<= ticket-price 0.0) 'not-found] ;;not-found es un token
      [(> (- (revenue ticket-price)
             (cost ticket-price)) best)
       (best-ticket-price (- ticket-price 0.10)
                          (- (revenue ticket-price)
                             (cost ticket-price)))]
      [else ticket-price])))
;; todo esto es un ciclo while

(define lst '(1 2 3 4 5 6 7 8 9 10))


;; (first lst) => primer elemento
;; (rest lst) => resto del arreglo
;; (cdr lst) => primer elemento del resto
;; (caddr lst) => segundo elemento del resto
;; (cadddr lst) => tercer elemento del resto

;; size: list-of-number -> number
(define size-head
  (lambda (lst)
    (cond
      [(empty?  lst) 0]
      [else (+ 1 (size-head (cdr lst)))])))

;; size-tail: list-of-number -> number
(define size-tail
  (lambda (lst acc)
    (cond
      [(empty? lst) acc]
      [else (size-tail (rest lst) (+ acc 1))])))

;; sum-list-head: list-of-number -> number
(define sum-list-head
  (lambda (lst)
    (cond
      [(empty? lst) 0]
      [else (+ (car lst) (sum-list-head (cdr lst)))])))

;; sum-list-tail: list-of-number -> number
(define sum-list-tail
  (lambda (lst acc)
    (cond
      [(empty? lst) acc]
      [else (sum-list-tail (cdr lst) (+ acc (car lst)))])))

;; average: list-of-number -> number
(define average
  (lambda (lst)
    (/ (sum-list-tail lst 0)
       (size-tail lst 0))))

;; maximum-tail: list-of-number -> number
(define maximum-tail
  (lambda (lst best)
    (cond
      [(empty? lst) best]
      [(> (car lst) best) (maximum-tail (cdr lst)
                                        (car lst))]
      [else (maximum-tail (cdr lst) best)])))

;; maximum-head: list-of-number -> number
(define maximum-head
  (lambda (lst)
    (cond
      [(empty? lst) 0]
      [(> (car lst) (maximum-head (cdr lst))) (car lst)]
      [else (maximum-head (cdr lst))])))

;; list-of-numbers: number number -> list-of-numbers
(define list-of-numbers
  (lambda (start end)
    (cond
      [(eq? start end) (cons start '())]
      [else (cons start
                  (list-of-numbers (+ start 1) end))])))

;; (cons
;;   (lambda (x) (+ x 1)) '())
;; **Esto es una lista de funciones**

;; pairs: list-of-numbers -> list-of-numbers
(define evens
  (lambda (lst)
    (cond
      [(empty? lst) ' ()]
      [(= (remainder (car lst) 2) 0)
       (cons (car lst) (evens (cdr lst)))]
      [else (evens (cdr lst))])))

;; more-than:number list-of-number -> list-of-numbers
(define less-than
  (lambda (n lst)
    (cond
      [(empty? lst) '()]
      [(> start end)]))) ;; no termiando

;; quick-sort:list-of-numbers -> list-of-number
(define quick-sort
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      





