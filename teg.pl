/* distintos paises */
paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, gobi).
paisContinente(asia, india).
paisContinente(asia, iran).

/*países importantes*/
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/*países limítrofes*/
limitrofes([argentina,brasil]).
limitrofes([bolivia,brasil]).
limitrofes([bolivia,argentina]).
limitrofes([argentina,chile]).
limitrofes([espania,francia]).
limitrofes([alemania,francia]).
limitrofes([nepal,india]).
limitrofes([china,india]).
limitrofes([nepal,china]).
limitrofes([afganistan,china]).
limitrofes([iran,afganistan]).

/*distribución en el tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, verde, 4).
ocupa(chile, negro, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(espania, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2). 
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).



/*continentes*/
continente(americaDelSur).
continente(europa).
continente(asia).

/*objetivos*/
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentina, bolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

/*
Relaciona un jugador y un continente si el jugador 
ocupa al menos un país en el continente.
*/
estaEnContinente(Jugador,Continente):-
ocupa(Pais,Jugador,_),
paisContinente(Continente,Pais).

/*
Relaciona a un jugador con la cantidad de países que ocupa.
*/

cantidadPaises(Jugador,CantidadDePaisesOcupados):-
ocupa(_,Jugador,_),
findall(Pais,ocupa(Pais,Jugador,_),ListaDePaisesOcupados),
length(ListaDePaisesOcupados,CantidadDePaisesOcupados).

/*
Relaciona un jugador y un continente 
si el jugador ocupa totalmente al continente.
*/

ocupaContinente(Jugador,Continente):-
paisContinente(Continente,_),
ocupa(_,Jugador,_),
forall(paisContinente(Continente,Pais),ocupa(Pais,Jugador,_)).

%Relaciona a un jugador y un continente si al 
%jugador le falta ocupar más de 2 países de 
%dicho continente.

leFaltaMucho(Jugador,Continente):-
paisContinente(Continente,_),
ocupa(_,Jugador,_),
findall(Pais,noOcupaEnContinente(Jugador,Pais,Continente),PaisesQueNoOcupaDeEseContinente),
length(PaisesQueNoOcupaDeEseContinente,Cantidad),
Cantidad>2.

noOcupaEnContinente(Jugador,Pais,Continente):-
paisContinente(Continente,Pais),
not(ocupa(Pais,Jugador,_)).

/*
Relaciona 2 países si son limítrofes.
*/
sonLimitrofes(Pais1,Pais2):-
limitrofes(Limitrofes),
member(Pais1,Limitrofes),
member(Pais2,Limitrofes),
Pais1 \= Pais2.


esGroso(Jugador):-
ocupa(_,Jugador,_),
paisImportante(_),
forall(paisImportante(Pais),ocupa(Pais,Jugador,_)).

esGroso(Jugador):-
cantidadPaises(Jugador,X),
X>10.


esGroso(Jugador):-
ocupa(_,Jugador,_),
findall(Ejercito,ocupa(_,Jugador,Ejercito),Ejercitos),
length(Ejercitos,X),
X>50.

/*
un país está en el horno si todos sus 
países limítrofes están ocupados por el mismo 
jugador que no es el mismo que ocupa ese país.
*/

estaEnElHorno2(Pais):-
ocupa(Pais,UnJugador,_),
sonLimitrofes(Pais,PaisLimitrofe),
ocupa(PaisLimitrofe,JugadorLimitrofe,_),
forall(sonLimitrofes(Pais,OtroPaisLimitrofe),ocupa(OtroPaisLimitrofe,JugadorLimitrofe,_)),
UnJugador\=JugadorLimitrofe.

esCaotico(Continente):-
    estaEnContinente(_,Continente),
    findall(Jugador,estaEnContinente(Jugador,Continente),ListaDeJugadores),
    list_to_set(ListaDeJugadores,ListaSinRepetirJugadores),
    length(ListaSinRepetirJugadores,CantidadDeJugadoresContinente),
    CantidadDeJugadoresContinente>3.

capoCannoniere(UnJugador):-
ocupa(_,UnJugador,_),
findall(Cantidad,(ocupa(_,Jugador,_),cantidadPaises(Jugador,Cantidad)),Lista),
cantidadPaises(UnJugador,SuCantidad),
max_member(SuCantidad,Lista).

ganadooor(Jugador):-
    