function I_Upcroft = upcroft_transform(RGB, alpha)
    % Primero, convierto la imagen RGB a formato double para poder realizar cálculos con logaritmos.
    R = double(RGB(:,:,1));
    G = double(RGB(:,:,2));
    B = double(RGB(:,:,3));
    
    % Luego, aplico la transformación de Upcroft usando la fórmula dada.
    % Esta fórmula ajusta las intensidades de los canales RGB para realzar ciertas características.
    % Utilizo el canal verde como referencia y ajusto los canales rojo y azul con el parámetro alpha.
    I_Upcroft = log(G) - alpha*log(B) - (1 - alpha)*log(R);
end
