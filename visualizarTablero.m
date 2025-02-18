function visualizarTablero(individuo)
    % Crear una matriz para representar el tablero de ajedrez
    tablero = zeros(8, 8);

    % Colocar las reinas en el tablero
    for i = 1:8
        tablero(i, individuo(i)) = 1;
    end

    % Crear una imagen en blanco para el tablero (RGB)
    imagen = ones(8 * 50, 8 * 50, 3);

    % Dibujar el tablero en la imagen
    for fila = 1:8
        for columna = 1:8
            if mod(fila + columna, 2) == 0
                color = 1; % Blanco
            else
                color = 0; % Negro
            end

            % Definir las coordenadas del cuadro
            fila_inicio = (fila - 1) * 50 + 1;
            fila_fin = fila * 50;
            columna_inicio = (columna - 1) * 50 + 1;
            columna_fin = columna * 50;

            % Aplicar el color a los tres canales (RGB)
            imagen(fila_inicio:fila_fin, columna_inicio:columna_fin, :) = color;
        end
    end

    % Cargar imágenes de las reinas
    reina_blanca = imread('reina_blanca.png');
    reina_negra = imread('reina_negra.png');

    % Convertir a escala de grises si es necesario
    if size(reina_blanca, 3) == 3
        reina_blanca =
