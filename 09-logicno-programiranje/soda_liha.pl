even(zero).
even(succ(X)) :-
    odd(X).
odd(succ(X)) :-
    even(X).
