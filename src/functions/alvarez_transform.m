function I_Alvarez = alvarez_transform(RGB, theta, alpha)
    % Primero, convierto la imagen RGB a formato double para asegurarme de que los cálculos sean precisos.
    R = double(RGB(:,:,1));
    G = double(RGB(:,:,2));
    B = double(RGB(:,:,3));
    
    % Luego, calculo las relaciones entre los canales rojo y azul, y verde y azul.
    RB_ratio = R ./ B; % Esto me da la relación entre el rojo y el azul.
    GB_ratio = G ./ B; % Y esto la relación entre el verde y el azul.
    
    % Ahora, aplico una aproximación logarítmica a estas relaciones.
    % Esta aproximación me ayuda a reducir la influencia de variaciones de iluminación.
    log_approx_RB = alpha * ((RB_ratio / alpha) - 1);
    log_approx_GB = alpha * ((GB_ratio / alpha) - 1);
    
    % Finalmente, calculo la imagen resultante, la cual es invariante a cambios en la iluminación.
    % Uso los parámetros theta y alpha para ajustar la transformación.
    I_Alvarez = cos(theta) * log_approx_RB + sin(theta) * log_approx_GB;
end
