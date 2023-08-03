linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]). % a,c
combinacion([once, miserere]).% a,h
combinacion([pellegrini, diagNorte, nueveJulio]). % b,c,d
combinacion([independenciaC, independenciaE]). % c,e
combinacion([jujuy, humberto1ro]). % e,h
combinacion([santaFe, pueyrredonD]). % d,h
combinacion([corrientes, pueyrredonB]). % b,h 
%No hay dos estaciones con el mismo nombre.

%
estaEn(Estacion, Linea) :-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

distancia(Estacion1,Estacion2,Distancia):-
    estaEn(Estacion1,Linea),
    estaEn(Estacion2,Linea),
    posicion(Estacion1,X),
    posicion(Estacion2,Y),
    Distancia is abs(X-Y).


mismaAltura(EstacionA,EstacionB):-
    estaEn(EstacionA,LineaA),
    estaEn(EstacionB,LineaB),
    LineaA \= LineaB,
    posicion(EstacionA,X),
    posicion(EstacionB,X).

posicion(Estacion,Posicion):-
    estaEn(Estacion,Linea),
    linea(Linea,Estaciones),
    nth1(Posicion,Estaciones,Estacion).

viajeFacil(EstacionA,EstacionB):-
    estaEn(EstacionA,X),
    estaEn(EstacionB,X).

viajeFacil(EstacionA,EstacionB):-
    estaEn(EstacionA,LineaDeA),
    estaEn(EstacionB,LineaDeB),
    estaEn(X,LineaDeA),
    estaEn(Y,LineaDeB),
    combinacion(Combinacion),
    member(X,Combinacion),
    member(Y,Combinacion).

