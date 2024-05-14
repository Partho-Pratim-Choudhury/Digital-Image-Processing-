image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

[m, n] = size(image);

binaryImage = zeros(m, n);

threshold = [32, 64, 128];

subplot(2, 2, 1);
imshow(image);
title('Original Image');


for k = 1 : 3
    curThreshold = threshold(k);
    for i = 1 : m
        for j = 1 : n
            if image(i, j) > curThreshold
                binaryImage(i, j) = 1;
            else
                binaryImage(i, j) = 0;
            end
        end
    end
    subplot(2, 2, k+1);
    imshow(binaryImage);
    title(sprintf('Binary Image - Threshold = %d', threshold(k)));
end