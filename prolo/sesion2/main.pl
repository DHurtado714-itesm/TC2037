fact(1, 1).
fact(N, X) :-
  X > 1,
  X1 is X - 1,
  fact(N1, X1),
  N is X * N1.

fact_tail(1, 1, 1).
fact_tail(X, Res, Acc) :-
  NewX is X - 1,
  NewAcc is Acc * X,
  fact_tail(NewX, Res, NewAcc).

# fact_tail(5, Res, 1).

sum_head(End, End, End). # Caso base -> suma de end a end es igual a end
sum_head(Start, End, Result) :-
  Start < End,
  NewStart is Start + 1,
  sum_head(NewStart, End, NewResult),
  Result is Result + Start.
  
# sum(1, 100, X) -> 5050

sum_tail(End, End, Acc, Result) :-
  Result is Acc + End.

sum_tail(Start, End, Acc, Result) :-
  Start < End,
  NewAcc is Acc + Start,
  NewStart is Start + 1,
  sum_tail(NewStart, End, NewAcc, Result).

# sum_tail(1, 100, 0, X) -> 5050

fib_head(1, 1).
fib_head(2, 1).
fib_head(N, Result) :-
  N > 2
  N1 is N - 1,
  fib_head(N1, R1),
  N2 is N - 2,
  fib_head(N2, R2),
  Result is R1 + R2.

# fib_head(8, X) -> 21

fibo_tail(0, _, Result, Result).
fibo_tail(N, A, B, Result) :-
  N > 0,
  NewN is N - 1,
  C is A + B,
  fibo_tail(NewN, B, C, Result).

# fibo_tail(8, 1, 1, Result) -> 21

first([Head | _], Head).
rest([_ | Tail], Tail).
second([_ | Second | _], Second).

len([], 0).
len([_ | Tail], Result) :-
  len(Tail, R1),
  Result is R1 + 1.

# len([1, 2, 3, 4, 5], X). -> 5

sum_list([], 0).
sum_list([Head | Tail], Result) :-
  sum_list(Tail, R1),
  Result is Head + R1.

find_list([Head | _], Head).
find_list([Head | Tail], X) :-
  Head \== X,
  find_list(Tail, X).

add2([], []).
add2([Head | Tail], [NewHead | NewTail]) :-
  NewHead is Head + 2,
  add2(Tail, NewTail).

remove_from_list(_, [], []).
remove_from_list(Head, [Head | Tail], NewTail) :-
  remove_from_list(Head, Tail, NewTail).
remove_from_list(X, [Head | Tail], [Head | NewTail]) :-
  X \== Head,
  remove_from_list(X, Tail, NewTail).

%% my_append(L1, L2, Result).
my_append([], L2, L2).
my_append(L1, [], L1).
my_append([Head | Tail], L2, [Head | NewTail]) :-
  my_append(Tail, L2, NewTail).

# my_append([1, 2, 3], [4, 5, 6], X). -> [1, 2, 3, 4, 5, 6]

%% my_merge(L1, L2, Result).
my_merge([], L2, L2).
my_merge(L1, [], L1).
my_merge([H1 | T1], [H2 | T2], [H1 | Temp]) :-
  H1 < H2,
  my_merge(T1, [H2 | T2], Temp).
my_merge([H1 | T1], [H2 | T2], [H2 | Temp]) :-
  H1 >= H2,
  my_merge([H1 | T1], T2, Temp).

%% split(Input, Output1, Output2).
split([], [], []).
split([X], [X], []).
split([Head | Tail], [Head | R1], R2) :-
  split(Tail, R2, R1).

%% merge_sort(Unsorted, Sorted).
merge_sort([], []) :- !.
merge_sort([X], [X]) :- !.
merge_sort(Unsorted, Sorted) :-
  split(Unsorted, L1, L2),
  merge_sort(L1, S1),
  merge_sort(L2, S2),
  my_merge(S1, S2, Sorted), !.

# merge_sort([6, 5, 4, 3, 2, 1], X). -> [1, 2, 3, 4, 5, 6]







