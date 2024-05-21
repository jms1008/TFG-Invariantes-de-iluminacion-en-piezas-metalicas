% Rutas de origen, ground truth y destino
directorio_origen = '../../data/Imagenes/Piezas';
directorio_ground_truth = '../../data/Imagenes_ground_truth/Piezas';
directorio_destino = '../../results/Ejecucion_todas';

% Obtener lista de imágenes en las carpetas
archivosImagenes = dir(fullfile(directorio_origen, '*.*'));
archivosImagenesGroundTruth = dir(fullfile(directorio_ground_truth, '*.*'));

% Filtrar archivos para excluir '.' y '..'
archivosImagenes = archivosImagenes(~ismember({archivosImagenes.name}, {'.', '..'}));
archivosImagenesGroundTruth = archivosImagenesGroundTruth(~ismember({archivosImagenesGroundTruth.name}, {'.', '..'}));

% Definir parámetros de la ejecución
numCentros = [2, 3];
algoritmos_invariantes = 1:5;
algoritmos_agrupamiento = 1:4;

% Por cada imagen
for i = 21:length(archivosImagenes)
    % Nombre y extensión
    [~, nombre_imagen, extension] = fileparts(archivosImagenes(i).name);
    
    % Leer la imagen y su correspondiente ground truth
    imagen = imread(fullfile(directorio_origen, archivosImagenes(i).name));
    imagen_ground_truth = imread(fullfile(directorio_ground_truth, archivosImagenesGroundTruth(i).name)); 

    % Convertir la imagen a tres canales si es necesario
    imagen_tres_canales = ImagenTresCanales(imagen);
    
    % Ejecutar para dos y tres centros
    for nCentros = numCentros
        % Ejecutar para cada uno de los algoritmos invariantes
        for alg1 = algoritmos_invariantes
            switch alg1
                case 1
                    invariante = 'Alvarez';
                    aux = 0.5;
                case 2
                    invariante = 'Maddern';
                    aux = calcular_alpha(620, 540, 470);
                case 3
                    invariante = 'Krajnık';
                    aux = calcular_theta_krajnik(imagen_tres_canales);
                case 4
                    invariante = 'Upcrof';
                    aux = calcular_alpha(620, 540, 470);
                case 5
                    invariante = 'PCA';
                    aux = 0;
            end
            
            % Aplicar el método invariante
            imagen_invariante = metodos_invariantes_app(alg1, imagen_tres_canales, aux);
            imwrite(imagen_invariante, fullfile(directorio_destino, sprintf('1__%s_%s%s', nombre_imagen, invariante, extension)));

            % Convertir la imagen invariante a tres canales
            imagen_invariante_tres = cat(3, imagen_invariante, imagen_invariante, imagen_invariante);
 
            % Ejecutar para cada uno de los algoritmos de agrupamiento
            for alg2 = algoritmos_agrupamiento
                switch alg2
                    case 1
                        agrupamiento = 'K-Means';
                    case 2
                        agrupamiento = 'C-Means';
                    case 3
                        agrupamiento = 'GMM';
                    case 4
                        agrupamiento = 'Spatial';
                end

                if alg1 == 1
                    % Agrupamiento sobre la imagen original
                    [imagen_original_agrup, porcentaje_original] = metodos_agrupamiento(alg2, imagen_tres_canales, imagen_ground_truth, nCentros);
                    suffix_original = sprintf('_%d_c_%.2f%%', nCentros, porcentaje_original);
                    imwrite(imagen_original_agrup, fullfile(directorio_destino, sprintf('2_%s_Original_%s%s%s', nombre_imagen, agrupamiento, suffix_original, extension)));
                end
                
                % Agrupamiento sobre la imagen invariante
                [imagen_invariante_agrup, porcentaje_invariante] = metodos_agrupamiento(alg2, imagen_invariante_tres, imagen_ground_truth, nCentros);
                suffix_invariante = sprintf('_%d_c_%.2f%%', nCentros, porcentaje_invariante);
                imwrite(imagen_invariante_agrup, fullfile(directorio_destino, sprintf('3_%s_%s_%s%s%s', nombre_imagen, invariante, agrupamiento, suffix_invariante, extension)));
            end
        end
    end
end
