image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

[m, n] = size(image);

negativeImage = zeros(m, n);

for i = 1 : m
    for j = 1 : n
        negativeImage(i, j) = 255 - image(i, j);
    end
end

subplot(1, 2, 1);
imshow(image);
title('Orginal Image');

subplot(1, 2, 2);
imshow(uint8(negativeImage));
title('Negative Image');