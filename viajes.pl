% vuelo(Codigo de vuelo, capacidad en toneladas, [lista de destinos]).
% escala(ciudad, tiempo de espera)
% tramo(tiempo en vuelo)

vuelo(arg845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).

vuelo(mh101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).

vuelo(dlh470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).

vuelo(aal1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1),
escala(paris,0)]).

vuelo(ble849, 175, [escala(paris,0), tramo(2), escala(berlin,1), tramo(3),
escala(kiev,2), tramo(2), escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).

vuelo(npo556, 150, [escala(kiev,0), tramo(1), escala(moscu,3), tramo(5),
escala(nuevaDelhi,6), tramo(2), escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).

vuelo(dsm3450, 75, [escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), escala(washington,4), tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).

/*
tiempoTotalVuelo/2 : 
Relaciona un vuelo con el tiempo que lleva en total, 
contando las esperas en las escalas 
(y eventualmente en el origen y/o destino) 
más el tiempo de vuelo.
*/

tiempoTotalVuelo(Vuelo,TiempoTotal):-
vuelo(Vuelo,_,ListaDeDestinos),
findall(X,esTiempoDeVuelo(X,ListaDeDestinos),ListaDeTiempos),
sum_list(ListaDeTiempos,TiempoIda),
TiempoTotal is 2*TiempoIda.

esTiempoDeVuelo(X,ListaDeDestinos):-
member(escala(_,X),ListaDeDestinos).

esTiempoDeVuelo(X,ListaDeDestinos):-
member(tramo(X),ListaDeDestinos).

/*
escalaAburrida/2 : Relaciona un vuelo con cada una de sus 
escalas aburridas; una escala es aburrida si hay que esperar 
mas de 3 horas.
*/


escalaAburrida(Vuelo,escala(Ciudad,TiempoDeEspera)):-
vuelo(Vuelo,_,ListaDeDestinos),
member(escala(Ciudad,TiempoDeEspera),ListaDeDestinos),
TiempoDeEspera > 3.

/*
ciudadesAburridas/2 : Relaciona un vuelo con la lista 
de ciudades de sus escalas aburridas.
*/

ciudadesAburridas(Vuelo,EscalasAburridas):-
vuelo(Vuelo,_,ListaDeDestinos),
findall(Ciudad,escalaAburrida(Vuelo,escala(Ciudad,TiempoDeEspera)), EscalasAburridas).
    
/*
vueloLargo/1: Si un vuelo pasa 10 o más horas en el aire, 
entonces es un vuelo largo. 
OJO que dice "en el aire", 
en este punto no hay que contar las esperas en tierra. 
*/

vueloLargo(Vuelo):-
    vuelo(Vuelo,_,ListaDeDestinos),
    findall(HoraDeVuelo,member(tramo(HoraDeVuelo),ListaDeDestinos) ,ListaDeHorasEnVuelo),
    sum_list(ListaDeHorasEnVuelo,TotalDeHorasEnVuelo),
    TotalDeHorasEnVuelo > 10.

/*
conectados/2: Relaciona 2 vuelos 
si tienen al menos una ciudad en común.
*/

conectados(Vuelo1,Vuelo2):-
vuelo(Vuelo1,_,Destinos1),
vuelo(Vuelo2,_,Destinos2),
member(escala(Ciudad,_),Destinos1),
member(escala(Ciudad,_),Destinos2),
Vuelo1 \= Vuelo2.

bandaDeTres(VueloA,VueloB,VueloC):-
conectados(VueloA,VueloB),
conectados(VueloB,VueloC),
VueloA \= VueloC .

/*
distanciaEnEscalas/3: Relaciona dos ciudades que son escalas del 
mismo vuelo y la cantidad de escalas entre las mismas; 
si no hay escalas intermedias la distancia es 1. 
P.ej. París y Berlín están a distancia 1 (por el vuelo BLE849), 
Berlín y Seúl están a distancia 3 (por el mismo vuelo). 
No importa de qué vuelo, lo que tiene que pasar es que haya 
algún vuelo que tenga como escalas a ambas ciudades. 
Consejo: usar nth1.
*/

distanciaEnEscalas(Ciudad1,Ciudad2,Distancia):-
vuelo(_,_,ListaDeDestinos),
member(escala(Ciudad1,_),ListaDeDestinos),
member(escala(Ciudad2,_),ListaDeDestinos),
findall(escala(UnaCiudad,UnasHoras), member(escala(UnaCiudad,UnasHoras),ListaDeDestinos),ListaDeEscalas),
nth1(Posicion1,ListaDeEscalas,escala(Ciudad1,_)),
nth1(Posicion2,ListaDeEscalas,escala(Ciudad2,_)),
(Posicion1 - Posicion2) \= 0 ,
Distancia is abs(Posicion1-Posicion2).

vueloLento(Vuelo):-
    vuelo(Vuelo,_,ListaDeDestinos),
    not(vueloLargo(Vuelo)),
    forall(member(escala(Ciudad,TiempoDeEspera),ListaDeDestinos),escalaAburrida(Vuelo,escala(Ciudad,TiempoDeEspera))).

noVueloLento(Vuelo):-
    vuelo(Vuelo,_,_),
    not(vueloLento(Vuelo)).

