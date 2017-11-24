% Instituto Tecnologico de Costa Rica
% Escuela de Ingenieria en Computacion
% Programacion Logica
% Prof.: Roxana Reyes
% Proyecto
% Saul Zamora
% 200835773

% aplana un nivel de la lista
flat([], []).
flat([H|T],R) :-
    is_list(H),
    flat(T,T1),
    !,
    append(H,T1,R).
flat(H,H).

% pregunta si una lista es un subconjunto de otra lista
isSubset([],_).
isSubset([H|T],Y):-
    member(H,Y),
    select(H,Y,Z),
    isSubset(T,Z).

% pregunta si una lista es igual a otra (desde el pto de vista de conjuntos, sin importar el orden)
equal(X,Y):-
    isSubset(X,Y),
    isSubset(Y,X),
    !.

% parte la lista a la mitad
split(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N),
    !.

% pregunta si un elemento NO ESTA en una lista
isNonElement(_, []).
isNonElement(E, [H|T]):-
    dif(E, H),
    isNonElement(E,T).

% code
% genera el conjunto de nodos V a partir de U
graphV(_, [], []).
graphV(E, [H|T], Res):-
    member(H, E),
    graphV(E, T, Res).
graphV(E, [H|T], [H|Res]):-
    isNonElement(H, E),
    graphV(E, T, Res).

% genera el conjunto de nodos U
graphU([],[]).
graphU([_|T],Res):-
    graphU(T,Res).
graphU([H|T],[H|Res]):-
    graphU(T,Res).

% retorna todas las posibilidades de U y V
allPosiblesGraphs(L,[U|[V]]):-
    graphU(L,U),
    U \= [],
    U \= L,
    graphV(U,L,V).

% limpia el resultado de allPosiblesGraphs
prepareGraphs(L,R):-
    findall(All,allPosiblesGraphs(L,All),Clear),
    split(Clear,R,_),
    !.

% descarta aristas
prepareEdges([],_,[]).
prepareEdges([H|T],[U|[V|_]],[H|Res]):-
    member(EU,U),
    member(EV,V),
    equal(H,[EU,EV]),
    prepareEdges(T,[U|V],Res).
prepareEdges([_|T],G,Res):-
    prepareEdges(T,G,Res).

% linkea los grafos con las aristas
intermediate(LN,LE,G,B):-
    prepareGraphs(LN,Res),
    member(G,Res),
    findall(ERes,prepareEdges(LE,G,ERes),BRes),
    delete(BRes,[],B).

% Entradas
% N = lista con los nodos, ie [a,b,c]
% A = lista de listas con las aristas, ie [[a,b],[b,c],[a,c]]

% "Salidas"
% U = subconjunto de N, ie [a,b]
% V = subconjunto de N, ie [c]
% B = aristas, ie [[c,b],[a,c]]
mgb(N,A,U,V,B):-
    intermediate(N,A,[U|[V|_]],Bres),
    flat(Bres,B).
