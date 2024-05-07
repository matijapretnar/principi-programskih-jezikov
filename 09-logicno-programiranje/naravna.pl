% Naravna števila bomo pisali kot succ(succ(succ(zero)))

plus(X, zero, X).
plus(X, succ(Y), succ(Z)) :-
    plus(X, Y, Z).

ena(succ(zero)).
dva(M) :-
    ena(N),
    plus(N, N, M).

times(_, zero, zero).
times(X, succ(Y), R) :-
    times(X, Y, X_krat_Y), % X * Y = XY
    plus(X_krat_Y, X, R).  % XY + X = R

stiri(M) :-
    dva(N),
    times(N, N, M).
sest(M) :-
    dva(N),
    stiri(P),
    plus(N, P, M).

fact(zero, succ(zero)).
fact(succ(X), R) :-
    fact(X, S),
    times(S, succ(X), R).
