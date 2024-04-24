function I_Krajnik = krajnik_transform(RGB, theta)
    % Me aseguro de que la imagen RGB esté en formato double para los cálculos.
    R = double(RGB(:,:,1));
    G = double(RGB(:,:,2));
    B = double(RGB(:,:,3));

    % Calculo la cromaticidad logarítmica añadiendo 1 para evitar el logaritmo de cero.
    logR = log(R + 1); % Agrego 1 para evitar log(0)
    logG = log(G + 1);
    logB = log(B + 1);

    % Simplifico el proceso: utilizo directamente logR, logG, y logB como componentes.
    % Esto sirve como un marcador de posición para el verdadero proceso de proyección que usaría U.
    psi1 = logR - logG;
    psi2 = logG - logB;

    % Calculo I_Krajnik usando la fórmula dada con el ángulo theta.
    I_Krajnik = (psi1 * cos(theta) + psi2 * sin(theta));
end
