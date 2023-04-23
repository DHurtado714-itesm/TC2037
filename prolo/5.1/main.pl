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

