input_image = imread('cameraman.tif');
if size(input_image,3) == 3
    input_image = rgb2gray(input_image);
end
input_image = uint8(input_image);
image = double(input_image);

T = 250;
delta = 0.001;

while true
    G1 = image(image > T);
    G2 = image(image <= T);

    m1 = mean(G1);
    m2 = mean(G2);

    new_T = (m1 + m2) / 2;

    if abs(new_T - T) < delta
        break;
    end

    T = new_T;
end

bw = zeros(size(image));
bw(image > T) = 1;

figure;
subplot(1, 2, 1);
imshow(uint8(image));
title('Original Image');

subplot(1, 2, 2);
imshow(bw);
title('Thresholded Image');
