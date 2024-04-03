function [ ii_image ] = RGB2IlluminationInvariant( image, alpha )
    % Primero, calculo la invarianza a la iluminación de una imagen RGB. 
    % La fórmula utiliza una combinación logarítmica de los canales.
    % Alpha es un parámetro que ajusta el peso entre los canales rojo y azul.
    
    % Aplico la transformación específica para lograr la invarianza.
    % Uso el canal verde como base, y resto los canales rojo y azul ponderados por alpha.
    % Esto me ayuda a reducir la variación causada por diferentes iluminaciones.
    ii_image = 0.5 + log(image(:,:,2)) - alpha*log(image(:,:,3)) - (1-alpha)*log(image(:,:,1));
end
