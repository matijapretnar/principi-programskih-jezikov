plus(X, 0, X).
plus(X, Yn, Zn) :-
    Y is Yn - 1,
    plus(X, Y, Z),
    Zn is Z + 1.

times(_, 0, 0).
times(X, Yn, R) :-
    Y is Yn - 1,
    times(X, Y, XY), % X * Y = XY
    plus(XY, X, R).  % XY + X = R

fact(0, 1).
fact(Xn, R) :-
    Xn > 0,
    X is Xn - 1,
    fact(X, S),
    times(S, Xn, R).

superFact(0, 1).
superFact(Xn, R) :-
    Xn > 0,
    X is Xn - 1,
    superFact(X, S),
    R is S * Xn.
