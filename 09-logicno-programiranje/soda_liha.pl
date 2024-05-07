even(succ(X)) :-
even(succ(X)) :-
    odd(X).
odd(succ(X)) :-
    even(X).
