image = imread('gray_scale_img_1.jpeg');
if size(image, 3) == 3
    image = rgb2gray(image);
end

[m, n] = size(image);
subplot(2, 2, 1);
imshow(image);
title('Original Image');

subplot(2, 2, 2);
imhist(image);
title('Histogram for Original Image');
xlabel('gray level');
ylabel('frequency');

histogramStretchedImage = histogramStretching(image);

subplot(2, 2, 3);
imshow(histogramStretchedImage);
title('Histogram Stretched Image');

subplot(2, 2, 4);
imhist(histogramStretchedImage);
title('Histogram for Histogram Stretched Image');
xlabel('gray level');
ylabel('frequency');

function histogramStretchedImage = histogramStretching(image)
    grayImage = double(image);
    [m, n] = size(grayImage);
    histogramStretchedImage = zeros(m, n);

    rmin = min(grayImage);
    rmax = max(grayImage);
    for i = 1 : m 
        for j = 1 : n
            r = grayImage(i, j);
            histogramStretchedImage(i, j) = ((255 - 0) * (r - rmin)) / (rmax - rmin) + 0;
        end
    end
    histogramStretchedImage(histogramStretchedImage < 0) = 0;
    histogramStretchedImage(histogramStretchedImage > 255) = 255;
    histogramStretchedImage = uint8(histogramStretchedImage);
end