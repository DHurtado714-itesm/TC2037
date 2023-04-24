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

% Queries de ejemplo
% lasto([1,2,3,4], Result)
% Result = 4.

# Ejericio 2

# (butlasto lst result): Funcion logica que tiene exito si result contiene los mismos elementos
# que lst, excepto el ultimo

# Ejemplo de uso:
# (run 1 (q) (butlasto '(1 2 3 4) q)) -> ((1 2 3))
# (run 1 (q) (butlasto q '(1 2 3 4))) -> ((1 2 3 4 _.0))
# (run 1 (q) (butlasto '(1 2 3 4) '(1 2 3 4))) -> ()
# (run 3 (p q) (butlasto p q)) -> (((_.0) ()) ((_.0 _.1) (_.0)) ((_.0 _.1 _.2) (_.0 _.1)))

lasto([X], X).

lasto([_|Tail], X) :- lasto(Tail, X). 


% Queries de ejemplo:
% ?- butlasto([1, 2, 3, 4], X).
% X = [1, 2, 3].

# Ejercicio 3

enlisto([], []). 
enlisto([Head|Tail], [[Head]|Result]) :- enlisto(Tail, Result). 

% Queries de ejemplo:
% enlisto(q, [[a],[b],[c],[d]]).
% false

# Ejercicio 4

duplicateo([], []).
duplicateo([H|T], [H, H|R]) :- duplicateo(T, R).

% Queries de ejemplo:
% ?- duplicateo([1, 2, 3], X).
% X = [1, 1, 2, 2, 3, 3].

# Ejercicio 5

removeo(_, [], []).
removeo(X, [X|T], T). 
removeo(X, [Head|Tail], [Head|Result]) :- removeo(X, Tail, Result). 

% Queries de ejemplo
% ?- removeo(3, [1, 2, 3, 4, 5], Result).
% Result = [1, 2, 4, 5] 

# Ejercicio 6

reverseo([], []).
reverseo([X], [X]).
reverseo(List, Result) :- reverse(List, Result).

% Queries de ejemplo:
% ?- reverseo([1, 2, 3, 4], X).
% X = [4, 3, 2, 1].
% ?- reverseo(X, [a,b,c,d,e]).
% X = [e, d, c, b, a] .

# Ejercicio 7

palindromeo([]). 
palindromeo([_]). 
palindromeo(List) :- reverse(List, List).

% Queries de ejemplo:
% ?- palindromeo([a,b,c,d,c,b,a]).true.
% ?- palindromeo([a,b,c,d,e,f,g]).false.

# Ejercicio 8

rotateo([H|T], R) :- append(T, [H], R).

% Queries de ejemplo:
% ?- rotateo([1, 2, 3, 4], X).
% X = [2, 3, 4, 1].

# Ejercicio 9

evensizeo([]). %9
evensizeo([_|T]) :- oddsizeo(T). %9

oddsizeo([_]). %9
oddsizeo([_|T]) :- evensizeo(T). %9

% Queries de ejemplo
% ?- evensizeo([a, b, c, d, e]).false.

% ?- evensizeo([a, b, c, d]).true .

% ?- oddsizeo([a,b,c,d,e]).
% true .

% ?- oddsizeo([a,b,c,d]).
% false.

# Ejercicio 10

splito([], [], []).
splito([X], [X], []).
splito([X, Y|T], [X|R1], [Y|R2]) :- splito(T, R1, R2).

% Queries de ejemplo:
% ?- splito([1, 2, 3, 4, 5], A, B).
% A = [1, 3, 5], B = [2, 4].

# Ejercicio 11

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

equalo([]).
equalo([_]).
equalo([H, H|T]) :- equalo([H|T]).

% Queries de ejemplo:
% ?- equalo([1, 1, 1, 1]).
% true.
% ?- equalo([1, 1, 1, 2]).
% false.

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

