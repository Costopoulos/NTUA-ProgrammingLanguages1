:- dynamic end/1.
:- dynamic solution/2.

testend(_, _, [_|_]).
testend(N, String, []) :-
    assert(end(N)),
    assert(solution(N, String)).	
    
pp(N, String, [Q|List1], List2, List3, List4) :-	
    List3 = List1,
    List4 = [Q|List2],
    testend(N, String, List3).


p(N, Q, W, V, T, Y, Z, QQ, WW, VV) :-
    string_concat('p', V, TT),
    pp(N, TT, Q, W, AA, BB),
    append(T, [AA], QQ),
    append(Y, [BB], WW),
    append(Z, [TT], VV).
    
    comple([], []).
comple([Q|List1], [W|List2]) :-
    comple(List1, List2),
    ((Q = 'A', W = 'U');
    (Q = 'U', W = 'A');
    (Q = 'C', W = 'G');
    (Q = 'G', W = 'C')).
    
c(Q, W, V, T, Y, Z, QQ, WW, VV) :-
    string_concat('c', V, TT),
    comple(Q, AA),
    append(T, [AA], QQ),
    append(Y, [W], WW),
    append(Z, [TT], VV).
    
r(Q, W, V, T, Y, Z, QQ, WW, VV) :-
    string_concat('r', V, TT),
    reverse(W, Bnew),
    append(T, [Q], QQ),
    append(Y, [Bnew], WW),
    append(Z, [TT], VV).



tes1(Q, W, V, T, Y, Z, XN, YN, ZN) :-
    sub_atom(V, 0, 1, _, 'p') ->
    c(Q, W, V, T, Y, Z, XN, YN, ZN);
    (XN = T, YN = Y, ZN = Z).
    
tes2(H1, N, Q, W, V, T, Y, Z, XN, YN, ZN) :-
    \+ member(H1, W) ->
    p(N, Q, W, V, T, Y, Z, XN, YN, ZN);
    (XN = T, YN = Y, ZN = Z).
    
tes3(Q, W, V, T, Y, Z, XN, YN, ZN) :-
    (\+ sub_atom(V, 0, 1, _, 'r'),
    W = [_|[_|_]]) ->
    r(Q, W, V, T, Y, Z, XN, YN, ZN);
    (XN = T, YN = Y, ZN = Z).

bra(N, [Q|T], [W|Y], [V|Z]) :-
    end(N) -> true ;
    (Q = [H1|_],
    tes1(Q, W, V, T, Y, Z, XX1, YY1, ZZ1),!,
    tes2(H1, N, Q, W, V, XX1, YY1, ZZ1, XX2, YY2, ZZ2),!,
    tes3(Q, W, V, XX2, YY2, ZZ2, XX3, YY3, ZZ3),!,
    find(N, XX3, YY3, ZZ3)).    

find(N, [Q|T], [W|Y], [V|Z]) :-
    end(N) -> true ;
    ((Q = [H1|_],
    W = [H1|_],
    p(N, Q, W, V, T, Y, Z, QQ, WW, VV)) ->
    find(N, QQ, WW, VV);
    bra(N, [Q|T], [W|Y], [V|Z])).
    
res(Stream, N, L, Answer) :-
    N =\= 0,
    read_line_to_string(Stream, String),
    atom_chars(String, LList),
    reverse(LList, RRList),
    find(N, [RRList], [[]], ['']),!,
    solution(N, Solution),
    string_chars(Solution, SSlist),
    reverse(SSlist, SSlist2),
    string_chars(Solution2, SSlist2),
    append(L, [Solution2], LLnew),!,
    NNnew is N-1,
    res(Stream, NNnew, LLnew, Answer).
    
res(_, 0, L, Answer) :- Answer = L.

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).
    
vaccine(File, Answer) :-
    open(File, read, Stream),
    read_line(Stream, [N]),
    res(Stream, N, [], Answer),
    retractall(end(_)),
    retractall(solution(_, _)).    