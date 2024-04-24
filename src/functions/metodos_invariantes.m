function imagen_resultado = metodos_invariantes(opcion, imagen_tres_canales, aux)
    % Dado que algunos resultados pueden llevar a valores infinitos y al normalizar, 
    % la imagen se oscurece demasiado, opto por truncar los valores excesivos.
    % Esto es especialmente necesario para las opciones del 5 al 9.
    switch opcion
        case 1
            % Uso PCA para reducir la dimensionalidad de la imagen, manteniendo la esencia.
            imagen_resultado = PCA(imagen_tres_canales);
        case 2
            % Aplico Retinex de escala única, usando 'aux' como parámetro necesario.
            imagen_resultado = single_scale_retinex_propio(imagen_tres_canales, aux);
        case 3
            % Utilizo Retinex de escala múltiple, también con 'aux' como parámetro.
            imagen_resultado = multi_scale_retinex_propio(imagen_tres_canales, aux);
        case 4
            % Implemento un filtro homomórfico para mejorar la visualización en condiciones de luz variadas.
            imagen_resultado = uint8(normalize8(homomorphic(rgb2gray(imagen_tres_canales), 2, .25, 2, 0, 5)));
        case 5
            % Empleo la transformación de Will Maddern y otros para invarianza a la iluminación.
            % Normalizo la imagen a valores entre 0 y 1 para evitar valores infinitos.
            imagen_resultado = RGB2IlluminationInvariant(double(imagen_tres_canales) / 255, aux); 
            imagen_resultado(imagen_resultado > 1) = 1; % Trunco los valores superiores a 1.
        case 6
            % Aplico la transformación de Álvarez para obtener otra invarianza a la iluminación.
            imagen_resultado = alvarez_transform(imagen_tres_canales, 45, aux);
            imagen_resultado(imagen_resultado > 1) = 1; % Trunco también aquí.
        case 7
            % Uso la transformación de Maddern para realzar ciertos aspectos bajo diferentes iluminaciones.
            imagen_resultado = maddern_transform(imagen_tres_canales, aux);
            imagen_resultado(imagen_resultado > 1) = 1; % Truncamiento igualmente.
        case 8
            % Opto por la transformación de Krajnik, para efectos similares de invariancia.
            imagen_resultado = krajnik_transform(imagen_tres_canales, aux);
            imagen_resultado(imagen_resultado > 1) = 1; % Mantengo la coherencia truncando.
        case 9
            % Finalmente, la transformación de Upcroft, siguiendo la misma línea de invariancia.
            imagen_resultado = upcroft_transform(imagen_tres_canales, aux);
            imagen_resultado(imagen_resultado > 1) = 1; % Trunco para evitar el oscurecimiento.
    end
