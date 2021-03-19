dec_bin(1,[1]).  /* converts a number from decimal to binary*/
dec_bin(0,[0]).
dec_bin(N,[X|L]):-
    N>1,
    X is N mod 2,
    Y is N//2,
    dec_bin(Y,L).

sum([], 0).      /*calulates the sum of the list*/
sum([H|T], N):-
    sum(T, X),
    N is X + H.

change(_, _,_, [], []). /* changes the i-th element of a list */
change(0, Y, L, [_|T], [Y|T1]):- I is L,  change(I, Y, L, T, T1).
change(I, Y, L, [H|T], [H|T1]):-
    I>0, I1 is I-1, change(I1, Y, L, T,  T1).

/* change arguments: (index of element, new value, list length - (index+1),
input list, final list) */

form(K, K, _, [H|T], [H|T]). /* returns the list in the propriate form */
form(S, K, I, [H|T], [Y|Z]) :-
    S < K, length([H|T],L), nth0(I,[H|T],M), I2 is I-1,nth0(I2, [H|T], N),
    ( M<1
    -> I1 is I+1,form(S,K,I1,[H|T],[Y|Z])
    ;P is M-1,I3 is I+1, L2 is L-I3,change(I, P, L2, [H|T], C),
    N1 is N+2,I4 is I2+1,L3 is L-I4,change(I2, N1, L3, C,OUT ), S2 is S+1,
    form(S2,K,1,OUT,[Y|Z])
    ).
/*form arguments: (list sum, main input K, I initialised to 1, input list, output list) */

list_butlast([X|Xs], Ys) :-       /* delets the last element and maintains the remaining list*/
   list_butlast_prev(Xs, Ys, X).

list_butlast_prev([], [], _).
list_butlast_prev([X1|Xs], [X0|Ys], X0) :-  %?- list_butlast([1,2,3], Xs).
   list_butlast_prev(Xs, Ys, X1).

delete_zeros(_,[],[]).  /* delets the anwanted zeros */
delete_zeros(1,[X|Xs], [X|Xs]).
delete_zeros(0,[X|Xs], [Y1|Ys1]):-
    last([X|Xs],L),
    (L =:= 0
    -> list_butlast([X|Xs], [Y|Ys]), delete_zeros(0,[Y|Ys], [Y1|Ys1])
    ;delete_zeros(1,[X|Xs], [Y1|Ys1])).

main2(N,K, OUT):- /* combines the upper functions and returns the proper list */
    dec_bin(N,Binary),
    sum(Binary,SumList),
    (SumList > K
    ->  delete_zeros(0,[],OUT)
    ;form(SumList, K, 1, Binary, Formed),
    delete_zeros(0,Formed,OUT)
    ).

powers2(File, Answers):-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    number_codes(T, Line),
    read_lines(Stream, T, Answers).

read_lines(_, 0, _).
read_lines(Stream, 1, [T1]):-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, [N, K]),
    main2(N,K,T1),
    read_lines(Stream, 0 ,T1),
    !.

read_lines(Stream, T, [Answer|T1]):-
    T>1,
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, [N, K]),
    main2(N,K,Answer),
    NewT is T-1,
    read_lines(Stream, NewT ,T1),
    !.
