image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

subplot(2, 2, 1);
imshow(image);
title('Original Image');
image = im2double(image);

[m, n] = size(image);

D0 = 100; %cut off distance

fft_image = fft2(image); %fft of the input image
image_shifted = fftshift(fft_image); %shifting to center
subplot(2, 2, 2);
imshow(uint8(abs(image_shifted)));
title('Input image FT after shifting');

image_low_passed = zeros(m, n);
D = zeros(m, n);
filt = zeros(m, n);
for u = 1 : m
    for v = 1 : n
        D(u, v) = sqrt((u - m/2)^2 + (v - n/2)^2);
        if D(u, v) <= D0
            image_low_passed(u, v) = image_shifted(u, v);
            filt(u, v) = 1;
        else
            image_low_passed(u, v) = 0;
            filt(u, v) = 0;
        end
    end
end

subplot(2, 2, 3);
imshow(filt); %ideal low pass filter
title('Ideal Low Pass Filter');

output_image_shift = fftshift(image_low_passed);
output_image_inverse = ifft2(output_image_shift);
output_image = abs(output_image_inverse);
subplot(2, 2, 4);
imshow((output_image));
title('Low Pass Filtered Image');