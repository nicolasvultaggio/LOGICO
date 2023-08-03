viveEnMansionDreadBury(tiaAgatha).
viveEnMansionDreadBury(mayordomo).
viveEnMansionDreadBury(charles).

odia(charles,Odiado):-
    viveEnMansionDreadBury(Odiado),
    not(odia(tiaAgatha,Odiado)).

odia(tiaAgatha,Odiado):-
    viveEnMansionDreadBury(Odiado),
    Odiado\=mayordomo. 

odia(mayordomo,Odiado):- odia(tiaAgatha,Odiado).

esMasRicoQue(agatha,ElRico):-
    viveEnMansionDreadBury(ElRico),
    not(odia(mayordomo,ElRico)).

mata(Alguien,Victima) :-
    viveEnMansionDreadBury(Alguien),
    odia(Alguien,Victima),
    not(esMasRicoQue(Victima,Alguien)).
