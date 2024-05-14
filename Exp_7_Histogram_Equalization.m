image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

[m, n] = size(image);

histogramEqualizedImage = histogramEqualization(image);

subplot(2, 2, 1);
imshow(image);
title('Original Image');

subplot(2, 2, 2);
imhist(image);
title('Histogram of Original Image');
xlabel('gray level');
ylabel('frequency');

subplot(2, 2, 3);
imshow(histogramEqualizedImage);
title('Histogram Equalized Image');

subplot(2, 2, 4);
imhist(histogramEqualizedImage);
title('Histogram of Histogram Equalized Image');
xlabel('gray level');
ylabel('frequency');


function histogramEqualizedImage = histogramEqualization(image)
    [m, n] = size(image);

    frequency = zeros(256, 1);
    for i = 0 : 255
        frequency(i+1) = sum(image(:) == i);
    end

    cdf = zeros(256, 1);
    for i = 2 : 256
        cdf(i) = cdf(i-1) + frequency(i);
    end
    cdf = cdf / (m * n);

    histogramEqualizedImage = zeros(m, n);
    for i = 1 : m 
        for j = 1 : n
            intensity = image(i, j) + 1;
            histogramEqualizedImage(i, j) = (255 * cdf(intensity));
        end
    end

    histogramEqualizedImage(histogramEqualizedImage < 0) = 0;
    histogramEqualizedImage(histogramEqualizedImage > 255) = 255;
    histogramEqualizedImage = uint8(histogramEqualizedImage);

end