image = imread('gray_scale_img_1.jpeg');
minImage = minFiltering(image);
maxImage = maxFiltering(image);
avgImage = avgFiltering(image);
medianImage = medianFiltering(image);

subplot(2, 3, 1);
imshow(image);
title('Original Image');

subplot(2, 3, 2);
imshow(minImage);
title('Min Filtered Image');

subplot(2, 3, 3);
imshow(maxImage);
title('Max Filtered Image');

subplot(2, 3, 4);
imshow(avgImage);
title('Avg Filtered Image');

subplot(2, 3, 5);
imshow(medianImage);
title('Median Filtered Image');

function minImage = minFiltering(image)
    paddedImage = padarray(image, [2, 2], "replicate");
    [m, n] = size(image);
    minImage = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            neighbour = paddedImage(i:i+2*2, j:j+2*2);
            minImage(i,j) = min(neighbour(:));
        end
    end
    minImage = uint8(minImage);
end

function maxImage  = maxFiltering(image)
    paddedImage = padarray(image, [2, 2], "replicate");
    [m, n] = size(image);
    maxImage = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            neighbour = paddedImage(i:i+2*2, j:j+2*2);
            maxImage(i, j) = max(neighbour(:));
        end
    end
    maxImage = uint8(maxImage);
end

function avgImage  = avgFiltering(image)
    paddedImage = padarray(image, [2, 2], "replicate");
    [m, n] = size(image);
    avgImage = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            neighbour = paddedImage(i:i+2*2, j:j+2*2);
            avgImage(i, j) = mean(neighbour(:));
        end
    end
    avgImage = uint8(avgImage);
end

function medianImage  = medianFiltering(image)
    paddedImage = padarray(image, [2, 2], "replicate");
    [m, n] = size(image);
    medianImage = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            neighbour = paddedImage(i:i+2*2, j:j+2*2);
            medianImage(i, j) = median(neighbour(:));
        end
    end
    medianImage = uint8(medianImage);
end