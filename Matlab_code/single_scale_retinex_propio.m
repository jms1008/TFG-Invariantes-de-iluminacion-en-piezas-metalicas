function ssr_image = single_scale_retinex_propio(input_image, sigma)
    % Para que esté en formato de punto flotante
    if isa(input_image, 'uint8')
        input_image = double(input_image) / 255;
    end

    % Convierto la imagen a escala de grises
    if size(input_image, 3) == 3
        input_image = rgb2gray(input_image);
    end
    
    % Aplico SSR usando una convolución con un kernel de desenfoque gaussiano
    % El logaritmo de la imagen original menos el logaritmo de la imagen filtrada
    % En los logaritmos pongo +1 para prevenir log(0)
    log_input_image = log(input_image + 1);
    gaussian_kernel = fspecial('gaussian', 6*sigma, sigma);
    log_filtered_image = log(imfilter(input_image, gaussian_kernel, 'replicate') + 1);
    ssr_result = log_input_image - log_filtered_image;
    
    % Normalizo el resultado para mejorar la visualización
    ssr_image = (ssr_result - min(ssr_result(:))) / (max(ssr_result(:)) - min(ssr_result(:)));
end
