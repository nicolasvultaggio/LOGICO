/* 
En una competencia de saltos, cada competidor puede hacer hasta 5 saltos; a cada salto se le asigna un puntaje de 0 a 10. Se define el predicado puntajes que relaciona cada competidor con los puntajes de sus saltos, p.ej.

puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

Se pide armar un programa Prolog que a partir de esta información permita consultar:
Qué puntaje obtuvo un competidor en un salto, p.ej. qué puntaje obtuvo Hernán en el salto 4 (respuesta: 6).
Si un competidor está descalificado o no. Un competidor está descalificado si hizo más de 5 saltos. En el ejemplo, Julio está descalificado.
Si un competidor clasifica a la final. Un competidor clasifica a la final si la suma de sus puntajes es mayor o igual a 28, o si tiene dos saltos de 8 o más puntos.

Ayuda: investigar predicado nth1/3 y nth0/3 en el prolog.

*/

puntajes(hernan,[3,5,8,6,9]). %clasifica
puntajes(julio,[9,7,3,9,10,2]). %no clasifica
puntajes(ruben,[3,5,3,8,3]). %no clasifica
puntajes(roque,[7,10,10]). %clasifica a la final
puntajes(victor,[10,10]).

puntajeEnSalto(Num,Competidor,Respuesta):-
puntajes(Competidor,SusNotas),
length(SusNotas,Longitud),
Num=<Longitud,
nth1(Num,SusNotas,Respuesta).

descalificado(Participante):-
puntajes(Participante,SusNotas),
length(SusNotas,Longitud),
Longitud>5.

clasificaALaFinal(Participante):-
    puntajes(Participante,SusNotas),
    not(descalificado(Participante)),
    sum_list(SusNotas,SumaDePuntajes),
    SumaDePuntajes>=28.

clasificaALaFinal(Participante):-
    puntajes(Participante,SusNotas),
    findall(X,notaMasDeOcho(SusNotas,X),PosicionesMasDeOcho),
    length(PosicionesMasDeOcho,Longitud),
    Longitud>1.

notaMasDeOcho(Notas,Posicion):-
nth1(Posicion,Notas,Nota),
Nota>=8.

clasificaALaFinal2(Participante):-
    puntajes(Participante,Saltos),
    findall(X,notaMasDeOcho2(Saltos,X),Lista),
    length(Lista,Longitud),
    Longitud>1.

notaMasDeOcho2(Saltos,UnSalto):-
    member(UnSalto,Saltos),
    UnSalto>=8.


