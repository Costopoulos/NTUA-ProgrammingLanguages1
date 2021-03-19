:- use_module(library(ugraphs)).
sum([], 0).      /*calulates the sum of the list*/
sum([H|T], N):-
    sum(T, X),
    N is X + H.



coronograph(File, Answers):-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    number_codes(T, Line),
    read_lines(Stream, T, Answers).

read_lines(_, 0, _).
read_lines(Stream, 1, [T1]):-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, [N, M]),
    read_edges(M, Stream, [], Graph),
    main(Graph, M, N,  T1),
    read_lines(Stream, 0 ,T1), !.


read_lines(Stream, T, [Answer|T1]):-
    T>1,
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, [N, M]),
    read_edges(M, Stream, [], Graph),
    NewT is T-1,
    main(Graph, M, N,  Answer),
    read_lines(Stream, NewT ,T1),
    !.

read_edges(0, _, Graph, Graph):- !.
read_edges(M, Stream, Graph, L):-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, [N1, N2]),
    assertz(edge(N1, N2)),
    assertz(edge(N2,N1)),
    M1 is M-1,
    add_edges(Graph, [N1-N2, N2-N1], NewGraph),
    read_edges(M1, Stream, NewGraph, L).




connected(X, Y):- edge(X,Y); edge(Y,X).


dfs(Graph, Node,P):-
 member(Node-Neighbors, Graph),
 assertz(ves(Node)),
 member(NextNode, Neighbors),
 (\+ves(NextNode) ->
    assertz(pr(NextNode, Node)),
    dfs(Graph, NextNode, 0)
    ;detectcycle(Node, NextNode,P)
    ), !.


detectcycle(A,B,P):-
    \+ pr(A,B),
    assertz(circle(1)),
    path(A,B, P),!.



path(A,B,Path) :-
       travel(A,B,[A],Q),
       length(Q, L),
       L > 2,
       Path = Q, !.

travel(A,B,P,[B|P]) :-
       connected(A,B).
travel(A,B,Visited,Path) :-
       connected(A,C),
       C \== B,
       \+member(C,Visited),
       travel(C,B,[C|Visited],Path),!.





firstdelete( Graph, [H|T], NewGraph):-
    last([H|T], L),
    del_edges(Graph, [H-L, L-H], NewGraph).




secdelete([_], NewGraph, NewGraph).
secdelete([F|[K|T]], Graph, NewGraph):-
    del_edges(Graph, [F-K, K-F], N),
    secdelete([K|T], N, NewGraph),!.

cyclelist( _, [], Out, Out).
cyclelist( Graph, [H|T], List2, Out):-
    reachable(H, Graph, L),
    length(L, K),
    append([K], List2, List3),
    cyclelist(Graph,T, List3, Out),!.

main(Graph, M, _,  Answer):-
    reachable(1, Graph, Z),
    length(Z, K),
    (K =\= M ->
    retractall(edge),
    Answer = "'NO CORONA'"
    ;dfs(Graph, 1, P),
    firstdelete( Graph, P, NewGraph),
    secdelete(P, NewGraph, V),
    cyclelist( V, P, [], Out),
    sort(Out, List),
    sum(List, Sum),
    Sum =:= M,
    length(List, L),
    retractall(edge),
    retractall(ves),
    retractall(pr),
    Answer = [ L,List]
    ).
