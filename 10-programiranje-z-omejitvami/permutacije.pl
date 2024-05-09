:- use_module(library(clpfd)).

permutacija(N, P) :-
    length(P, N),
    P ins 1..N,
    all_distinct(P).

vse_funkcije_iz_n_v_m_elementov(N, M, F) :-
    length(F, N),
    F ins 1..M.
    
vse_injektivne_funkcije_iz_n_v_m_elementov(N, M, F) :-
    length(F, N),
    F ins 1..M,
    all_distinct(F).
    
vse_surjektivne_funkcije_iz_n_v_m_elementov(N, M, F) :-
    length(F, N),
    F ins 1..M
    % 1..M ins F.
    . 
