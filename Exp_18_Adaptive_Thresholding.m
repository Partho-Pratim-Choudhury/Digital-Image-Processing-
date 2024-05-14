input_image = imread('cameraman.tif');
image = double(input_image);
window_size = 350;
segmented_image = zeros(size(image));
for i = 1 : size(image, 1)
    for j = 1 : size(image, 2)
        row_start = max(1, i - floor(window_size / 2));
        row_end = min(size(image, 1) , i + floor(window_size / 2));
        col_start = max(1, j - floor(window_size / 2));
        col_end = min(size(image, 2), j + floor(window_size / 2));
        local_region = image(row_start : row_end, col_start : col_end);
        local_threshold = mean(mean(local_region(:)));
        if(image(i, j) > local_threshold)
            segmented_image(i, j) = 1;
        end
    end
end

subplot(1, 2, 1);
imshow(input_image);
title('Original image');

subplot(1, 2, 2);
imshow(segmented_image);
title('Adaptive Thresholding Image');
