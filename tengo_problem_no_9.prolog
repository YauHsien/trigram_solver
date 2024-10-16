:- encoding(utf8).

卦(X) :- member(X, ['兌','離','震','巽','坎','艮']).

上反(X) :- member(X, ['兌','離','坎','艮']).
下反(X) :- member(X, ['離','震','巽','坎']).

上同(X) :- member(X, ['乾','震','巽','坤']).
下同(X) :- member(X, ['乾','兌','艮','坤']).

補('乾', '坤').
補(X, Y) :- member(X, ['兌','離','巽']), member(Y, ['震','坎','艮']), \+ 三連(X, Y).
補(X, Y) :- member(Y, ['兌','離','巽']), member(X, ['震','坎','艮']), \+ 三連(X, Y).

三連('兌', X) :- member(X, ['離','巽','艮']).
三連('離', X) :- member(X, ['巽']).
三連('震', X) :- member(X, ['巽']).
三連('巽', X) :- member(X, ['震']).
三連('坎', X) :- member(X, ['震']).
三連('艮', X) :- member(X, ['兌','震','坎']).

陰一(X) :- member(X, ['兌','震','坎','坤']).
陰二(X) :- member(X, ['離','震','艮','坤']).
陰三(X) :- member(X, ['巽','坎','艮','坤']).

陽一(X) :- member(X, ['乾','離','巽','艮']).
陽二(X) :- member(X, ['乾','兌','巽','坎']).
陽三(X) :- member(X, ['乾','兌','離','震']).

board(Board) :-
    Board = [
        A1, A2,
        B1, B2,
        C1, C2,
        D1, D2,
        E1, E2,
        F1, F2
    ],
    補(A1, A2), 下反(A1), 陰二(A2),
    補(B1, B2), 上反(B1), 陰一(B2),
    補(C1, C2), 上反(C1), 陰一(C2),
    補(D1, D2), 陽三(D1), 下同(D2),
    補(E1, E2), 陽三(E1), 下同(E2),
    補(F1, F2), 陽二(F1), 上同(F2),
    foreach(( member(L,[ [A1,B1,C1], [B1,C1,D1], [C1,D1,E1], [D1,E1,F1],
                         [A2,B2,C2], [B2,C2,D2], [C2,D2,E2], [D2,E2,F2]
                       ]),
              findall(X, (member(E,L),錢(E,X)), L0),
              sum_list(L0, N0)
            ),
            非三(N0)
           ),
    findall(X, (member(E,[A1,B1,C1,D1,E1,F1]),錢(E,X)), L1),
    sum_list(L1, 333),
    findall(X, (member(E,[A2,B2,C2,D2,E2,F2]),錢(E,X)), L2),
    sum_list(L2, 333).

錢('乾', 111).
錢('兌', 11).
錢('離', 101).
錢('震', 1).
錢('巽', 110).
錢('坎', 10).
錢('艮', 100).
錢('坤', 0).

非三(N) :- N =:= 0.
非三(N) :-
    N > 0,
    ( N rem 10 =\= 0, !,
      (N rem 10) div 3 =\= (N rem 10) / 3
    ; true
    ),
    非三(N div 10).

:- writeln('Solution:'),
   board(Board), writeln(Board).
