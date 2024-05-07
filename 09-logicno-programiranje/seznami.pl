% Sezname bomo pisali kot cons(a, cons(b, cons(c, nil)))

member(X, cons(X, _)).
member(X, cons(_, L)) :-
    member(X, L).

join(nil, L, L).
join(cons(X, L1), L2, cons(X, L3)) :-
    join(L1, L2, L3).

reverse(nil, nil).
reverse(cons(X, L), S) :-
    reverse(L, R),
    join(R, cons(X, nil), S).

reverseJoin(L, nil, L).
reverseJoin(L1, cons(X, L2), L3) :-
    reverseJoin(cons(X, L1), L2, L3).

efficientReverse(L1, L2) :-
    reverseJoin(nil, L1, L2).