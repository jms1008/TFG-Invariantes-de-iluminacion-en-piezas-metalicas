function [sigma_str, sigmas] = sigma_retinex(mode)
    if mode == 1
        prompt = 'Introduce el valor de sigma (ej. 60): ';
        default_sigmas = 60;
    elseif mode == 2
        prompt = 'Introduce los valores de sigma separados por comas (ej. 15,80,250): ';
        default_sigmas = [15, 80, 250];
    else
        error('Modo no soportado. Usa 1 para un solo valor o 2 para múltiples valores.');
    end

    user_input = input(prompt, 's'); % 's' indica que la entrada debe tratarse como texto.
    
    % Verifica si se introdujo algún valor.
    if isempty(user_input)
        sigmas = default_sigmas;
    else
        % Intenta convertir la entrada de texto del usuario en números.
        sigmas = str2num(user_input); 
        if isempty(sigmas)
            % Si la conversión falla, vuelve a los valores predeterminados e informa al usuario.
            sigmas = default_sigmas;
            disp('Entrada inválida. Usando valores por defecto.');
        elseif mode == 1 && length(sigmas) > 1
            % En el modo 1, si se introducen múltiples valores, solo se usa el primero.
            sigmas = sigmas(1);
            disp('Se esperaba un solo valor de sigma. Usando el primer valor proporcionado.');
        end
    end
    
    % Asegura que sigmas sea un vector, incluso si se introdujo un solo valor.
    if mode == 1 && isscalar(sigmas)
        sigmas = [sigmas];
    end
    
    % Construye una cadena de texto con los valores de sigma, separados por guiones bajos.
    sigma_str = strcat('_', strjoin(arrayfun(@num2str, sigmas, 'UniformOutput', false), '_'));
end
