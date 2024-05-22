% Define the directory containing the images
directory = '../../results/Ejecucion_todas';
numeroCentros = 3;

% Obtener todos los archivos (imagenes) del directorio
files = dir(fullfile(directory, '*.*'));
files = files(~ismember({files.name}, {'.', '..'}));

data_struct = struct();
original_names = {};

% Por cada archivo
for i = 1:length(files)
    filename = files(i).name;
    
    % Si el nombre del archivo coincide con el patron de original
    original_pattern = '2_(?<name>.+)_Original_(?<algorithm>K-Means|C-Means|GMM|Spatial)_(?<nCenters>\d+)_c_(?<percentage>\d+\.\d+)%';
    original_tokens = regexp(filename, original_pattern, 'names');
    
    if ~isempty(original_tokens) && str2double(original_tokens.nCenters) == numeroCentros
        % Obtener datos del nombre
        img_name = matlab.lang.makeValidName(original_tokens.name);
        algorithm = matlab.lang.makeValidName([original_tokens.algorithm, '_Orig']);
        percentage = str2double(original_tokens.percentage);
        
        % Guardar el nombre de la imagen
        if ~isfield(data_struct, img_name)
            data_struct.(img_name) = struct();
            original_names{end+1} = original_tokens.name;
        end
        data_struct.(img_name).(algorithm) = percentage;
        continue;
    end
    
    % Si el nombre del archivo coincide con el patron de invariante
    invariant_pattern = '3_(?<name>.+)_(?<invariant>Alvarez|Maddern|Krajnık|Upcrof|PCA)_(?<algorithm>K-Means|C-Means|GMM|Spatial)_(?<nCenters>\d+)_c_(?<percentage>\d+\.\d+)%';
    invariant_tokens = regexp(filename, invariant_pattern, 'names');
    
    if ~isempty(invariant_tokens) && str2double(invariant_tokens.nCenters) == numeroCentros
        % Obtener datos del nombre
        img_name = matlab.lang.makeValidName(invariant_tokens.name);
        invariant = invariant_tokens.invariant;
        algorithm = matlab.lang.makeValidName([invariant_tokens.algorithm, '_', invariant]);
        percentage = str2double(invariant_tokens.percentage);
        
        % Guardar el nombre de la imagen
        if ~isfield(data_struct, img_name)
            data_struct.(img_name) = struct();
            original_names{end+1} = invariant_tokens.name;
        end
        data_struct.(img_name).(algorithm) = percentage;
    end
end

% Declaracion de los encabezados de las columnas
headers = {'K-Means_Orig', 'C-Means_Orig', 'GMM_Orig', 'Spatial_Orig', 'K-Means_Alvarez', 'C-Means_Alvarez', 'GMM_Alvarez', 'Spatial_Alvarez', ...
           'K-Means_Maddern', 'C-Means_Maddern', 'GMM_Maddern', 'Spatial_Maddern', 'K-Means_Krajnık', 'C-Means_Krajnık', 'GMM_Krajnık', 'Spatial_Krajnık', ...
           'K-Means_Upcrof', 'C-Means_Upcrof', 'GMM_Upcrof', 'Spatial_Upcrof', 'K-Means_PCA', 'C-Means_PCA', 'GMM_PCA', 'Spatial_PCA'};

full_headers = {'Original', 'Original', 'Original', 'Original', 'Alvarez', 'Alvarez', 'Alvarez', 'Alvarez', ...
                'Maddern', 'Maddern', 'Maddern', 'Maddern', 'Krajnık', 'Krajnık', 'Krajnık', 'Krajnık', ...
                'Upcrof', 'Upcrof', 'Upcrof', 'Upcrof', 'PCA', 'PCA', 'PCA', 'PCA'};

% Crear el array de celdas para los datos, y un campo para los nombres
image_names = fieldnames(data_struct);
data = cell(length(image_names), length(headers));

% Rellenar el array de celdas
for i = 1:length(image_names)
    img_name = image_names{i};
    for j = 1:length(headers)
        sanitized_header = matlab.lang.makeValidName(headers{j});
        if isfield(data_struct.(img_name), sanitized_header)
            data{i, j} = data_struct.(img_name).(sanitized_header);
        else
            data{i, j} = [];
        end
    end
end

% Lo pasa a formato tabla
T = cell2table(data, 'VariableNames', headers);

% Filas (nombres de imagen)
T.Properties.RowNames = original_names;

% Columnas (encabezados)
T.Properties.VariableDescriptions = full_headers;

% Muestra la tabla
disp(T);

% Guardar el fichero Excel
output_file = ['../../results/image_percentages_' num2str(numeroCentros) 'centros.xlsx'];
writetable(T, output_file, 'WriteRowNames', true);

disp(['Guardado en: ', output_file]);