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

# Charly: usa esto como ejemplo para tus ejercicios (lo que puse no se si es correcto)

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

% Queries de ejemplo:
% ?- butlasto([1, 2, 3, 4], X).
% X = [1, 2, 3].

# Ejericio 4

duplicateo([], []).
duplicateo([H|T], [H, H|R]) :- duplicateo(T, R).

% Queries de ejemplo:
% ?- duplicateo([1, 2, 3], X).
% X = [1, 1, 2, 2, 3, 3].

# Ejercicio 6

reverseo_helper([], Acc, Acc).
reverseo_helper([H|T], Acc, R) :- reverseo_helper(T, [H|Acc], R).

% Queries de ejemplo:
% ?- reverseo([1, 2, 3, 4], X).
% X = [4, 3, 2, 1].

# Ejercicio 8

rotateo([H|T], R) :- append(T, [H], R).

% Queries de ejemplo:
% ?- rotateo([1, 2, 3, 4], X).
% X = [2, 3, 4, 1].

# Ejercicio 10

splito([], [], []).
splito([X], [X], []).
splito([X, Y|T], [X|R1], [Y|R2]) :- splito(T, R1, R2).

% Queries de ejemplo:
% ?- splito([1, 2, 3, 4, 5], A, B).
% A = [1, 3, 5], B = [2, 4].

# Ejercicio 12

equalo([]).
equalo([_]).
equalo([H, H|T]) :- equalo([H|T]).

% Queries de ejemplo:
% ?- equalo([1, 1, 1, 1]).
% true.
% ?- equalo([1, 1, 1, 2]).
% false.

# Ejercicio 14

compresso_helper([], Acc, R) :- reverse(Acc, R).
compresso_helper([X], Acc, R) :- reverse([X|Acc], R).
compresso_helper([X, X|T], Acc, R) :- compresso_helper([X|T], Acc, R).
compresso_helper([X, Y|T], Acc, R) :- dif(X, Y), compresso_helper([Y|T], [X|Acc], R).

% Queries de ejemplo:
% ?- compresso([1, 1, 1, 2, 2, 3, 4, 4, 4, 4], X).
% X = [1, 2, 3, 4].

