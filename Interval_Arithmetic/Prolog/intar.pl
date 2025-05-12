% Beccacece Aron Davis 856480

    % Rappresentazione delle costanti per l infinito
    pos_infinity(pos_infinity).
    neg_infinity(neg_infinity).

    % Definizione dell intervallo vuoto
    empty_interval([]).
    empty_interval(X) :- X = empty_interval([]).


    % plus_e/1
    plus_e(0).

    % plus_e/2
    plus_e(X, R) :-
    (X == pos_infinity ; X == neg_infinity ; number(X)) -> R = X; fail.

    % plus_e/3: Somma tra due numeri reali estesi
    plus_e(X, Y, Result) :-
    (X == pos_infinity, (Y == neg_infinity -> fail ; Result = pos_infinity)) ;
(X == neg_infinity, (Y == pos_infinity -> fail ; Result = neg_infinity)) ;
(Y == pos_infinity, (X == neg_infinity -> fail ; Result = pos_infinity)) ;
(Y == neg_infinity, (X == pos_infinity -> fail ; Result = neg_infinity)) ;
(number(X), number(Y), Result is X + Y).

    % minus_e/2
    minus_e(X, Result) :-
    (X == pos_infinity, Result = neg_infinity);
(X == neg_infinity, Result = pos_infinity);
(number(X), Result is -X).

    % minus_e/3: Differenza tra due numeri reali estesi
    minus_e(X, Y, Result) :-
    (X == pos_infinity, (Y == pos_infinity -> fail ; Y == neg_infinity -> Result = pos_infinity)) ;
(X == neg_infinity, (Y == neg_infinity -> fail ; Y == pos_infinity -> Result = neg_infinity)) ;
(number(X), Y == pos_infinity, Result = neg_infinity) ;
(number(X), Y == neg_infinity, Result = pos_infinity) ;
(X == pos_infinity, number(Y), Result = pos_infinity) ;
(X == neg_infinity, number(Y), Result = neg_infinity) ;
(number(X), number(Y), Result is X - Y).

    % times_e/1
    times_e(1).

    % times_e/2
    times_e(X, Result) :-
    (X == pos_infinity ; X == neg_infinity ; number(X)) -> Result = X; fail.

    % times_e/3: Prodotto tra due numeri reali estesi
    times_e(X, Y, Result) :-
    (X == pos_infinity, (Y == 0 -> fail ;
                         Y == pos_infinity -> Result = pos_infinity ;
                         Y == neg_infinity -> Result = neg_infinity ;
                         number(Y), Y > 0 -> Result = pos_infinity ;
                         number(Y), Y < 0 -> Result = neg_infinity)) ;
(X == neg_infinity, (Y == 0 -> fail ;
		     Y == pos_infinity -> Result = neg_infinity ;
		     Y == neg_infinity -> Result = pos_infinity ;
		     number(Y), Y > 0 -> Result = neg_infinity ;
		     number(Y), Y < 0 -> Result = pos_infinity)) ;
(Y == pos_infinity, (X == 0 -> fail ;
		     number(X), X > 0 -> Result = pos_infinity ;
		     number(X), X < 0 -> Result = neg_infinity)) ;
(Y == neg_infinity, (X == 0 -> fail ;
		     number(X), X > 0 -> Result = neg_infinity ;
		     number(X), X < 0 -> Result = pos_infinity)) ;
(number(X), number(Y), Result is X * Y).

    % div_e/2
    div_e(X, Result) :-
    (X == 0 -> fail ;
     (X == pos_infinity -> Result = 0 ;
      X == neg_infinity -> Result = 0 ;
      number(X) -> Result is 1 / X)).

    % div_e/3: Divisione tra due numeri reali estesi
    div_e(X, Y, Result) :-
    (Y == 0 -> fail ;
     (X == pos_infinity, (Y == pos_infinity; Y == neg_infinity) -> fail ;
      X == neg_infinity, (Y == pos_infinity; Y == neg_infinity) -> fail ;
      X == pos_infinity, (Y > 0 -> Result = pos_infinity ; Result = neg_infinity);
      X == neg_infinity, (Y > 0 -> Result = neg_infinity ; Result = pos_infinity);
      number(X), (Y == pos_infinity; Y == neg_infinity) -> Result = 0;
      number(X), number(Y) -> Result is X / Y)).


    % interval/1
    interval(X):- empty_interval(X).

    % interval/2: Definisce l intervallo singleton
    interval(X, I) :-
    (X == pos_infinity ; X == neg_infinity ; (number(X))) ->
    interval(X, X, I); fail.

    % interval/3: Definisce l intervallo
    interval(L, H, I) :-
    L == neg_infinity, (H == pos_infinity; H == neg_infinity; number(H)) -> I = [L, H];
L == pos_infinity, (H == neg_infinity; number(H)) -> empty_interval(I); H == pos_infinity -> I = [L, H];
number(L), (H == pos_infinity -> I = [L, H]; H == neg_infinity -> empty_interval(I));
number(L), number(H) ->
    (L =< H -> I = [L, H]; empty_interval(I));
fail.

    % is_interval/1: Verifica se un intervallo è valido
    is_interval(X) :-
    X = [L, H],
    (L == neg_infinity ; L == pos_infinity ; number(L) ),
    (H == pos_infinity ; H == neg_infinity ; number(H) ).

    % is_interval/1: L intervallo vuoto è valido
    is_interval([]).

    % is_interval/1: Verifica validità intervalli disgiunti
    is_interval([I1 | Rest]) :-
    is_interval(I1),
    is_interval(Rest).

    % whole_interval/1: Restituisce l intervallo pieno
    whole_interval(I) :- I = [neg_infinity, pos_infinity].

    % is_singleton/1: Vero se l intervallo è singleton
    is_singleton(X) :-
    X = [L, L],
    (number(L) ; L == neg_infinity ; L == pos_infinity).

    % iinf/2: Vero se L è l estremo inferiore dell intervallo
    iinf(X, L) :-
    not(empty_interval(X)),
    X = [L, _],
    (number(L); L == neg_infinity ; L == pos_infinity).

    % iinf/2: Vero se L è l estremo inferiore degli intervalli disgiunti
    iinf([H | Rest], L) :-
    is_interval([H | Rest]),
    findall(L, iinf(H, L), Ls),
    iinf_list(Rest, Ls, L).

    % iinf_list/3: Caso base
    iinf_list([], Ls, MinL) :-
    min_list(Ls, MinL).

    % iinf_list/3: Funzione ausiliaria per iinf
    iinf_list([H | Rest], Ls, MinL) :-
    iinf(H, L),
    iinf_list(Rest, [L | Ls], MinL).

    % isup/2: Vero se H è l estremo superiore di un intervallo
    isup(X, H) :-
    not(empty_interval(X)),
    X = [_, H],
    (number(H); H == neg_infinity ; H == pos_infinity).

    % isup/2: Vero se H è l estremo superiore degli intervalli disgiunti
    isup([H | Rest], MaxH) :-
    is_list([H | Rest]),
    findall(S, isup(H, S), Hs),
    isup_list(Rest, Hs, MaxH).

    % isup_list/3: Caso base
    isup_list([], Hs, MaxH) :-
    max_list(Hs, MaxH).

    % isup_list/3: Funzione ausiliaria per isup
    isup_list([H | Rest], Hs, MaxH) :-
    isup(H, S),
    isup_list(Rest, [S | Hs], MaxH).

    % getiinf/2: Estrae l estremo inferiore
    getiinf([X1, _], Result) :-
    number(X1) -> Result is X1;
(X1 == neg_infinity; X1 == pos_infinity) -> Result = X1.

    % getisup/2: Estrae l estremo superiore
    getisup([_, X2], Result) :-
    number(X2) -> Result is X2;
(X2 == neg_infinity; X2 == pos_infinity) -> Result = X2.

    % icontains/1
    icontains(I, _) :-
    (not(is_interval(I)); empty_interval(I)),
    !, fail.

    % icontains/2: Se X è un numero
    icontains(I, X) :-
    is_interval(I),
    I = [L, H],
    number(X),
    (L == neg_infinity ; (number(L), L =< X)),
    (H == pos_infinity ; (number(H), X =< H)).

    % icontains/2: Se X è un intervallo
    icontains(I, X) :-
    is_interval(I),
    is_interval(X),
    I = [L, H],
    X = [X1, X2],
    (L == neg_infinity ; (number(L), number(X1), L =< X1)),
    (H == pos_infinity ; (number(H), number(X2), X2 =< H)).

    % icontains/2: Se L è una lista di intervalli
    icontains(L, X) :-
    is_interval(L),
    member(I, L),
    is_interval(I),
    icontains(I, X).

    % icontains/2: Se L è una lista di intervalli
    icontains(I, L) :-
    is_interval(L),
    is_interval(I),
    forall(member(J, L), (is_interval(J), icontains(I, J))).

    % icontains/2: Se L1 e L2 sono liste di intervalli
    icontains(L1, L2) :-
    is_interval(L1),
    is_interval(L2),
    forall(member(J, L2), (
	       is_interval(J),
	       member(I, L1),
	       is_interval(I),
	       icontains(I, J)
	   )).

    % ioverlap/2: Se L è una lista di intervalli e X un numero reale esteso
    ioverlap(L, X) :-
    (number(X); X == pos_infinity; X == neg_infinity),
    L = [H | _],
    is_interval(H),
    ioverlap(H, X),
    !.

    % ioverlap/2: Se L è una lista di intervalli e I un intervallo
    ioverlap(L1, I) :-
    is_interval(I),
    member(J, L1),
    is_interval(J),
    ioverlap(J, I),
    !.

    % ioverlap/2: Se I è un intervallo e L2 una lista di intervalli
    ioverlap(I, L2) :-
    is_interval(I),
    is_interval(L2),
    member(J, L2),
    is_interval(J),
    ioverlap(I, J),
    !.

    % ioverlap/2: Se L1 e L2 sono liste di intervalli
    ioverlap(L1, L2) :-
    member(I, L1),
    is_interval(I),
    member(J, L2),
    is_interval(J),
    ioverlap(I, J),
    !.

    % ioverlap/2: Se I1 e I2 sono intervalli
    ioverlap(I1, I2) :-
    is_interval(I1),
    is_interval(I2),
    I1 = [L1, H1], I2 = [L2, H2],
    (not(is_interval(L1)), not(is_interval(H1))),
    (not(is_interval(L2)), not(is_interval(H2))),
    ((L1 == neg_infinity ; H2 == pos_infinity ; (number(H2), L1 =< H2)),  % L1 <= H2 o H2 è +inf
     (L2 == neg_infinity ; H1 == pos_infinity ; (number(H1), L2 =< H1))).  % L2 <= H1 o H1 è +inf

    % ioverlap/2: Se I1 è un intervallo e X un numero reale esteso
    ioverlap(I1, X) :-
    is_interval(I1),
    (number(X); X == pos_infinity; X == neg_infinity),
    interval(X, X, IX),
    IX = [X1, X2],
    I1 = [L1, H1],
    (not(is_interval(L1)), not(is_interval(H1))),
    ((L1 == neg_infinity ; X2 == pos_infinity ; (number(X2), L1 =< X2)),  % L1 <= H2 o H2 è +inf
     (X1 == neg_infinity ; H1 == pos_infinity ; (number(H1), X1 =< H1))).  % L2 <= H1 o H1 è +inf

    % iplus/1
    iplus(ZI) :-
    is_interval(ZI),
    not(empty_interval(ZI)).

    % iplus/2
    iplus(X, Result) :-
    iplus(X) -> X = Result;
plus_e(X, I) -> interval(I, I, Result).

    % iplus/3
    iplus(X, Y, Result) :-
    (plus_e(X, X) -> interval(X, IX); IX = X),
    (plus_e(Y, Y) -> interval(Y, IY); IY = Y),
    iplus(IX), iplus(IY),
    IX = [L1, H1],
    IY = [L2, H2],
    plus_e(L1, L2, Lr1),
    plus_e(H1, H2, Hr2),
    interval(Lr1, Hr2, Result).

    % iplus/3: Casi base
    iplus([], _, []).
    iplus(_, [], []).

    % iplus/3: Somma tra intervallo e un intervallo disgiunto
    iplus(Interval, [I2 | Rest], [SingleResult | RestResult]) :-
    iplus(Interval, I2, SingleResult),
    iplus(Interval, Rest, RestResult).

    % iplus/3: Somma tra un intervallo disgiunto e un intervallo
    iplus([I1 | Rest], Interval, [SingleResult | RestResult]) :-
    iplus(I1, Interval, SingleResult),
    iplus(Rest, Interval, RestResult).


    % iplus/3: Somma tra due intervalli disgiunti
    iplus([I1 | Rest1], [I2 | Rest2], [SingleResult | RestResult]) :-
    iplus(I1, I2, SingleResult),
    iplus(Rest1, [I2 | Rest2], RestResult).

    % iminus/2: Con X numero reale esteso
    iminus(X, Result) :-
    not(empty_interval(X)),
    (number(X); X == neg_infinity; X == pos_infinity) ->
    minus_e(X, RX),
    interval(RX, RX, Result).

    % iminus/2: Con I intervallo
    iminus(I, Result) :-
    not(empty_interval(I)),
    is_interval(I),
    I = [X1, X2],
    minus_e(X1, R1),
    minus_e(X2, R2),
    interval(R2, R1, Result).

    % iminus/3: Differenza tra due intervalli X Y
    iminus(X, Y, Result) :-
    (plus_e(X, X) -> interval(X, IX); IX = X),
    (plus_e(Y, Y) -> interval(Y, IY); IY = Y),
    is_interval(IX), not(empty_interval(IX)),
    is_interval(IY), not(empty_interval(IY)),
    IX = [L1, H1],
    IY = [L2, H2],
    minus_e(L1, H2, R1),
    minus_e(H1, L2, R2),
    interval(R1, R2, Result).


    % iminus/3: Caso base
    iminus([], _, []).
    iminus(_, [], []).

    % iminus/3: Differenza fra un intervallo e intervalli disgiunti
    iminus(Interval, [I2 | Rest], [SingleResult | RestResult]) :-
    iminus(Interval, I2, SingleResult),
    iminus(Interval, Rest, RestResult).

    % iminus/3: Differenza fra intervalli disgiunti e un intervallo
    iminus([I1 | Rest], Interval, [SingleResult | RestResult]) :-
    iminus(I1, Interval, SingleResult),
    iminus(Rest, Interval, RestResult).

    % iminus/3: Differenza tra due intervalli disgiunti
    iminus([I1 | Rest1], [I2 | Rest2], [SingleResult | RestResult]) :-
    iminus(I1, I2, SingleResult),
    iminus(Rest1, [I2 | Rest2], RestResult).

    % itimes/1
    itimes(ZI) :-
    is_interval(ZI),
    not(empty_interval(ZI)).

    % itimes/2
    itimes(X, Result) :-
    itimes(X) -> X = Result;
times_e(X, I) -> interval(I, I, Result).

    % itimes/3: Caso base
    itimes([], _, []).
    itimes(_, [], []).

    % itimes/3: Prodotto tra intervallo e intervalli disgiunti
    itimes(Interval, [I2 | Rest], [SingleResult | RestResult]) :-
    itimes(Interval), itimes(I2),
    itimes(Interval, I2, SingleResult),
    itimes(Interval, Rest, RestResult).

    % itimes/3: Prodotto tra intervalli disgiunti e un intervallo
    itimes([I1 | Rest], Interval, [SingleResult | RestResult]) :-
    itimes(I1, Interval, SingleResult),
    itimes(Rest, Interval, RestResult).

    % itimes/3: Prodotto tra due intervalli disgiunti
    itimes([I1 | Rest1], [I2 | Rest2], [SingleResult | RestResult]) :-
    itimes(I1, I2, SingleResult),
    itimes(Rest1, [I2 | Rest2], RestResult).

    % itimes/3: Prodotto tra due intervalli X Y
    itimes(X, Y, Result) :-
    (times_e(X, X) -> interval(X, IX); IX = X),
    (times_e(Y, Y) -> interval(Y, IY); IY = Y),
    itimes(IX), itimes(IY),
    IX = [X1, X2],
    IY = [Y1, Y2],
    times_e(X1, Y1, P1),
    times_e(X1, Y2, P2),
    times_e(X2, Y1, P3),
    times_e(X2, Y2, P4),
    findall(P, (member(P, [P1, P2, P3, P4]), number(P)), Numbers),
    min_list(Numbers, MinLim),
    max_list(Numbers, MaxLim),
    (member(neg_infinity, [P1, P2, P3, P4]) -> FinalMinLim = neg_infinity ; FinalMinLim = MinLim),
    (member(pos_infinity, [P1, P2, P3, P4]) -> FinalMaxLim = pos_infinity ; FinalMaxLim = MaxLim),
    interval(FinalMinLim, FinalMaxLim, Result).

    % idiv/2: X è un numero
    idiv(X, Result) :-
    not(empty_interval(X)),
    (number(X); X == neg_infinity; X == pos_infinity),
    div_e(X, RX),
    interval(RX, RX, Result).

    % idiv/2: X è un intervallo
    idiv(X, Result) :-
    not(empty_interval(X)),
    is_interval(X),
    X = [X1, X2],
    div_e(X1, R1),
    div_e(X2, R2),
    interval(R2, R1, Result).

    %idiv/3: Divisione tra due intervalli X Y
    idiv(X, Y, Result) :-
    ((number(X); X == neg_infinity; X == pos_infinity) -> interval(X, IX); IX = X),
    ((number(Y); Y == neg_infinity; Y == pos_infinity) -> interval(Y, IY); IY = Y),
    not(empty_interval(IX)), not(empty_interval(IY)),
    is_interval(IX), is_interval(IY),
    getiinf(IX, X1), getisup(IX, X2), getiinf(IY, Y1), getisup(IY, Y2),
    (icontains(IY, 0), Y1 \= 0, Y2 \= 0 ->
     (icontains(IX, 0) -> whole_interval(Result);
      (X2 \= pos_infinity, X2 < 0 ->
       (div_e(X1, Y1, L1), div_e(X2, Y1, L2), div_e(X1, Y2, L3), div_e(X2, Y2, L4),
	R1 is max(L3, L4),
	R2 is min(L1, L2));
       (div_e(X1, Y1, L1), div_e(X2, Y1, L2), div_e(X1, Y2, L3), div_e(X2, Y2, L4),
	R1 is max(L1, L2),
	R2 is min(L3, L4))
      ),
      interval(neg_infinity, R1, I1),
      interval(R2, pos_infinity, I2),
      interval(I1, I2, Result)
     ));
((number(X); X == neg_infinity; X == pos_infinity) -> interval(X, IX); IX = X),
    ((number(Y); Y == neg_infinity; Y == pos_infinity) -> interval(Y, IY); IY = Y),
    getiinf(IX, X1), getisup(IX, X2), getiinf(IY, Y1), getisup(IY, Y2),
    (Y1 = 0 ->
     ((X1 == neg_infinity; X1 < 0),
      (X2 == pos_infinity; X2 > 0) -> whole_interval(Result);
      (X1 \= neg_infinity, X1 >= 0 -> div_e(X1, Y2, L1), interval(L1, pos_infinity, Result));
      (X2 \= pos_infinity, X2 =< 0 -> div_e(X2, Y2, L4), interval(neg_infinity, L4, Result)))
    );
((number(X); X == neg_infinity; X == pos_infinity) -> interval(X, IX); IX = X),
    ((number(Y); Y == neg_infinity; Y == pos_infinity) -> interval(Y, IY); IY = Y),
    getiinf(IX, X1), getisup(IX, X2), getiinf(IY, Y1), getisup(IY, Y2),
    (Y2 = 0 ->
     (X1 == neg_infinity; X1 < 0,
      (X2 == pos_infinity; X2 > 0) -> whole_interval(Result);
      (X1 \= neg_infinity, X1 >= 0 -> div_e(X1, Y1, L1), interval(neg_infinity, L1, Result));
      (X2 \= pos_infinity, X2 =< 0 -> div_e(X2, Y1, L2), interval(L2, pos_infinity, Result)))
    );
((number(X); X == neg_infinity; X == pos_infinity) -> interval(X, IX); IX = X),
    ((number(Y); Y == neg_infinity; Y == pos_infinity) -> interval(Y, IY); IY = Y),
    getiinf(IX, X1), getisup(IX, X2), getiinf(IY, Y1), getisup(IY, Y2),
    div_e(X1, Y1, P1),
    div_e(X1, Y2, P2),
    div_e(X2, Y1, P3),
    div_e(X2, Y2, P4),

    findall(P, (member(P, [P1, P2, P3, P4]), number(P)), Numbers),
    min_list(Numbers, MinLim),
    max_list(Numbers, MaxLim),

    (member(neg_infinity, [P1, P2, P3, P4]) -> FinalMinLim = neg_infinity ; FinalMinLim = MinLim),
    (member(pos_infinity, [P1, P2, P3, P4]) -> FinalMaxLim = pos_infinity ; FinalMaxLim = MaxLim),
    interval(FinalMinLim, FinalMaxLim, Result).

    % idiv/3: Caso base
    idiv([], _, []).
    idiv(_, [], []).

    % idiv/3: Divisione tra un intervallo e intervalli disgiunti
    idiv(Interval, [I2 | Rest], [SingleResult | RestResult]) :-
    idiv(Interval, I2, SingleResult),
    idiv(Interval, Rest, RestResult).

    % idiv/3: Divisione tra intervalli disgiunti e un intervallo
    idiv([I1 | Rest], Interval, [SingleResult | RestResult]) :-
    idiv(I1, Interval, SingleResult),
    idiv(Rest, Interval, RestResult).

    % idiv/3: Divisione tra due intervalli disgiunti
    idiv([I1 | Rest1], [I2 | Rest2], [SingleResult | RestResult]) :-
    idiv(I1, I2, SingleResult),
    idiv(Rest1, [I2 | Rest2], RestResult).


    % set_extension/3: Restituisce l intervallo esteso
    set_extension(F, (A, B), (MinValue, MaxValue)) :-
    call(F, A, Fa),
    call(F, B, Fb),
    MinValue is min(Fa, Fb),
    MaxValue is max(Fa, Fb).

    % interval_intersection/3: Vero se gli intervalli X e Y intersecano
    interval_intersection([A1, B1], [A2, B2], (MaxMin, MinMax)) :-
    is_interval([A1, B1]),
    is_interval([A2, B2]),
    ioverlap([A1, B1], [A2, B2]),
    MaxMin is max(A1, A2),
    MinMax is min(B1, B2),
    MaxMin =< MinMax.

    % interval_intersection/3: Caso di errore
    interval_intersection(_, _, _) :-
    write('Errore: uno o entrambi i parametri non sono intervalli validi.'), !, fail.

    % f/2: Restituisce una funzione
    f(X, Y) :- Y is X*X - 2.

    % f_deriv/2: Restituisce la sua derivata
    f_deriv(X, Y) :- Y is 2*X.

    % metodo_newton/5: Formula del metodo di Newton
    metodo_newton(F, FDeriv, A, Interval, Risultato) :-
    set_extension(F, Interval, FInterval),
    set_extension(FDeriv, Interval, FDerivInterval),

    interval_intersection(FInterval, FDerivInterval, interval_intersection),
    (icontains(interval_intersection, 0) ->
     write('Errore: 0 è nell\'intersezione di F(a) e F\'(I), impossibile procedere.'), !, fail
     ;
     call(F, A, Fa),
     call(FDeriv, A, FDerivA),
     Na is A - Fa / FDerivA,
     interval_intersection(Interval, (Na, Na), Risultato)
    ).
