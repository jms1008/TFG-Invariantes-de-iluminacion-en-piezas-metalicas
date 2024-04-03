function [] = comparacion_metodos(imagen_tres_canales, img_ground_truth, nombre_imagen)
    % Comparación de todas con mejores resultados
    imagen_resultado_PCA = metodos_invariantes(1, imagen_tres_canales, 0);
    imagen_resultado_Retinex_s_s = metodos_invariantes(2, imagen_tres_canales, 15);
    imagen_resultado_Retinex_m_s = metodos_invariantes(3, imagen_tres_canales, [8,15,30]);
    imagen_resultado_Homomorphic = metodos_invariantes(4, imagen_tres_canales, 0);
    imagen_resultado_MaddLightNav = metodos_invariantes(5, imagen_tres_canales, .2);
    imagen_resultado_Alvarez = metodos_invariantes(6, imagen_tres_canales, .5);
    imagen_resultado_Maddern = metodos_invariantes(7, imagen_tres_canales, .48);
    imagen_resultado_Krajnik = metodos_invariantes(8, imagen_tres_canales, 45);
    imagen_resultado_Upcrof = metodos_invariantes(9, imagen_tres_canales, 2);

    figure()
    subplot(2,5,1); imshow(imagen_tres_canales); title('Imagen original');
    subplot(2,5,2); imshow(imagen_resultado_PCA); title('Imagen PCA');
    subplot(2,5,3); imshow(imagen_resultado_Retinex_s_s); title('Imagen Retinex_s_s');
    subplot(2,5,4); imshow(imagen_resultado_Retinex_m_s); title('Imagen Retinex_m_s');
    subplot(2,5,5); imshow(imagen_resultado_Homomorphic); title('Imagen Homomorphic');
    subplot(2,5,6); imshow(imagen_resultado_MaddLightNav); title('Imagen MaddLightNav');
    subplot(2,5,7); imshow(imagen_resultado_Alvarez); title('Imagen Alvarez');
    subplot(2,5,8); imshow(imagen_resultado_Maddern); title('Imagen Maddern');
    subplot(2,5,9); imshow(imagen_resultado_Krajnik); title('Imagen Krajnik');
    subplot(2,5,10); imshow(imagen_resultado_Upcrof); title('Imagen Upcrof');
    waitforbuttonpress;
    close();

    % Llamar luego a k-means
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
                tipo = 'K-Means';
            case 2
                tipo = 'C-Means';
            case 3
                tipo = 'GMM';
            otherwise
                % Informo al usuario que la opción seleccionada no es válida y repite el bucle.
                disp('Opción no válida');
                opcion_correcta = false;
        end
    end

    % Pido el número de clusters
    numClusters = input('Introduce el número de clusters que deseas: ');

    % Preparo una versión de las imagenes finales en tres canales para el proceso.
    imagen_PCA_tres = cat(3, imagen_resultado_PCA, imagen_resultado_PCA, imagen_resultado_PCA);
    imagen_Retinex_s_s_tres = cat(3, imagen_resultado_Retinex_s_s, imagen_resultado_Retinex_s_s, imagen_resultado_Retinex_s_s);
    imagen_Retinex_m_s_tres = cat(3, imagen_resultado_Retinex_m_s, imagen_resultado_Retinex_m_s, imagen_resultado_Retinex_m_s);
    imagen_Homomorphic_tres = cat(3, imagen_resultado_Homomorphic, imagen_resultado_Homomorphic, imagen_resultado_Homomorphic);
    imagen_MaddLightNav_tres = cat(3, imagen_resultado_MaddLightNav, imagen_resultado_MaddLightNav, imagen_resultado_MaddLightNav);
    imagen_Alvarez_tres = cat(3, imagen_resultado_Alvarez, imagen_resultado_Alvarez, imagen_resultado_Alvarez);
    imagen_Maddern_tres = cat(3, imagen_resultado_Maddern, imagen_resultado_Maddern, imagen_resultado_Maddern);
    imagen_Krajnik_tres = cat(3, imagen_resultado_Krajnik, imagen_resultado_Krajnik, imagen_resultado_Krajnik);
    imagen_Upcrof_tres = cat(3, imagen_resultado_Upcrof, imagen_resultado_Upcrof, imagen_resultado_Upcrof);

    [imagen_original_agrup, porcentaje_original_agrup] = metodos_agrupamiento(opcion, imagen_tres_canales, img_ground_truth, numClusters);
    [imagen_PCA_agrup, porcentaje_PCA_agrup] = metodos_agrupamiento(opcion, imagen_PCA_tres, img_ground_truth, numClusters);
    [imagen_Retinex_s_s_agrup, porcentaje_Retinex_s_s_agrup] = metodos_agrupamiento(opcion, imagen_Retinex_s_s_tres, img_ground_truth, numClusters);
    [imagen_Retinex_m_s_agrup, porcentaje_Retinex_m_s_agrup] = metodos_agrupamiento(opcion, imagen_Retinex_m_s_tres, img_ground_truth, numClusters);
    [imagen_Homomorphic_agrup, porcentaje_Homomorphic_agrup] = metodos_agrupamiento(opcion, imagen_Homomorphic_tres, img_ground_truth, numClusters);
    [imagen_MaddLightNav_agrup, porcentaje_MaddLightNav_agrup] = metodos_agrupamiento(opcion, imagen_MaddLightNav_tres, img_ground_truth, numClusters);
    [imagen_Alvarez_agrup, porcentaje_Alvarez_agrup] = metodos_agrupamiento(opcion, imagen_Alvarez_tres, img_ground_truth, numClusters);
    [imagen_Maddern_agrup, porcentaje_Maddern_agrup] = metodos_agrupamiento(opcion, imagen_Maddern_tres, img_ground_truth, numClusters);
    [imagen_Krajnik_agrup, porcentaje_Krajnik_agrup] = metodos_agrupamiento(opcion, imagen_Krajnik_tres, img_ground_truth, numClusters);
    [imagen_Upcrof_agrup, porcentaje_Upcrof_agrup] = metodos_agrupamiento(opcion, imagen_Upcrof_tres, img_ground_truth, numClusters);

    figure()
    subplot(4,5,1); imshow(imagen_tres_canales); title('Imagen original');
    subplot(4,5,2); imshow(imagen_resultado_PCA); title('Imagen PCA');
    subplot(4,5,3); imshow(imagen_resultado_Retinex_s_s); title('Imagen Retinex_s_s');
    subplot(4,5,4); imshow(imagen_resultado_Retinex_m_s); title('Imagen Retinex_m_s');
    subplot(4,5,5); imshow(imagen_resultado_Homomorphic); title('Imagen Homomorphic');
    subplot(4,5,6); imshow(imagen_resultado_MaddLightNav); title('Imagen MaddLightNav');
    subplot(4,5,7); imshow(imagen_resultado_Alvarez); title('Imagen Alvarez');
    subplot(4,5,8); imshow(imagen_resultado_Maddern); title('Imagen Maddern');
    subplot(4,5,9); imshow(imagen_resultado_Krajnik); title('Imagen Krajnik');
    subplot(4,5,10); imshow(imagen_resultado_Upcrof); title('Imagen Upcrof');
    subplot(4,5,11); imshow(imagen_original_agrup); title(['Original ' tipo ' ' num2str(porcentaje_original_agrup) '%']);
    subplot(4,5,12); imshow(imagen_PCA_agrup); title(['PCA ' tipo ' ' num2str(porcentaje_PCA_agrup) '%']);
    subplot(4,5,13); imshow(imagen_Retinex_s_s_agrup); title(['Retinex_s_s ' tipo ' ' num2str(porcentaje_Retinex_s_s_agrup) '%']);
    subplot(4,5,14); imshow(imagen_Retinex_m_s_agrup); title(['Retinex_m_s ' tipo ' ' num2str(porcentaje_Retinex_m_s_agrup) '%']);
    subplot(4,5,15); imshow(imagen_Homomorphic_agrup); title(['Homomorphic ' tipo ' ' num2str(porcentaje_Homomorphic_agrup) '%']);
    subplot(4,5,16); imshow(imagen_MaddLightNav_agrup); title(['MaddLightNav ' tipo ' ' num2str(porcentaje_MaddLightNav_agrup) '%']);
    subplot(4,5,17); imshow(imagen_Alvarez_agrup); title(['Alvarez ' tipo ' ' num2str(porcentaje_Alvarez_agrup) '%']);
    subplot(4,5,18); imshow(imagen_Maddern_agrup); title(['Maddern ' tipo ' ' num2str(porcentaje_Maddern_agrup) '%']);
    subplot(4,5,19); imshow(imagen_Krajnik_agrup); title(['Krajnik ' tipo ' ' num2str(porcentaje_Krajnik_agrup) '%']);
    subplot(4,5,20); imshow(imagen_Upcrof_agrup); title(['Upcrof ' tipo ' ' num2str(porcentaje_Upcrof_agrup) '%']);
    waitforbuttonpress;
    close();

    % Guardo las imagenes invariantes
    directorio_destino = '../Imagenes_resultado/Comparacion';
    imwrite(imagen_tres_canales, fullfile(directorio_destino, [nombre_imagen '_Original.jpg']));
    imwrite(imagen_resultado_PCA, fullfile(directorio_destino, [nombre_imagen '_PCA.jpg']));
    imwrite(imagen_resultado_Retinex_s_s, fullfile(directorio_destino, [nombre_imagen '_Retinex_s_s.jpg']));
    imwrite(imagen_resultado_Retinex_m_s, fullfile(directorio_destino, [nombre_imagen '_Retinex_m_s.jpg']));
    imwrite(imagen_resultado_Homomorphic, fullfile(directorio_destino, [nombre_imagen '_Homomorphic.jpg']));
    imwrite(imagen_resultado_MaddLightNav, fullfile(directorio_destino, [nombre_imagen '_MaddLightNav.jpg']));
    imwrite(imagen_resultado_Alvarez, fullfile(directorio_destino, [nombre_imagen '_Alvarez.jpg']));
    imwrite(imagen_resultado_Maddern, fullfile(directorio_destino, [nombre_imagen '_Maddern.jpg']));
    imwrite(imagen_resultado_Krajnik, fullfile(directorio_destino, [nombre_imagen '_Krajnik.jpg']));
    imwrite(imagen_resultado_Upcrof, fullfile(directorio_destino, [nombre_imagen '_Upcrof.jpg']));
    
    % Guardo las imagenes tras el agrupamiento
    imwrite(imagen_original_agrup, fullfile(directorio_destino, [nombre_imagen '_Original_' tipo '_' num2str(porcentaje_original_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_PCA_agrup, fullfile(directorio_destino, [nombre_imagen '_PCA_' tipo '_' num2str(porcentaje_PCA_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_Retinex_s_s_agrup, fullfile(directorio_destino, [nombre_imagen '_Retinex_s_s_' tipo '_' num2str(porcentaje_Retinex_s_s_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_Retinex_m_s_agrup, fullfile(directorio_destino, [nombre_imagen '_Retinex_m_s_' tipo '_' num2str(porcentaje_Retinex_m_s_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_Homomorphic_agrup, fullfile(directorio_destino, [nombre_imagen '_Homomorphic_' tipo '_' num2str(porcentaje_Homomorphic_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_MaddLightNav_agrup, fullfile(directorio_destino, [nombre_imagen '_MaddLightNav_' tipo '_' num2str(porcentaje_MaddLightNav_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_Alvarez_agrup, fullfile(directorio_destino, [nombre_imagen '_Alvarez_' tipo '_' num2str(porcentaje_Alvarez_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_Maddern_agrup, fullfile(directorio_destino, [nombre_imagen '_Maddern_' tipo '_' num2str(porcentaje_Maddern_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_Krajnik_agrup, fullfile(directorio_destino, [nombre_imagen '_Krajnik_' tipo '_' num2str(porcentaje_Krajnik_agrup) '%_' num2str(numClusters) 'c.jpg']));
    imwrite(imagen_Upcrof_agrup, fullfile(directorio_destino, [nombre_imagen '_Upcrof_' tipo '_' num2str(porcentaje_Upcrof_agrup) '%_' num2str(numClusters) 'c.jpg']));
end
