image = imread("cameraman.tif");
subplot(2, 2, 1);
imshow(image);
title("Original Image");

image = im2double(image);
fft_image = fft2(image);
fft_image_shift = fftshift(fft_image);
subplot(2, 2, 2);
imshow(uint8(abs(fft_image_shift)));

[m, n] = size(image);
D0 = 20;
D = zeros(m, n);
H = zeros(m, n);

for u = 1 : m 
    for v = 1 : n
        D(u, v) = sqrt((u - m/2)^2 + (v - n/2)^2);
        H(u, v) = 1 - exp((-D(u, v)^2) / (2 * (D0^2)));
    end
end

subplot(2, 2, 3);
imshow(H);
title("Gaussian High Pass Filter");

image_low_passed = H.*fft_image_shift;

output_image_shift = fftshift(image_low_passed);
output_image_inverse = ifft2(output_image_shift);
output_image = abs(output_image_inverse);
subplot(2, 2, 4);
imshow(output_image);
title("Gaussian High Pass Filtered Image");