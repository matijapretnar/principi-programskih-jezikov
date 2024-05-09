% fakulteta z lastnimi naravnimi števili

plus(X, zero, X).
plus(X, succ(Y), succ(Z)) :-
    plus(X, Y, Z).

times(_, zero, zero).
times(X, succ(Y), R) :-
    times(X, Y, XY), % X * Y = XY
    plus(XY, X, R).  % XY + X = R

fact(zero, succ(zero)).
fact(succ(X), R) :-
    fact(X, S),
    times(S, succ(X), R).

% fakulteta z vgrajenimi celimi števili

fact_int(0, 1).
fact_int(Y, R) :-
    Y > 0,
    X is Y - 1,
    fact_int(X, S),
    R is S * Y.

% fakulteta z omejitvami

:- use_module(library(clpfd)).

fact_clpfd(0, 1).
fact_clpfd(Y, R) :-
    Y #> 0,
    X #= Y - 1,
    R #= S * Y,
    fact_clpfd(X, S).