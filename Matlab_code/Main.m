%% TFG Invariantes de iluminación
%% Jonás Martínez Sanllorente

% Elijo los directorios de origen y destino para las imágenes.
directorio_origen = '../Imagenes\Imagenes-Piezas\Imagenes-Camara-NikonCoolpixL830/';
directorio_destino = '../Imagenes_resultado';

% Abro un cuadro de diálogo para seleccionar una imagen.
[imagen_seleccionada, ruta] = uigetfile(fullfile(directorio_origen, '*.*'), 'Selecciona una imagen');
% Extraigo el nombre y la extensión de la imagen seleccionada.
[~, nombre_imagen, extension] = fileparts(imagen_seleccionada);

% Leo la imagen desde su ruta completa.
imagen = imread(fullfile(ruta, imagen_seleccionada));
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

% Muestro la imagen original, la imagen resultado.
figure()
subplot(1,2,1); imshow(imagen_tres_canales); title('Imagen original');
subplot(1,2,2); imshow(imagen_resultado); title('Imagen resultado');
waitforbuttonpress;
close();

% Completo la ruta donde guardar la imagen y la guardo mediante imwrite
ruta_completa = fullfile(directorio_destino, tipo);
imwrite(imagen_resultado_uint8, fullfile(ruta_completa, [nombre_imagen '_' tipo tipo2 extension]));

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
