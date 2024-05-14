image = imread('cameraman.tif');
subplot(1, 2, 1);
imshow(image);
title("Original Image");

image = double(image);
Mx = [0, 1;
     -1, 0];

My = [1, 0;
     0, -1];


[m, n] = size(image);
th = 10;
filtered_image = zeros(m, n);
for i = 1 : m-1
    for j = 1 : n-1
        Gx = sum(sum(Mx.*image(i:i+1, j:j+1)));
        Gy = sum(sum(My.*image(i:i+1, j:j+1)));
        filtered_image(i, j) = sqrt(Gx.^2 + Gy.^2);
    end
end
filtered_image = uint8(filtered_image);
edgeDetectedImage(edgeDetectedImage <= th) = 0;
subplot(1, 2, 2);
imshow(edgeDetectedImage);
title("Edge Detected Image using Robert Operator");