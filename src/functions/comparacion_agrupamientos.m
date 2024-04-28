function [] = comparacion_agrupamientos(imagen_tres_canales, imagen_resultado, img_ground_truth, nombre_imagen, tipo)
    % Pido el número de clusters
    numClusters_uno = input('Introduce el número de clusters (1) que deseas: ');
    numClusters_dos = input('Introduce el número de clusters (2) que deseas: ');
    % Preparo una versión de la imagen final en tres canales para el proceso.
    imagen_invariante_tres = cat(3, imagen_resultado, imagen_resultado, imagen_resultado);

    [imagen_original_agrup_K_Means_uno, porcentaje_original_agrup_K_Means_uno] = metodos_agrupamiento(1, imagen_tres_canales, img_ground_truth, numClusters_uno);
    [imagen_invariante_agrup_K_Means_uno, porcentaje_invariante_agrup_K_Means_uno] = metodos_agrupamiento(1, imagen_invariante_tres, img_ground_truth, numClusters_uno);
    [imagen_original_agrup_C_Means_uno, porcentaje_original_agrup_C_Means_uno] = metodos_agrupamiento(2, imagen_tres_canales, img_ground_truth, numClusters_uno);
    [imagen_invariante_agrup_C_Means_uno, porcentaje_invariante_agrup_C_Means_uno] = metodos_agrupamiento(2, imagen_invariante_tres, img_ground_truth, numClusters_uno);
    [imagen_original_agrup_GMM_uno, porcentaje_original_agrup_GMM_uno] = metodos_agrupamiento(3, imagen_tres_canales, img_ground_truth, numClusters_uno);
    [imagen_invariante_agrup_GMM_uno, porcentaje_invariante_agrup_GMM_uno] = metodos_agrupamiento(3, imagen_invariante_tres, img_ground_truth, numClusters_uno);
    [imagen_original_agrup_HMRF_EM_uno, porcentaje_original_agrup_HMRF_EM_uno] = metodos_agrupamiento(4, imagen_tres_canales, img_ground_truth, numClusters_uno);
    [imagen_invariante_agrup_HMRF_EM_uno, porcentaje_invariante_agrup_HMRF_EM_uno] = metodos_agrupamiento(4, imagen_invariante_tres, img_ground_truth, numClusters_uno);
    [imagen_original_agrup_K_Means_dos, porcentaje_original_agrup_K_Means_dos] = metodos_agrupamiento(1, imagen_tres_canales, img_ground_truth, numClusters_dos);
    [imagen_invariante_agrup_K_Means_dos, porcentaje_invariante_agrup_K_Means_dos] = metodos_agrupamiento(1, imagen_invariante_tres, img_ground_truth, numClusters_dos);
    [imagen_original_agrup_C_Means_dos, porcentaje_original_agrup_C_Means_dos] = metodos_agrupamiento(2, imagen_tres_canales, img_ground_truth, numClusters_dos);
    [imagen_invariante_agrup_C_Means_dos, porcentaje_invariante_agrup_C_Means_dos] = metodos_agrupamiento(2, imagen_invariante_tres, img_ground_truth, numClusters_dos);
    [imagen_original_agrup_GMM_dos, porcentaje_original_agrup_GMM_dos] = metodos_agrupamiento(3, imagen_tres_canales, img_ground_truth, numClusters_dos);
    [imagen_invariante_agrup_GMM_dos, porcentaje_invariante_agrup_GMM_dos] = metodos_agrupamiento(3, imagen_invariante_tres, img_ground_truth, numClusters_dos);
    [imagen_original_agrup_HMRF_EM_dos, porcentaje_original_agrup_HMRF_EM_dos] = metodos_agrupamiento(3, imagen_tres_canales, img_ground_truth, numClusters_dos);
    [imagen_invariante_agrup_HMRF_EM_dos, porcentaje_invariante_agrup_HMRF_EM_dos] = metodos_agrupamiento(3, imagen_invariante_tres, img_ground_truth, numClusters_dos);

    % Muestro las imágenes (original e invariante) junto con sus versiones segmentadas.
    figure()
    subplot(2,9,1); imshow(imagen_tres_canales); title('Imagen original');
    subplot(2,9,2); imshow(imagen_original_agrup_K_Means_uno); title(['Original K-Means ' num2str(porcentaje_original_agrup_K_Means_uno) '%']);
    subplot(2,9,3); imshow(imagen_original_agrup_C_Means_uno); title(['Original C-Means ' num2str(porcentaje_original_agrup_C_Means_uno) '%']);
    subplot(2,9,4); imshow(imagen_original_agrup_GMM_uno); title(['Original GMM ' num2str(porcentaje_original_agrup_GMM_uno) '%']);
    subplot(2,9,5); imshow(imagen_original_agrup_HMRF_EM_uno); title(['Original HMRF-EM ' num2str(porcentaje_original_agrup_HMRF_EM_uno) '%']);
    subplot(2,9,6); imshow(imagen_original_agrup_K_Means_dos); title(['Original K-Means ' num2str(porcentaje_original_agrup_K_Means_dos) '%']);
    subplot(2,9,7); imshow(imagen_original_agrup_C_Means_dos); title(['Original C-Means ' num2str(porcentaje_original_agrup_C_Means_dos) '%']);
    subplot(2,9,8); imshow(imagen_original_agrup_GMM_dos); title(['Original GMM ' num2str(porcentaje_original_agrup_GMM_dos) '%']);
    subplot(2,9,9); imshow(imagen_original_agrup_HMRF_EM_dos); title(['Original HMRF-EM ' num2str(porcentaje_original_agrup_HMRF_EM_dos) '%'])
    subplot(2,9,10); imshow(imagen_resultado); title('Imagen invariante');
    subplot(2,9,11); imshow(imagen_invariante_agrup_K_Means_uno); title(['Invariante K-Means ' num2str(porcentaje_invariante_agrup_K_Means_uno) '%']);
    subplot(2,9,12); imshow(imagen_invariante_agrup_C_Means_uno); title(['Invariante C-Means ' num2str(porcentaje_invariante_agrup_C_Means_uno) '%']);
    subplot(2,9,13); imshow(imagen_invariante_agrup_GMM_uno); title(['Invariante GMM ' num2str(porcentaje_invariante_agrup_GMM_uno) '%']);
    subplot(2,9,14); imshow(imagen_invariante_agrup_HMRF_EM_uno); title(['Invariante HMRF-EM ' num2str(porcentaje_invariante_agrup_HMRF_EM_uno) '%'])
    subplot(2,9,15); imshow(imagen_invariante_agrup_K_Means_dos); title(['Invariante K-Means ' num2str(porcentaje_invariante_agrup_K_Means_dos) '%']);
    subplot(2,9,16); imshow(imagen_invariante_agrup_C_Means_dos); title(['Invariante C-Means ' num2str(porcentaje_invariante_agrup_C_Means_dos) '%']);
    subplot(2,9,17); imshow(imagen_invariante_agrup_GMM_dos); title(['Invariante GMM ' num2str(porcentaje_invariante_agrup_GMM_dos) '%']);
    subplot(2,9,18); imshow(imagen_invariante_agrup_HMRF_EM_dos); title(['Invariante HMRF-EM ' num2str(porcentaje_invariante_agrup_HMRF_EM_dos) '%']);
    waitforbuttonpress;
    close();
    
    directorio_destino = '../results/Comparacion_agrup';

    % Guardo las imagenes invariantes
    imwrite(imagen_tres_canales, fullfile(directorio_destino, [nombre_imagen '_Original.jpg']));
    imwrite(imagen_resultado, fullfile(directorio_destino, [nombre_imagen '_PCA.jpg']));
    
    % Guardo las imagenes tras el agrupamiento
    imwrite(imagen_original_agrup_K_Means_uno, fullfile(directorio_destino, [nombre_imagen '_Original_K-Means_' num2str(porcentaje_original_agrup_K_Means_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_invariante_agrup_K_Means_uno, fullfile(directorio_destino, [nombre_imagen '_' tipo '_K-Means_' num2str(porcentaje_invariante_agrup_K_Means_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_original_agrup_C_Means_uno, fullfile(directorio_destino, [nombre_imagen '_Original_C-Means_' num2str(porcentaje_original_agrup_C_Means_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_invariante_agrup_C_Means_uno, fullfile(directorio_destino, [nombre_imagen '_' tipo '_C-Means_' num2str(porcentaje_invariante_agrup_C_Means_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_original_agrup_GMM_uno, fullfile(directorio_destino, [nombre_imagen '_Original_GMM_' num2str(porcentaje_original_agrup_GMM_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_invariante_agrup_GMM_uno, fullfile(directorio_destino, [nombre_imagen '_' tipo '_GMM_' num2str(porcentaje_invariante_agrup_GMM_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_original_agrup_HMRF_EM_uno, fullfile(directorio_destino, [nombre_imagen '_Original_HMRF_EM_' num2str(porcentaje_original_agrup_HMRF_EM_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_invariante_agrup_HMRF_EM_uno, fullfile(directorio_destino, [nombre_imagen '_' tipo '_HMRF_EM_' num2str(porcentaje_invariante_agrup_HMRF_EM_uno) '%_' num2str(numClusters_uno) 'c.jpg']));
    imwrite(imagen_original_agrup_K_Means_dos, fullfile(directorio_destino, [nombre_imagen '_Original_K-Means_' num2str(porcentaje_original_agrup_K_Means_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
    imwrite(imagen_invariante_agrup_K_Means_dos, fullfile(directorio_destino, [nombre_imagen '_' tipo '_K-Means_' num2str(porcentaje_invariante_agrup_K_Means_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
    imwrite(imagen_original_agrup_C_Means_dos, fullfile(directorio_destino, [nombre_imagen '_Original_C-Means_' num2str(porcentaje_original_agrup_C_Means_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
    imwrite(imagen_invariante_agrup_C_Means_dos, fullfile(directorio_destino, [nombre_imagen '_' tipo '_C-Means_' num2str(porcentaje_invariante_agrup_C_Means_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
    imwrite(imagen_original_agrup_GMM_dos, fullfile(directorio_destino, [nombre_imagen '_Original_GMM_' num2str(porcentaje_original_agrup_GMM_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
    imwrite(imagen_invariante_agrup_GMM_dos, fullfile(directorio_destino, [nombre_imagen '_' tipo '_GMM_' num2str(porcentaje_invariante_agrup_GMM_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
    imwrite(imagen_original_agrup_HMRF_EM_dos, fullfile(directorio_destino, [nombre_imagen '_Original_HMRF_EM_' num2str(porcentaje_original_agrup_HMRF_EM_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
    imwrite(imagen_invariante_agrup_HMRF_EM_dos, fullfile(directorio_destino, [nombre_imagen '_' tipo '_HMRF_EM_' num2str(porcentaje_invariante_agrup_HMRF_EM_dos) '%_' num2str(numClusters_dos) 'c.jpg']));
