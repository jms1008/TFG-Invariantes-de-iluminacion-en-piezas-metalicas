function imagen_resultado = metodos_invariantes_app(opcion, imagen_tres_canales, aux)
    switch opcion
        case 1
            imagen_resultado = alvarez_transform(imagen_tres_canales, 45, aux);
        case 2
            imagen_resultado = maddern_transform(imagen_tres_canales, aux);
        case 3
            imagen_resultado = krajnik_transform(imagen_tres_canales, aux);
        case 4
            imagen_resultado = upcroft_transform(imagen_tres_canales, aux);
        case 5
            imagen_resultado = PCA(imagen_tres_canales);
    end
    imagen_resultado(imagen_resultado > 1) = 1;
    imagen_resultado = uint8(255 * mat2gray(imagen_resultado));
end
