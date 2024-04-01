%% TFG Invariantes de iluminación
%% Jonás Martínez Sanllorente

% Elijo los directorios de origen y destino para las imágenes.
directorio_origen = '../Imagenes\Piezas\Camara-NikonCoolpixL830/';
directorio_destino = '../Imagenes_resultado';
directorio_ground_truth = '../Imagenes_ground_truth\Piezas\Camara-NikonCoolpixL830/';

% Abro un cuadro de diálogo para seleccionar una imagen.
[imagen_seleccionada, ruta] = uigetfile(fullfile(directorio_origen, '*.*'), 'Selecciona una imagen');
% Extraigo el nombre y la extensión de la imagen seleccionada.
[~, nombre_imagen, extension] = fileparts(imagen_seleccionada);

% Leo la imagen desde su ruta completa.
imagen = imread(fullfile(ruta, imagen_seleccionada));

% Preparo la ruta completa hacia la imagen ground truth correspondiente
ruta_img_ground_truth = fullfile(directorio_ground_truth, [nombre_imagen, extension]);

% Leo la imagen ground truth desde su ruta completa.
img_ground_truth = imread(ruta_img_ground_truth);

% Proceso la imagen para obtener una versión de tres canales.
imagen_tres_canales = ImagenTresCanales(imagen);

% Muestro la imagen original y la versión procesada lado a lado.
figure()
subplot(1,2,1); imshow(imagen); title('Imagen original');
subplot(1,2,2); imshow(imagen_tres_canales); title('Imagen tres canales');
waitforbuttonpress;
close();

% Muestro las opciones de algoritmos de procesamiento de imagenes.
disp('Selecciona un algoritmo:');
disp('1. PCA');
disp('2. Retinex singlescale');
disp('3. Retinex multiscale');
disp('4. Exit');

% Inicializo variables para manejar la opción seleccionada.
tipo = '';
opcion_correcta = false;

% Bucle hasta que se seleccione una opción válida.
while not(opcion_correcta)
    opcion = input('Introduce el número de la opción que deseas: ');
    opcion_correcta = true;

    switch opcion
        case 1
            tipo = 'PCA';
            tipo2 = '';
            imagen_resultado = PCA(imagen_tres_canales);
        case 2
            tipo = 'Retinex_s_s';
            [tipo2, sigma] = sigma_retinex(1);
            imagen_resultado = single_scale_retinex_propio(imagen_tres_canales, sigma);
        case 3
            tipo = 'Retinex_m_s';
            [tipo2, sigma] = sigma_retinex(2);
            imagen_resultado = multi_scale_retinex_propio(imagen_tres_canales, sigma);
        otherwise
            disp('Opción no válida');
            opcion_correcta = false; % Para que pregunte otra vez
    end
end

% Muestro valores máximo y mínimo de la imagen escalada (entre 0 y 1).
disp(['Valor máximo: ' num2str(max(imagen_resultado(:)))]);
disp(['Valor mínimo: ' num2str(min(imagen_resultado(:)))]);

% Muestro la imagen original, la imagen resultado.
figure()
subplot(1,2,1); imshow(imagen_tres_canales); title('Imagen original');
subplot(1,2,2); imshow(imagen_resultado); title('Imagen resultado');
figure()
subplot(1,1,1); bar(imhist(imagen_resultado)); title('Histograma resultado');
waitforbuttonpress;
close();close();

% Completo la ruta donde guardar la imagen y la guardo mediante imwrite y
% save en .mat
ruta_completa = fullfile(directorio_destino, tipo);
imwrite(imagen_resultado, fullfile(ruta_completa, [nombre_imagen '_' tipo tipo2 extension]));
save(fullfile(ruta_completa, [nombre_imagen '_' tipo tipo2 '.mat']), 'imagen_resultado');

% Inicio un bucle para permitir al usuario inspeccionar píxeles específicos de la imagen resultado.
while true
    revisar = input('¿Quieres ver un píxel de la imagen? (si/no): ', 's');
    if isempty(revisar) || strcmpi(revisar, 'no')
        break; % Sale del bucle si el usuario responde 'no' o no introduce nada.
    end
    
    if strcmpi(revisar, 'si')
        figure()
        imshow(imagen_resultado); title('Haz clic en un píxel para obtener datos');
        [x, y] = ginput(1); % Permite al usuario seleccionar un píxel en la imagen.
        close();
        % Redondeo las coordenadas para asegurarme de que son enteros.
        x = round(x); y = round(y);
        
        % Muestro el valor del píxel seleccionado.
        valor = imagen_resultado(y, x, :);
        disp(['Coordenadas del píxel seleccionado: (' num2str(x) ', ' num2str(y) ')']);
        disp(['Valor del píxel seleccionado B&N: ' num2str(valor)]);
    else
        disp('Opción no reconocida. Por favor, introduce "si" o "no".');
    end
end

% Presento nuevas opciones de algoritmos de agrupamiento al usuario.
disp('Selecciona una técnica de agrupamiento:');
disp('1. K-Means');
disp('2. Fuzzy C-Means');
disp('3. GMM');
disp('4. Exit');

% Inicio un bucle para asegurar que se selecciona una opción válida.
opcion_correcta = false;
while not(opcion_correcta)
    opcion = input('Introduce el número de la opción que deseas: ');
    opcion_correcta = true; % Asume inicialmente que la opción será válida.
    
    switch opcion
        case 1
            numClusters = input('Introduce el número de clusters que deseas: ');
            % Preparo una versión de la imagen final en tres canales para el proceso.
            imagen_invariante_tres = cat(3, imagen_resultado, imagen_resultado, imagen_resultado);
            
            % Aplico K-Means tanto a la imagen original como a la invariante.
            [imagen_original_KMeans, centers_original] = segmentar_imagen_KMeans(imagen_tres_canales, numClusters);
            [imagen_invariante_KMeans, centers_invariante] = segmentar_imagen_KMeans(imagen_invariante_tres, numClusters);

            porcentaje_original_KMeans = calcular_coincidencia(imagen_original_KMeans, img_ground_truth);
            porcentaje_invariante_KMeans = calcular_coincidencia(imagen_invariante_KMeans, img_ground_truth);
            
            % Muestro las imágenes (original e invariante) junto con sus versiones segmentadas.
            figure()
            subplot(2,2,1); imshow(imagen_tres_canales); title('Imagen original');
            subplot(2,2,2); imshow(imagen_resultado); title('Imagen invariante');
            subplot(2,2,3); imshow(imagen_original_KMeans); title(['Original K-Means ' num2str(porcentaje_original_KMeans) '%']);
            subplot(2,2,4); imshow(imagen_invariante_KMeans); title(['Invariante K-Means ' num2str(porcentaje_invariante_KMeans) '%']);
            waitforbuttonpress;
            close();
        case 2
            numClusters = input('Introduce el número de clusters que deseas: ');
            % Preparo una versión de la imagen final en tres canales para el proceso.
            imagen_invariante_tres = cat(3, imagen_resultado, imagen_resultado, imagen_resultado);
            
            % Aplico Fuzzy C-Means tanto a la imagen original como a la invariante.
            [imagen_original_CMeans, centers_original] = segmentar_imagen_fuzzy_CMeans(imagen_tres_canales, numClusters);
            [imagen_invariante_CMeans, centers_invariante] = segmentar_imagen_fuzzy_CMeans(imagen_invariante_tres, numClusters);
            
            porcentaje_original_CMeans = calcular_coincidencia(imagen_original_CMeans, img_ground_truth);
            porcentaje_invariante_CMeans = calcular_coincidencia(imagen_invariante_CMeans, img_ground_truth);

            % Muestro las imágenes (original e invariante) junto con sus versiones segmentadas.
            figure()
            subplot(2,2,1); imshow(imagen_tres_canales); title('Imagen original');
            subplot(2,2,2); imshow(imagen_resultado); title('Imagen invariante');
            subplot(2,2,3); imshow(imagen_original_CMeans); title(['Original C-Means ' num2str(porcentaje_original_CMeans) '%']);
            subplot(2,2,4); imshow(imagen_invariante_CMeans); title(['Invariante C-Means ' num2str(porcentaje_invariante_CMeans) '%']);
            waitforbuttonpress;
            close();
        case 3
            numClusters = input('Introduce el número de clusters que deseas: ');
            % Preparo una versión de la imagen final en tres canales para el proceso.
            imagen_invariante_tres = cat(3, imagen_resultado, imagen_resultado, imagen_resultado);
            
            % Aplico GMM tanto a la imagen original como a la invariante.
            [imagen_original_GMM, centers_original] = segmentar_imagen_GMM(imagen_tres_canales, numClusters);
            [imagen_invariante_GMM, centers_invariante] = segmentar_imagen_GMM(imagen_invariante_tres, numClusters);
            
            porcentaje_original_GMM = calcular_coincidencia(imagen_original_GMM, img_ground_truth);
            porcentaje_invariante_GMM = calcular_coincidencia(imagen_invariante_GMM, img_ground_truth);

            % Muestro las imágenes (original e invariante) junto con sus versiones segmentadas.
            figure()
            subplot(2,2,1); imshow(imagen_tres_canales); title('Imagen original');
            subplot(2,2,2); imshow(imagen_resultado); title('Imagen invariante');
            subplot(2,2,3); imshow(imagen_original_GMM); title(['Original GMM ' num2str(porcentaje_original_GMM) '%']);
            subplot(2,2,4); imshow(imagen_invariante_GMM); title(['Invariante GMM ' num2str(porcentaje_invariante_GMM) '%']);
            waitforbuttonpress;
            close();
        otherwise
            % Informo al usuario que la opción seleccionada no es válida y repite el bucle.
            disp('Opción no válida');
            opcion_correcta = false;
    end
end