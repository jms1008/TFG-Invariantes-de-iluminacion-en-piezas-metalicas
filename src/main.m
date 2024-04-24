%% TFG Invariantes de iluminación
%% Jonás Martínez Sanllorente

% Añado las finciones
addpath('functions');

% Elijo los directorios de origen y destino para las imágenes.
directorio_origen = '../data/Imagenes\Piezas\Camara-NikonCoolpixL830/';
directorio_destino = '../results/Imagenes_resultado';
directorio_ground_truth = '../data/Imagenes_ground_truth\Piezas\Camara-NikonCoolpixL830/';

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
disp(' 1. PCA');
disp(' 2. Retinex singlescale');
disp(' 3. Retinex multiscale');
disp(' 4. Homomorphic');
disp(' 5. MaddLightNav');
disp(' 6. Alvarez');
disp(' 7. Maddern');
disp(' 8. Krajnık');
disp(' 9. Upcrof');
disp('10. Comparación');
disp('11. Exit');
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
            tipo2 = ''; aux = 0;
            %imagen_resultado = PCA(imagen_tres_canales);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, 0);
        case 2
            tipo = 'Retinex_s_s';
            [tipo2, aux] = aux_propio(1, 60);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 3
            tipo = 'Retinex_m_s';
            [tipo2, aux] = aux_propio(2, 60);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 4
            tipo = 'Homomorphic';
            tipo2 = ''; aux = 0;
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 5
            % Will Maddern, Alexander D. Stewart, Colin McManus, Ben Upcroft, Winston Churchill, y Paul Newman
            tipo = 'MaddLightNav';
            [tipo2, aux] = aux_propio(1, .2);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 6
            tipo = 'Alvarez';
            [tipo2, aux] = aux_propio(1, .5);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 7
            % Gran cantidad de ruido
            tipo = 'Maddern';
            [tipo2, aux] = aux_propio(1, .48);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 8
            tipo = 'Krajnık';
            % de 0 a 180º y no hace falta truncar
            [tipo2, aux] = aux_propio(1, 45);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 9
            tipo = 'Upcrof';
            % Depende mucho de la camara, con .9 se ve bien, con 2 muy bien 
            [tipo2, aux] = aux_propio(1, 2);
            imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux);
        case 10
            comparacion_metodos(imagen_tres_canales, img_ground_truth, nombre_imagen);
            error('Fin de la ejecución')
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
ruta_completa2 = fullfile(directorio_destino, 'Originales');
imwrite(imagen_resultado, fullfile(ruta_completa, [nombre_imagen '_' tipo tipo2 extension]));

respuesta = input('¿Deseas guardar la imagen en formato .mat? (y/n): ', 's');
% Convertir la respuesta a minúsculas para manejar 'Y' o 'y' igualmente
respuesta = lower(respuesta);
if respuesta == 'y'
    save(fullfile(ruta_completa, [nombre_imagen '_' tipo tipo2 '.mat']), 'imagen_resultado');
end

% Inicio un bucle para permitir al usuario inspeccionar píxeles específicos de la imagen resultado.
while true
    revisar = input('¿Quieres ver un píxel de la imagen? (y/n): ', 's');
    if isempty(revisar) || strcmpi(revisar, 'n')
        break; % Sale del bucle si el usuario responde 'no' o no introduce nada.
    end
    
    if strcmpi(revisar, 'y')
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
disp('4. Comparación');

% Inicio un bucle para asegurar que se selecciona una opción válida.
opcion_correcta = false;
while not(opcion_correcta)
    opcion = input('Introduce el número de la opción que deseas: ');
    opcion_correcta = true; % Asume inicialmente que la opción será válida.
    switch opcion
        case 1
            tipo_agrup = 'K-Means';
        case 2
            tipo_agrup = 'C-Means';
        case 3
            tipo_agrup = 'GMM';
        case 4
            comparacion_agrupamientos(imagen_tres_canales, imagen_resultado, img_ground_truth, nombre_imagen, tipo);
            error('Fin de la ejecución')
        otherwise
            % Informo al usuario que la opción seleccionada no es válida y repite el bucle.
            disp('Opción no válida');
            opcion_correcta = false;
    end
end

% Pido el número de clusters
numClusters = input('Introduce el número de clusters que deseas: ');
% Preparo una versión de la imagen final en tres canales para el proceso.
imagen_invariante_tres = cat(3, imagen_resultado, imagen_resultado, imagen_resultado);

[imagen_original_agrup, porcentaje_original_agrup] = metodos_agrupamiento(opcion, imagen_tres_canales, img_ground_truth, numClusters);
[imagen_invariante_agrup, porcentaje_invariante_agrup] = metodos_agrupamiento(opcion, imagen_invariante_tres, img_ground_truth, numClusters);

% Muestro las imágenes (original e invariante) junto con sus versiones segmentadas.
figure()
subplot(2,2,1); imshow(imagen_tres_canales); title('Imagen original');
subplot(2,2,2); imshow(imagen_resultado); title('Imagen invariante');
subplot(2,2,3); imshow(imagen_original_agrup); title(['Original ' tipo_agrup ' ' num2str(porcentaje_original_agrup) '%']);
subplot(2,2,4); imshow(imagen_invariante_agrup); title(['Invariante ' tipo_agrup ' ' num2str(porcentaje_invariante_agrup) '%']);
waitforbuttonpress;
close();

% Guardo las imagenes invariantes
imwrite(imagen_tres_canales, fullfile(ruta_completa2, [nombre_imagen '_Original.jpg']));
imwrite(imagen_resultado, fullfile(ruta_completa, [nombre_imagen '_PCA.jpg']));

% Guardo las imagenes tras el agrupamiento
imwrite(imagen_original_agrup, fullfile(ruta_completa2, [nombre_imagen '_Original_' tipo_agrup '_' num2str(porcentaje_original_agrup) '%_' num2str(numClusters) 'c.jpg']));
imwrite(imagen_invariante_agrup, fullfile(ruta_completa, [nombre_imagen '_' tipo '_' tipo_agrup '_' num2str(porcentaje_invariante_agrup) '%_' num2str(numClusters) 'c.jpg']));
