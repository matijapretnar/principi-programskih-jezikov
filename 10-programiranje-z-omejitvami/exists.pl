exists(P, [H|_]) :-
    call(P, H).
exists(P, [_|T]) :-
    exists(P, T).

maplist(P, [H|T]) :-
    call(P, H),
    exists(P, T).

% exists(P, [H|T]) :-
%     call(P, H);
%     exists(P, T).

je_nic(0).
