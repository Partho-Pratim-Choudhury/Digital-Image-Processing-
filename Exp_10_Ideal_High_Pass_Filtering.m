image = imread("cameraman.tif");
subplot(2, 2, 1);
imshow(image);
title("Original Image");

image = im2double(image);

fft_image = fft2(image);
fft_image_shifted = fftshift(fft_image);
subplot(2, 2, 2);
imshow(uint8(abs(fft_image_shifted)));
title("Input Image FT after shfiting");

[m, n] = size(image);

D0 = 30;
D = zeros(m, n);
filt = zeros(m, n);
high_passed_image = zeros(m, n);

for u = 1 : m
    for v = 1 : n
        D(u, v) = sqrt((u - m/2)^2 + (v - n/2)^2);
        if D(u, v) <= D0
            high_passed_image(u, v) = 0;
            filt(u, v) = 0;
        else
            high_passed_image(u, v) = fft_image_shifted(u, v);
            filt(u, v) = 1;
        end
    end
end

subplot(2, 2, 3);
imshow(filt);
title('Ideal High Pass Filter');

output_image_shift = fftshift(high_passed_image);
output_image_inverse = ifft2(output_image_shift);
output_image = abs(output_image_inverse);

subplot(2, 2, 4);
imshow(output_image);
title("High Pass Filtered Image");