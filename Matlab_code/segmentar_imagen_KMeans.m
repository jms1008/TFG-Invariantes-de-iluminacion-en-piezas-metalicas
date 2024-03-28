function [imgResultante, centers] = segmentar_imagen_KMeans(img, numClusters)
    [height, width, ~] = size(img);
    datosImg = double(reshape(img, [], 3));

    % Aplicar K-Means
    [membership, centers] = kmeans(datosImg, numClusters);

    % Definir una paleta de colores RGB
    colores = [255, 0, 0; 0, 255, 0; 0, 0, 255; 255, 255, 0; 0, 255, 255; 255, 0, 255; 255, 127, 0; 127, 0, 255; 0, 127, 255; 127, 255, 0];
    colores = colores(1:numClusters, :); % Asegurarse de tener suficientes colores

    % Crear imagen resultante
    imgResultante = zeros(height * width, 3); % Para formato RGB
    for k = 1:numClusters
        idx = find(membership == k);
        imgResultante(idx, :) = repmat(colores(k, :), length(idx), 1);
    end

    % Cambiar la forma de la imagen resultante al formato original y convertir a uint8
    imgResultante = uint8(reshape(imgResultante, [height, width, 3]));
end
