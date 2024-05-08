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
