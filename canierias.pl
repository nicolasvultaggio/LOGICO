%codo(color)
%canio(color,longitud)  metros
%canilla(tipo,color,anchoDeBoca) centimetros 

canieria([codo(rojo),canio(azul,3),canilla(triangular,roja,4)]).

precioCanieria(Canieria,PrecioCanieria):-
    canieria(Canieria),
    findall(PrecioPieza,(member(Pieza,Canieria),precioPieza(Pieza,PrecioPieza)),ListaDePreciosDePiezas),
    sum_list(ListaDePreciosDePiezas,PrecioCanieria).

precioPieza(codo(_),50).
precioPieza(canio(_,Longitud),PrecioPieza):-PrecioPieza is 3*Longitud.
precioPieza(canilla(triangular,_,_),20).
precioPieza(canilla(_,_,Ancho),PrecioPieza):-
    precioPorCentimetro(Ancho,PrecioUnitarioCM),
    PrecioPieza is Ancho*PrecioUnitarioCM.

precioPorCentimetro(AnchoCM,15):-AnchoCM>5.
precioPorCentimetro(AnchoCM,12):-AnchoCM=<5.

pieza(codo(_)).
pieza(canio(_,_)).
pieza(canilla(_,_,_)).

colorEnchufable(azul,rojo).
colorEnchufable(rojo,negro).
colorEnchufable(Color,Color).

primerPieza([Head|_],Head).
ultimaPieza([Ultima],Ultima).
ultimaPieza([_|Resto],Ultima):-ultimaPieza(Resto,Ultima).

ultimoColor(codo(Color),Color).
ultimoColor(canio(Color,_),Color).
ultimoColor(canilla(_,Color,_),Color).

ultimoColor(Canieria,Color):-
    canieria(Canieria),
    ultimaPieza(Canieria,UltimaPieza),
    ultimoColor(UltimaPieza,Color).

primerColor(codo(Color),Color).
primerColor(canio(Color,_),Color).
primerColor(canilla(_,Color,_),Color).

primerColor(Canieria,Color):-
canieria(Canieria),
primerPieza(Canieria,PrimerPieza),
primerColor(PrimerPieza,Color).


puedoEnchufar(P1,P2):-
    ultimoColor(P1,Color1),
    primerColor(P2,Color2),
    colorEnchufable(Color1,Color2).

canieriaBienArmada(Canieria):-
    canieria(Canieria),
    forall((member(Elemento,Canieria),not(ultimaPieza(Canieria,Elemento))),enchufableConElSiguiente(Canieria,Elemento)).

enchufableConElSiguiente(Canieria,Elemento):-
    canieria(Canieria),
    member(Elemento,Canieria),
    nth1(X,Canieria,Elemento),
    nth1((X+1),Canieria,ElementoSiguiente),
    puedoEnchufar(Elemento,ElementoSiguiente).

