:- use_module(library(clpfd)).

trojica(A, B, C) :-
    % A #>= 0, B #>= 0, C #>= 0,
    % [A, B, C] ins 0..sup,
    0 #< A, A #< B, 0 #< C, 
    A * A + B * B #= C * C.

vse_pod(A, B, C, N) :-
    [A, B, C] ins 0..N,
    trojica(A, B, C),
    label([A, B, C]).
