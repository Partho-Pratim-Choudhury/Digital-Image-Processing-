image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

[m, n] = size(image);
subplot(2, 2, 1);
imshow(image);
title('Original Image');

function powerTransformedImage = powerTransformation(gamma, image)
    grayImage = double(image);
    [m, n] = size(grayImage);
    powerTransformedImage = zeros(m, n);
    for i = 1 : m 
        for j = 1 : n
            powerTransformedImage(i, j) = 255*(grayImage(i, j)/255)^gamma;
        end
    end
    powerTransformedImage(powerTransformedImage < 0) = 0;
    powerTransformedImage(powerTransformedImage > 255) = 255;
    powerTransformedImage = uint8(powerTransformedImage);
end

gamma = [0.5; 1; 3];

for i = 1 : size(gamma, 1)
    powerTransformedImage = powerTransformation(gamma(i), image);
    subplot(2, 2, i+1);
    imshow(powerTransformedImage);
    title(sprintf('gamma = %d', gamma(i)));
end