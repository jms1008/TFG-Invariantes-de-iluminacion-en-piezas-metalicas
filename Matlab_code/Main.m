%% TFG Invariantes de iluminación
%% Jonás Martínez Sanllorente

% Elijo los directorios de origen y destino para las imágenes.
directorio_origen = ['../Imagenes\Imagenes-Piezas' ...
    '\Imagenes-Camara-NikonCoolpixL830/'];
directorio_destino = '../Imagenes_resultado';

% Abro un cuadro de diálogo para seleccionar una imagen.
[imagen_seleccionada, ruta] = uigetfile(fullfile(directorio_origen, ...
    '*.*'), 'Selecciona una imagen');
% Extraigo el nombre y la extensión de la imagen seleccionada.
[~, nombre_imagen, extension] = fileparts(imagen_seleccionada);

% Leo la imagen desde su ruta completa.
imagen = imread(fullfile(ruta, imagen_seleccionada));
% Proceso la imagen para obtener una versión de tres canales.
imagen_tres_canales = ImagenTresCanales(imagen);

% Muestro la imagen original y la versión procesada lado a lado.
figure
subplot(1,2,1); imshow(imagen); title('Imagen original');
subplot(1,2,2); imshow(imagen_tres_canales); title('Imagen tres canales');
waitforbuttonpress;
close();
