# Problemario: Programacion Logica (actividad 5.1)
# File: main.pl

# Authors: 
# - Daniel Hurtado (A01707774)
# - Carlos Velasco (A01708634)

# Date: 2023-04-23

# Ejericio 1

# (lasto lst x): Funcion logica que tiene exito si x es el ultimo 
# elemento de la lista

# Ejemplo de uso:
# (run 1 (q) (lasto '(1 2 3 4) q)) -> (4)
# (run 1 (q) (lasto () q)) -> ()
# (run 5 (q) (lasto q 'a)) -> ((a) (_.0 a) (_.0 _.1 a) (_.0 _.1 _.2 a) (_.0 _.1 _.2 _.3 a))

lasto([], X) :- X = [].
lasto([_|T], X) :- lasto(T, X).

# Ejericio 2

# (butlasto lst result): Funcion logica que tiene exito si result contiene los mismos elementos
# que lst, excepto el ultimo

# Ejemplo de uso:
# (run 1 (q) (butlasto '(1 2 3 4) q)) -> ((1 2 3))
# (run 1 (q) (butlasto q '(1 2 3 4))) -> ((1 2 3 4 _.0))
# (run 1 (q) (butlasto '(1 2 3 4) '(1 2 3 4))) -> ()
# (run 3 (p q) (butlasto p q)) -> (((_.0) ()) ((_.0 _.1) (_.0)) ((_.0 _.1 _.2) (_.0 _.1)))

butlasto([_], []).
butlasto([H|T], [H|R]) :- butlasto(T, R).

# Ejercicio 3

# (enlisto lst result): Funcion logica que tiene  ́exito si result contiene 
# los mismos elementos que lst pero cada uno colacado dentro de una lista.

# Ejemplo de uso:
# (run 1 (q) (enlisto '(a b c d e) q)) -> (((a) (b) (c) (d) (e)))
# (run 1 (q) (enlisto q '(a b c d e))) -> ()
# (run 1 (q) (enlisto q '((a) (b) (c) (d) (e)))) -> ((a b c d e))
# (run 3 (p q) (enlisto p q)) -> ((() ()) ((_.0) ((_.0))) ((_.0 _.1) ((_.0) (_.1))))

enlisto([], []). 
enlisto([Head|Tail], [[Head]|Result]) :- enlisto(Tail, Result). 

# Ejercicio 4

# (duplicateo lst result): Funcion logica que tiene exito si cada elemento en lst 
# aparece duplicado en result.

# Ejemplo de uso:

# (run 1 (q) (duplicateo '(1 2 3 4) q)) -> ((1 1 2 2 3 3 4 4))
# (run 1 (q) (duplicateo q '(a a b b c c))) -> ((a b c))
# (run 1 (q) (duplicateo q '(a a b b c c d))) -> ()
# (run 3 (p q) (duplicateo p q)) -> ((() ()) ((_.0) ((_.0))) ((_.0 _.1) ((_.0 _.1))))

duplicateo([], []).
duplicateo([H|T], [H, H|R]) :- duplicateo(T, R).

% Queries de ejemplo:
% ?- duplicateo([1, 2, 3 4], X).
% X = [1, 1, 2, 2, 3, 3, 4, 4].

# Ejercicio 5

# (removeo x lst result): Funcion logica que tiene exito si se puede eliminar la 
# primera ocurrencia de x en lst obteniendo result

# Ejemplo de uso:

# (run 1 (q) (removeo 3 '(1 2 3 4) q)) -> ((1 2 4))
# (run 1 (q) (removeo 5 '(1 2 3 4) q)) -> ()
# (run 1 (q) (removeo q '(1 2 3 4) '(1 2 4))) -> (3)
# (run 5 (q) (removeo 0 q '(1 2 3 4))) -> ((0 1 2 3 4) (1 0 2 3 4) (1 2 0 3 4) (1 2 3 0 4) (1 2 3 4 0))
# (run* (p q) (removeo p '(1 2 3 4) q)) -> ((1 (2 3 4)) (2 (1 3 4)) (3 (1 2 4)) (4 (1 2 3)))

removeo(_, [], []).
removeo(X, [X|T], T). 
removeo(X, [Head|Tail], [Head|Result]) :- removeo(X, Tail, Result). 

# ------------------------------
# Aqui llegue
# ------------------------------

# Ejercicio 6

# (reverseo lst result): Funci ́on l ́ogica que tiene  ́exito si result es la reversa de lst.

# Ejemplo de uso:

# (run 1 (q) (reverseo '(a b c d) q)) -> ((d c b a))
# (run 1 (q) (reverseo q '(a b c d))) -> ((d c b a))
# (run 1 (q) (reverseo '(a b c d) '(e d c b a))) -> ()

reverseo([], []).
reverseo([X], [X]).
reverseo(List, Result) :- reverse(List, Result).

% Queries de ejemplo:
% ?- reverseo([1, 2, 3, 4], X).
% X = [4, 3, 2, 1].
% ?- reverseo(X, [a,b,c,d,e]).
% X = [e, d, c, b, a] .

# Ejercicio 7

# (palindromeo lst): Funcion logica que tiene exito si lst es un palındromo 
# (se lee igual de izquierda a derecha que de derecha a izquierda).

palindromeo([]). 
palindromeo([_]). 
palindromeo(List) :- reverse(List, List).

# Ejercicio 8

# (rotateo lst result): Funcion logica que tiene exito cuando result es el resultado 
# de girar lst hacia la izquierda una posicion. En otras palabras, el primer elemento 
# de lst se convierte en el ultimo elemento de result

# Ejemplo de uso:

# (run 1 (q) (rotateo '(a b c d e) q)) -> ((b c d e a))
# (run 1 (q) (rotateo q '(a b c d e))) -> ((e a b c d))
# (run 1 (q) (rotateo '(a b c d e) '(a b c d e))) -> ()

rotateo([H|T], R) :- append(T, [H], R).

# Ejercicio 9

# (evensizeo lst) y (oddsizeo lst): Estas dos funciones logicas deben definirse de 
# manera mutuamente recursiva. Es decir, cada una debe definirse en terminos de la otra. 
# Estas funciones tienen exito si el numero de elementos en lst es par o impar, 
# respectivamente.

# Ejemplo de uso:

# (run 1 (q) (evensizeo '(a b c d)) (== q 'yes)) ⇒ (yes)
# (run 1 (q) (oddsizeo '(a b c)) (== q 'yes)) ⇒ (yes)
# (run 1 (q) (oddsizeo '(a b c d)) (== q 'yes) ⇒ ()
# (run 4 (q) (evensizeo q)) ⇒ (() (_.0 _.1) (_.0 _.1 _.2 _.3) (_.0 _.1 _.2 _.3 _.4 _.5))


evensizeo([]). %9
evensizeo([_|T]) :- oddsizeo(T). %9

oddsizeo([_]). %9
oddsizeo([_|T]) :- evensizeo(T). %9

# Ejercicio 10

# (splito lst a b): Funci ́on l ́ogica que tiene  ́exito cuando al dividir lst se obtiene 
# a y b. Los elementos primero, tercero, quinto, etc. de lst van en a, mientras que los 
# elementos segundo, cuarto, sexto, etc. van en b.

# Ejemplo de uso:

# (run 1 (p q) (splito '(a 1 b 2 c 3 d 4 e) p q))
# ⇒ (((a b c d e) (1 2 3 4)))
# (run 1 (q) (splito q '(a b c d e) '(1 2 3 4)))
# ⇒ ((a 1 b 2 c 3 d 4 e))
# (run 1 (q) (splito '(a b c) '(a b c) q))
# ⇒ ()
# (run 1 (q) (splito '(a b c) '(a c) q))
# ⇒ ((b))

splito([], [], []).
splito([X], [X], []).
splito([X, Y|T], [X|R1], [Y|R2]) :- splito(T, R1, R2).

% Queries de ejemplo:
% ?- splito([1, 2, 3, 4, 5], A, B).
% A = [1, 3, 5], B = [2, 4].

# Ejercicio 11

# (swappero a b lst result): Funci ́on l ́ogica que tiene  ́exito solo si result contiene 
# los mismos elementos que lst excepto que cada ocurrencia de a se intercambia por b, 
# y viceversa

# Ejemplo de uso:

# run 1 (q) (swappero 'a 'b '(a b a b b b a) q))
# ⇒ ((b a b a a a b))
# (run 1 (q) (swappero 'a 'b q '()))
# ⇒ (()))
# (run 1 (q) (swappero 'purr
# 'kitty
# '(soft kitty warm kitty little ball of fur
# happy kitty sleepy kitty purr purr purr) q))
# ⇒ ((soft purr warm purr little ball of fur happy purr sleepy purr kitty kitty kitty))

swappero(_, _, [], []). 
swappero(A, B, [A|T], [B|R]) :- swappero(A, B, T, R). 
swappero(A, B, [B|T], [A|R]) :- swappero(A, B, T, R). 
swappero(A, B, [H|T], [H|R]) :- dif(H, A), dif(H, B), swappero(A, B, T, R).

% Queries de ejemplo
% ?- swappero(purr, kitty, [soft,kitty,warm,kitty,little,ball,of,fur, happy, kitty, sleepy, kitty, purr, purr, purr], Result).
% Result = [soft, purr, warm, purr, little, ball, of, fur, happy|...] 
% ?- swappero(a, b, [a, b, a, b, b, b, a], Result).
% Result = [b, a, b, a, a, a, b]

# Ejercicio 12

# (equalo lst): Funcion logica que tiene exito solo si todos los elementos contenidos 
# en lst se unifican con el mismo valor. La funci ́on siempre debe tener exito si lst 
# esta vacia o tiene un solo elemento.

# Ejemplo de uso:
# (run* (q) (equalo '()) (== q 'yes))
# ⇒ (yes)
# (run 1 (q) (equalo '(a a a a a a)) (== q 'yes))
# ⇒ (yes)
# (run 1 (q) (equalo '(a a a a b a)) (== q 'yes))
# ⇒ ()
# (run 5 (q) (equalo q))
# ⇒ (() (_.0) (_.0 _.0) (_.0 _.0 _.0) (_.0 _.0 _.0 _.0))

equalo([]).
equalo([_]).
equalo([H, H|T]) :- equalo([H|T]).

# Ejercicio 13



subseto([], _). %13
subseto([H|T], B) :- member(H, B), subseto(T, B). %13

% Queries de ejemplo
% ?- subseto([b,d], [a,b,c,d,e]).true .
% ?- subseto([a,b,c,d,e],[a,b,c,d]).false.

# Ejercicio 14

compresso_helper([], Acc, R) :- reverse(Acc, R).
compresso_helper([X], Acc, R) :- reverse([X|Acc], R).
compresso_helper([X, X|T], Acc, R) :- compresso_helper([X|T], Acc, R).
compresso_helper([X, Y|T], Acc, R) :- dif(X, Y), compresso_helper([Y|T], [X|Acc], R).

% Queries de ejemplo:
% ?- compresso([1, 1, 1, 2, 2, 3, 4, 4, 4, 4], X).
% X = [1, 2, 3, 4].

