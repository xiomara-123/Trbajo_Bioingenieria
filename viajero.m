% ***************************************************************
% POBLEMA DEL VIAJERO
% ***************************************************************
clc, close all, clear variables
global Distancia; 
Distancia = [0  9  7  8;
             9  0 10 15;
             7 10  0  4;
             8 15  4  0];

% Configuración Algoritmo Genético
options = optimoptions(@ga);
 
% Población Genética
options = optimoptions(options, 'PopulationSize',100);              % Tamaño de la población
options = optimoptions(options, 'PopulationType', 'doubleVector');     % Tipo de datos, es de tipo binario 
options = optimoptions(options, 'PopInitRange',[1 1 1 1 1; 1 4 4 4 1]); % Rangos minimos y maximos de cada uno de las 5 variables
options = optimoptions(options, 'CreationFcn',@gacreationuniform);  % Poblacion inicial aleatoria,distribucion uniforme
 
% Criterios de parada
options = optimoptions(options, 'Generations', 100);    % Maximo de Generaciones
options = optimoptions(options, 'FitnessLimit',0.001); % Limite de la funcion fitness, si es mas pequeño se detiene la ejecucion
 
% Operadores Genéticos
% Operador de selección = Torneo deterministico + aleatorio
options = optimoptions(options, 'SelectionFcn', @selectionroulette);

% Algoritmo de cruce = 1 Punto. Probabilidad de Cruce
options = optimoptions(options, 'CrossoverFcn', @crossoversinglepoint); 
options = optimoptions(options, 'CrossoverFraction', 0.8);
 
% Algoritmo de mutación = Puntual. Probabilidad de Mutacion
options  = optimoptions(options, 'MutationFcn',{@mutationuniform, 0.1});
 
% Configuracion Salida
options = optimoptions(options, 'Display', 'final');
options = optimoptions(options, 'PlotInterval', 10); 
options = optimoptions(options,'PlotFcns',@gaplotbestf);% valores intermedios 

%% Ejecución algoritmo

nvar = 5;%Estas 5 variables es el tamaño de la poblacion
[x, fval, reason, output, population, scores] = ga(@fitness_viajero, nvar, options);

%% Resultados
disp('Mejor individuo: ');
x= round(x);
disp(x); %La mejor solucion para el ejercicio es realizar el recorrido [1 2 3 4 1], cuya suma de distancias es el recorrido menor con 31km
disp('Suma menor de las distancias:')
disp(fval)
