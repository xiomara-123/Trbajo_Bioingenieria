clc; clear; close all;

% Número de reinas
n = 8;

% Función de evaluación (fitness)
fitnessFcn = @(x) fitness_8reinas(x);

% Definir opciones del Algoritmo Genético
opts = optimoptions('ga', 'MaxGenerations', 100, ...
                    'PopulationSize', 50, ...
                    'CrossoverFraction', 0.8, ...
                    'MutationFcn', @mutation_8reinas, ...
                    'SelectionFcn', @selectiontournament, ...
                    'InitialPopulationMatrix', initial_population(n, 50), ...
                    'Display', 'iter');

% Variables de decisión (las posiciones de las reinas)
lb = ones(1, n);  % Límite inferior: cada reina en la fila 1
ub = n * ones(1, n);  % Límite superior: cada reina en la fila 8
IntCon = 1:n; % Variables enteras

% Ejecutar el Algoritmo Genético
[mejor_solucion, mejor_valor] = ga(fitnessFcn, n, [], [], [], [], lb, ub, [], IntCon, opts);

% Mostrar la mejor solución encontrada
disp('Mejor solución encontrada:');
disp(mejor_solucion);
disp(['Número de ataques: ', num2str(mejor_valor)]);

% Visualizar la solución
visualizarTablero(mejor_solucion);

% Función de evaluación (fitness)
function score = fitness_8reinas(x)
    x = round(x); % Asegurar valores enteros
    n = length(x);
    score = 0;
    for i = 1:n-1
        for j = i+1:n
            if abs(x(i) - x(j)) == abs(i - j)
                score = score + 1; % Contar ataques en diagonal
            end
        end
    end
end

% Función de mutación: intercambia dos filas aleatorias
function mutationChildren = mutation_8reinas(parents, options, nvars, fitnessfcn, state, score, pop)
    mutationChildren = parents;
    for i = 1:size(parents, 1)
        idx = randperm(nvars, 2); % Selecciona dos índices aleatorios
        mutationChildren(i, :) = parents(i, :);
        mutationChildren(i, idx) = mutationChildren(i, fliplr(idx)); % Intercambia los valores
    end
end

% Función para generar población inicial aleatoria
function pop = initial_population(n, pop_size)
    pop = zeros(pop_size, n);
    for i = 1:pop_size
        pop(i, :) = randperm(n);
    end
end

% Función de visualización del tablero (requiere implementación en MATLAB)
function visualizarTablero(sol)
    n = length(sol);
    tablero = zeros(n);
    for i = 1:n
        tablero(sol(i), i) = 1;
    end
    imagesc(tablero);
    colormap([1 1 1; 0 0 0]); % Blanco y negro
    axis equal;
    axis off;
    title('Solución al problema de las 8 Reinas');
end
