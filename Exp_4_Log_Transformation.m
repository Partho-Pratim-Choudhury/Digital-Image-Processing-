image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

[m, n] = size(image);
subplot(2, 2, 1);
imshow(image);
title('Original Image');

function logTransformedImage = logTransformation(c, image)
    grayImage = double(image);
    [m, n] = size(grayImage);
    logTransformedImage = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            r = grayImage(i, j);
            logTransformedImage(i, j) = c * log(1 + r);
        end
    end
    logTransformedImage(logTransformedImage < 0) = 0;
    logTransformedImage(logTransformedImage > 255) = 255;

    logTransformedImage = uint8(logTransformedImage);
end

c = [10; 20; 30];

for i = 1 : size(c, 1)
    logTransformedImage = logTransformation(c(i), image);
    subplot(2, 2, i+1);
    imshow(logTransformedImage);
    title(sprintf('c = %d', c(i)));
end