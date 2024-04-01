function porcentaje_coincidencia = calcular_coincidencia(img1, img2)
    % Convierto la primera imagen a blanco y negro, incluyendo la detección de bordes.
    img1_bnw = convertir_a_blanco_negro_con_bordes(img1);
    % Convierto la segunda imagen directamente a escala de grises.
    img2_bnw = rgb2gray(img2);
    
    % Me aseguro de que ambas imágenes tengan el mismo tamaño para poder compararlas.
    if all(size(img1_bnw) == size(img2_bnw))
        % Calculo el número de píxeles que coinciden entre las dos imágenes.
        coincidencias = img1_bnw == img2_bnw;
        
        % Calculo el porcentaje de píxeles que coinciden sobre el total de píxeles.
        porcentaje_coincidencia = (sum(coincidencias(:)) / numel(img1_bnw)) * 100;
    else
        % Si las imágenes no tienen el mismo tamaño, muestro un error.
        error('Las imágenes deben tener el mismo tamaño.');
    end
end
