function msr_image = multi_scale_retinex_propio(input_image, sigmas)
    % Inicializar el resultado de MSR como ceros. Dado que single_scale_retinex_propio
    % convertirá la imagen a escala de grises, solo necesitamos dimensiones de 2D.
    [rows, cols, ~] = size(input_image);
    msr_result = zeros(rows, cols);
    
    % Aplicar SSR para cada valor de sigma en sigmas y acumular los resultados.
    % single_scale_retinex_propio maneja la conversión a escala de grises y la normalización.
    for sigma = sigmas
        ssr_result = single_scale_retinex_propio(input_image, sigma);
        msr_result = msr_result + ssr_result;
    end
    
    % Promediar los resultados de las diferentes escalas
    % La imagen resultante ya está en escala de grises y normalizada.
    msr_image = msr_result / length(sigmas);
end
