function [aux_str, aux] = aux_propio(mode, default)
    % Primero, decido qué prompt mostrar basándome en el modo.
    if mode == 1
        % Para un valor único, preparo un prompt con un ejemplo usando el valor por defecto.
        prompt = ['Introduce el valor de aux (ej. ' num2str(default) '): '];
        default_aux = default; % Establezco el valor por defecto para este modo.
    elseif mode == 2
        % Para múltiples valores, mi prompt pide varios valores separados por comas.
        prompt = 'Introduce los valores de aux separados por comas (ej. 15,80,250): ';
        default_aux = [15, 80, 250]; % Aquí, los valores por defecto son varios.
    else
        % Si el modo no es 1 ni 2, informo que no es soportado.
        error('Modo no soportado. Usa 1 para un solo valor o 2 para múltiples valores.');
    end

    % Pido al usuario que introduzca el valor o valores de aux.
    user_input = input(prompt, 's'); % 's' para tratar la entrada como texto.
    
    % Chequeo si el usuario introdujo algo.
    if isempty(user_input)
        aux = default_aux; % Si no hay entrada, uso los valores por defecto.
    else
        % Intento convertir la entrada de texto a números.
        aux = str2num(user_input); 
        if isempty(aux)
            % Si no se puede convertir, vuelvo a los valores por defecto e informo al usuario.
            aux = default_aux;
            disp('Entrada inválida. Usando valores por defecto.');
        elseif mode == 1 && length(aux) > 1
            % En modo 1, si el usuario introduce varios valores, solo tomo el primero.
            aux = aux(1);
            disp('Se esperaba un solo valor. Usando el primer valor proporcionado.');
        end
    end
    
    % Me aseguro de que aux sea un vector, incluso si solo es un valor.
    if mode == 1 && isscalar(aux)
        aux = [aux];
    end
    
    % Creo una cadena con los valores de aux, separados por guiones bajos.
    aux_str = strcat('_', strjoin(arrayfun(@num2str, aux, 'UniformOutput', false), '_'));
end
