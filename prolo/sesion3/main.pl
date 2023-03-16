%% filter(List, Pivot, Menores, Mayores)
filter([], _, [], []).
filter([Head | Tail], Pivot, [Head | Lesser], Greater) :-
  Head < Pivot,
  filter(Tail, Pivot, Lesser, Greater).
filter([Head | Tail], Pivot, Lesser, [Head | Greater]) :-
  Head >= Pivot,
  filter(Tail, Pivot, Lesser, Greater).

%% quick_sort(Unsorted, Sorted)
quick_sort([], []) :- !.
quick_sort([X], [X]) :- !.
quick_sort([Head | Tail], Sorted) :-
  filter(Tail, Head, Lesser, Greater),
  quick_sort(Lesser, SortedLesser),
  quick_sort(Greater, SortedGreater),
  append(SortedLesser, [Head | SortedGreater], Sorted).

empty_stack([]).
push_stack(X, Stack, [X | Stack]).

%% arc(Origin, Destination).

arc(1, 2).
arc(1, 3).
arc(1, 4).
arc(2, 5).
arc(2, 6).
arc(2, 7).
arc(3, 8).
arc(3, 9).
arc(3, 10).
arc(4, 5).
arc(4, 7).
arc(4, 9).
arc(4, 11).
arc(7, 8).
arc(7, 10).
arc(8, 9).

%% conection(A, B) :- arc(A, B); arc(B, A).

dfs(Start, Goal, Path) :-
  push_stack(Start, [], Visited),
  path(Start, Goal, Visited).

%% Path(Current, Goal, Visited).
path(Goal, Goal, _),
path(Current, Goal, Visited) :-
  arc(Current, Next),
  not(member(Current, Next)),
  push_stack(Next, Visited, NewVisited),
  path(Next, Goal, NewVisited).






