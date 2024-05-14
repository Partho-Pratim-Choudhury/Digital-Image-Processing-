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

D0l = 80;
D0h = 10;
D = zeros(m, n);
filtl = zeros(m, n);
filth = zeros(m, n);

for u = 1 : m
    for v = 1 : n
        D(u, v) = sqrt((u - m/2)^2 + (v - n/2)^2);
        if D(u, v) <= D0l
            filtl(u, v) = 1;
        else
            filtl(u, v) = 0;
        end
        if D(u, v) > D0h
            filth(u, v) = 1;
        else
            filth(u, v) = 0;
        end
    end
end

filt = filtl.*filth;
subplot(2, 2, 3);
imshow(filt);
title('Ideal Band Pass Filter');

high_passed_image = filt.*fft_image_shifted;
output_image_shift = fftshift(high_passed_image);
output_image_inverse = ifft2(output_image_shift);
output_image = abs(output_image_inverse);

subplot(2, 2, 4);
imshow(output_image);
title("Band Pass Filtered Image");