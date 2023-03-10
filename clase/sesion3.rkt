#lang racket

(define add1
  (lambda (lst)
    (cond
      [(empty? lst) ' ()]
      [else (cons (+ (car lst) 1)
                  (add1 (cdr lst)))])))


(define squares
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [else (cons (* (car lst) (car lst))
                  (squares (cdr lst)))])))


(define map-alt
  (lambda (fn lst)
    (cond
      [(empty? lst) '()]
      [else (cons (fn (car lst))
                  (map-alt fn (cdr lst)))])))


(define deep-list
  '((1 2 (3) (4 5 (6)) 7) 8 (9 (10))))


(define deep-sum-list
  (lambda (deep-lst)
    (cond
      [(empty? deep-lst) 0]
      [(list? (car deep-list))
       (+ (deep-sum-list (car deep-lst))
          (deep-sum-list (cdr deep-list)))]
      [else (+ (car deep-lst)
               (deep-sum-list (cdr deep-lst)))])))


(define deep-search-list
  (lambda (n lst)
    (cond
      [(empty? lst) #f] ;; Es un false
      [(list? (car lst))
       (or (deep-search-list (car lst))
           (deep-search-list (car lst)))]
      [(eq? n (car lst)) #t]
      [else (deep-search-list n (cdr lst))])))



(define convert
  (lambda (n)
    (cond
      [n 1]
      [else 0])))


(define deep-map
  (lambda (fn lst)
    (cond
      [(empty? lst) '()]
      [(list? (car lst)) (cons
                          (deep-map fn (car lst))
                          (deep-map fn (cdr lst)))]
      [else (cons (fn (car lst))
                  (deep-map fn (cdr lst )))])))


(define deep-redux
  (lambda (fn lst)
    (cond
      [(empty? lst) '()]
      [(list? (car lst)) (cons
                          (deep-redux fn (car lst))
                          (deep-redux fn (cdr lst)))]
      [(fn (car lst))
       (cons (car lst)
             (deep-redux fn (cdr lst)))]
      [else (deep-redux fn (cdr lst))])))

(define lst
  '(1 2 3 4))

