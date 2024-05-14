rgbImage = imread('cocacola_color_img.jpg');
figure;
subplot(2, 3, 1);
imshow(rgbImage);
title('Original RGB Image');

redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

redThreshold = adaptthresh(redChannel, 0.5, 'NeighborhoodSize', 25);
greenThreshold = adaptthresh(greenChannel, 0.5, 'NeighborhoodSize', 25);
blueThreshold = adaptthresh(blueChannel, 0.5, 'NeighborhoodSize', 25);

redBinary = imbinarize(redChannel, redThreshold);
greenBinary = imbinarize(greenChannel, greenThreshold);
blueBinary = imbinarize(blueChannel, blueThreshold);

subplot(2, 3, 2);
imshow(redBinary);
title('Local Threshold Red Channel');
subplot(2, 3, 3);
imshow(greenBinary);
title('Local Threshold Green Channel');
subplot(2, 3, 4);
imshow(blueBinary);
title('Local Threshold Blue Channel');

redBinary = uint8(redBinary) * 255;
greenBinary = uint8(greenBinary) * 255;
blueBinary = uint8(blueBinary) * 255;

thresholdedRGB = cat(3, redBinary, greenBinary, blueBinary);
subplot(2, 3, 5);
imshow(thresholdedRGB);
title('Local Thresholding in all channels');
