:- use_module(library(clpfd)).

% seznam L ima 9 elementov
length9(L) :- length(L, 9).

% ali Rows je pravilno izpolnjen Sudoku
sudoku(Rows) :-
    length9(Rows), % imamo devet vrstic
    maplist(length9, Rows), % vsaka vrstica ima 9 elementov
    append(Rows, Vs), Vs ins 1..9, % vsi elementi so med 1 in 9
    distinct_rows(Rows), 
    distinct_columns(Rows),
    distinct_boxes(Rows).

% vsaka vrstica je permutacija
distinct_rows(Rows) :-
    maplist(all_distinct, Rows).

% vsak stolpec je permutacija
distinct_columns(Rows) :-
    transpose(Rows, Columns),
    maplist(all_distinct, Columns).

distinct_boxes(Rows) :-
    Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
    distinct_boxes3(As, Bs, Cs), % podkvadrati v vrsticah 1, 2, 3
    distinct_boxes3(Ds, Es, Fs), % podkvadrati v vrsticah 4, 5, 6
    distinct_boxes3(Gs, Hs, Is). % podkvadrati v vrsticah 7, 8, 9

    % vsak kvadratek v danih treh vrsticah je permutacija
distinct_boxes3([], [], []).
distinct_boxes3([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
    all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
    distinct_boxes3(Ns1, Ns2, Ns3).

% pomožni predikat, ki naredi label na vseh elementih matrike
find(Rows) :-
    append(Rows, Vs), label(Vs).

example1([[_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,3,_,8,5],
          [_,_,1,_,2,_,_,_,_],
          [_,_,_,5,_,7,_,_,_],
          [_,_,4,_,_,_,1,_,_],
          [_,9,_,_,_,_,_,_,_],
          [5,_,_,_,_,_,_,7,3],
          [_,_,2,_,1,_,_,_,_],
          [_,_,_,_,4,_,_,_,9]]).

example2([[5,3,_,_,7,_,_,_,_],
          [6,_,_,1,9,5,_,_,_],
          [_,9,8,_,_,_,_,6,_],
          [8,_,_,_,6,_,_,_,3],
          [4,_,_,8,_,3,_,_,1],
          [7,_,_,_,2,_,_,_,6],
          [_,6,_,_,_,_,2,8,_],
          [_,_,_,4,1,9,_,_,5],
          [_,_,_,_,8,_,_,7,9]]).

example3([[1,2,3,4,5,6,7,8,9],
          [_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_]]).

% Usage: ?- example1(Rows), sudoku(Rows), find(Rows), maplist(portray_clause, Rows).
