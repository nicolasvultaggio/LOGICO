tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).

habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).

capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

vida(arbol).
vida(perro).
vida(flor).

destinoPosible(Participante,Ciudad):-
    nivelActual(Participante,Nivel),
    tarea(Nivel,buscar(_,Ciudad)).

idiomaUtil(Participante,Idioma):-
    destinoPosible(Participante,Ciudad),
    idioma(Ciudad,Idioma).

excelenteCompaniero(P1,P2):-
    habla(P1,_),
    habla(P2,_),
    forall(idiomaUtil(P1,Idioma),habla(P2,Idioma)).

interesante(Nivel):-
    tarea(Nivel,buscar(_,_)),
    forall(tarea(Nivel,buscar(Objeto,_)),vida(Objeto)).

interesante(Nivel):-
    tarea(Nivel,buscar(_,Destino)),
    idioma(Destino,italiano).

interesante(Nivel):-
nivelActual(_,Nivel),
findall(Capital,(nivelActual(Participante,Nivel),capital(Participante,Capital)),ListaDeCapitales),
sum_list(ListaDeCapitales,TotalCapitalesDeNivel),
TotalCapitalesDeNivel > 1000.

complicado(Participante):-
destinoPosible(Participante,_),
forall((destinoPosible(Participante,Ciudad),idioma(Ciudad,Idioma)),not(habla(Participante,Idioma))).

complicado(Participante):-
nivelActual(Participante,_),
not(nivelActual(Participante,basico)),
capital(Participante,Capital),
Capital<1500.

complicado(Participante):-
nivelActual(basico,Participante),
capital(Participante,Capital),
Capital<500.

homogeneo(Nivel):-
tarea(Nivel,_),
findall(Elemento,tarea(Nivel,buscar(Elemento,_)),ListaDeElementos),
esListaHomogenea(ListaDeElementos).

esListaHomogenea(Lista):-
list_to_set(Lista,ListaSinRepeticion),
length(ListaSinRepeticion,1).

poliglota(Persona):-
    habla(Persona,_),
    findall(Idioma,habla(Persona,Idioma),ListaDeIdiomas),
    length(ListaDeIdiomas,CantidadDeIdiomasQueHabla),
    CantidadDeIdiomasQueHabla >= 3.
    
