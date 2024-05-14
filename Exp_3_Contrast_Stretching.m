image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

[m, n] = size(image);
subplot(2, 2, 1);
imshow(image);
title('Original Image');

limits = [15, 100; 50, 150; 150, 200];

for i = 1 : size(limits, 1)
    lowerLimit = limits(i, 1);
    upperLimit = limits(i, 2);
    stretchedImage = contrastStretching(lowerLimit, upperLimit, image);
    subplot(2, 2, i+1);
    imshow(stretchedImage);
    title(sprintf('Lower Limit %d, UpperLime %d', lowerLimit, upperLimit));
end

function stretchedImage = contrastStretching(lowerLimit, upperLimit, image)
    grayImage = double(image);
    rmin = min(min(grayImage));
    rmax = max(max(grayImage));
    [m, n] = size(grayImage);
    stretchedImage = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            r = grayImage(i, j);
            stretchedImage(i, j) = ((upperLimit - lowerLimit) * (r - rmin)) / (rmax - rmin) + lowerLimit;
        end
    end
    stretchedImage(stretchedImage < 0) = 0;
    stretchedImage(stretchedImage > 255) = 255;
    stretchedImage = uint8(stretchedImage);
end