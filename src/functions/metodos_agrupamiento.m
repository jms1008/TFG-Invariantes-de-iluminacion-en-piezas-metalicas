function [imagen_final, porcentaje] = metodos_agrupamiento(opcion, imagen, img_ground_truth, numClusters)
    switch opcion
        case 1
            % Elijo aplicar el método de K-Means a la imagen.
            [imagen_final, ~] = segmentar_imagen_KMeans(imagen, numClusters);
            % Calculo el porcentaje de coincidencia con la imagen de verdad terreno.
            porcentaje = calcular_coincidencia(imagen_final, img_ground_truth);
        case 2
            % Decido usar Fuzzy C-Means para segmentar la imagen.
            [imagen_final, ~] = segmentar_imagen_fuzzy_CMeans(imagen, numClusters);
            % Vuelvo a calcular el porcentaje de coincidencia con la imagen base.
            porcentaje = calcular_coincidencia(imagen_final, img_ground_truth);
        case 3
            % Opto por aplicar el método GMM para la segmentación.
            [imagen_final, ~] = segmentar_imagen_GMM(imagen, numClusters);
            % Determino cómo de acertada fue la segmentación comparando con el ground truth.
            porcentaje = calcular_coincidencia(imagen_final, img_ground_truth);
        otherwise
            % Si la opción no es reconocida, aviso al usuario.
            disp('Opción no válida');
            imagen_final = imagen; % Devuelvo la imagen original.
            porcentaje = 0; % Indico que no hay coincidencia al no aplicar ningún método.
    end
