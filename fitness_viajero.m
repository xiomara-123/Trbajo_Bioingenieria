function [ FitnessValue ] = fitness_viajero(xpop) 
%En esta funcion mientras el fitness sea menor es mejor, ya que se busca la
%menor distancia para terminar el recorrido
global Distancia
%xpop= [3,2,1,4,3]; es un vector que llega con las posiciones optenidas
xpop = round(xpop);
%Secuencia de las posisiones para la suma de las distancias de cada una
distancia = Distancia(xpop(1),xpop(2))+Distancia(xpop(2),xpop(3))+Distancia(xpop(3),xpop(4))+Distancia(xpop(4),xpop(1));

y = length(unique(xpop(2:4))) ; %Para la no repeticion de los tres numeros del centro 
if xpop(1) == xpop(5)  && y==3 && xpop(2)~= 1 && xpop(3)~= 1 && xpop(4)~= 1 %Cumpliendo que la primera y ultima posicion sean iguales, y ninguno de los del centro iguales a 1
   %Si se cumple esa posicion se lleva a el main la suma de las distancias
   %por las posiciones en que se encuentran
    s = distancia;

else
    s = 500;% Si es que no se cumple la condicion, se da al fitness un valor muy grande, por lo que el individuo no esta bien adaptado
end 

FitnessValue = s;