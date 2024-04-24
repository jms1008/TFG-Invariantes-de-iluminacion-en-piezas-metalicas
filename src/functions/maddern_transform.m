function I_Maddern = maddern_transform(RGB, alpha)
    % Primero, convierto cada canal de la imagen RGB a formato double para los cálculos.
    R = double(RGB(:,:,1));
    G = double(RGB(:,:,2));
    B = double(RGB(:,:,3));
    
    % Ahora, aplico la transformación de Maddern a la imagen.
    % Esta fórmula ajusta la relación entre los canales R, G, y B según el parámetro alpha.
    % La idea es destacar características específicas dependiendo del valor de alpha.
    I_Maddern = 0.5 + log(G) - alpha*log(B) - (1 - alpha)*log(R);
end
