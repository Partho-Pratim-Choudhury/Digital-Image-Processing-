image = imread("cameraman.tif");

subplot(2, 3, 1);
imshow(image);
title("Original Image");

image = im2double(image);

fft_image = fft2(image);
fft_image_shifted = fftshift(fft_image);

subplot(2, 3, 2);
imshow(uint8(abs(fft_image_shifted)));
title("FFT of input image");

[m, n] = size(image);
filter = zeros(m, n);
H = zeros(m, n);
D = zeros(m, n);
D0 = 80;

for u = 1 : m
    for v = 1 : n
        D(u, v) = sqrt((u - m/2)^2 + (v - n/2)^2);
        H(u, v) = exp((-D(u, v)^2) / (2*(D0^2)));
    end
end

subplot(2, 3, 3);
imshow(H);
title(sprintf("Low Pass Gaussian Filter : D0 = %d", D0));

low_passed_image = H.*fft_image_shifted;

output_image_shifted = fftshift(low_passed_image);
output_image_inverse = ifft2(output_image_shifted);
output_image_filtered = abs(output_image_inverse);

subplot(2, 3, 4);
imshow(output_image_filtered);
title("Guassian Filtered Image");


L  = [0, 1, 0;
     1, -4, 1;
     0, 1, 0];

output_image = zeros(m, n);
for i = 1 : m-2
    for j = 1 : n-2
        output_image(i, j) = sum(sum(L.*output_image_filtered(i:i+2, j:j+2)));
    end
end


subplot(2, 3, 5);
imshow(output_image);
title("Laplacian of Gaussian Filtered Image");
