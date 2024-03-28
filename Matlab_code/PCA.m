function [imagenFinal] = PCA(image)
%PCA Summary of this function goes here
%   Detailed explanation goes here
    image = image + 1;
    [h, w, ~] = size(image);
    sample_size = ceil(h * w / 100);
    sampled_pixels = zeros(3, sample_size);

    % random pixel sampling : 1%
    for z = 1:sample_size
        x = randi(w);   y = randi(h);
        sampled_pixels(:, z) = reshape(image(y, x, :), [3 1]);
    end
    
    img_R = sampled_pixels(1, :);
    img_G = sampled_pixels(2, :);
    img_B = sampled_pixels(3, :);

    geoM = (img_R .* img_G .* img_B).^(1/3);

    % RG BG chromaticity
    x1 = log(img_R ./ geoM); % R/G
    x2 = log(img_B ./ geoM); % B/G
    
    % calculate pca
    X = [x1; x2]';
    [~, ~, V] = svd(X, 'econ');
    alpha = abs(atand(-V(1) / V(2)));
    
    % generate pca_ii image
    img_R = double(image(:,:,1));
    img_G = double(image(:,:,2));
    img_B = double(image(:,:,3));

    geoM = (img_R .* img_G .* img_B).^(1/3);

    ch_r = log(img_R ./ geoM);
    ch_b = log(img_B ./ geoM);
    rad_t = pi * (alpha-1) / 180;
    grayImg = ch_r * cos(rad_t) + ch_b * sin(rad_t);
    
    % normalize
    tmp = grayImg;
    tmp = tmp - min(min(tmp));
    imagenFinal = tmp / max(max(tmp));
end

