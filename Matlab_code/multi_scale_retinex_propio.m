function msr_image = multi_scale_retinex_propio(input_image, sigmas)
    % Para que esté en formato de punto flotante
    if isa(input_image, 'uint8')
        input_image = double(input_image) / 255;
    end

    % Inicializar el resultado de MSR como ceros
    [rows, cols, channels] = size(input_image);
    msr_result = zeros(rows, cols, channels);
    
    % Aplicar SSR para cada escala y sumar los resultados
    % En los logaritmos pongo +1 para prevenir log(0)
    for sigma = sigmas
        for ch = 1:channels
            channel = input_image(:, :, ch);
            log_input = log(channel + 1);
            gaussian_kernel = fspecial('gaussian', ceil(6*sigma), sigma);
            filtered = imfilter(channel, gaussian_kernel, 'replicate');
            log_filtered = log(filtered + 1);
            msr_result(:, :, ch) = msr_result(:, :, ch) + (log_input - log_filtered);
        end
    end
    
    % Promedios de las diferentes escalas
    msr_result = msr_result / length(sigmas);
    
    % Normalizo el resultado de MSR para cada canal
    msr_image = zeros(size(msr_result));
    for ch = 1:channels
        channel = msr_result(:, :, ch);
        channel = (channel - min(channel(:))) / (max(channel(:)) - min(channel(:)));
        msr_image(:, :, ch) = channel;
    end
end
