matrix = imread('cameraman.jpg');
if size(matrix, 3) == 3
    matrix = rgb2gray(matrix);
end
sgtitle('2112003', 'FontSize', 13);
matrix = uint8(matrix);
matrix(matrix > 255) = 255;
matrix(matrix < 0) = 0;
final = zeros(size(matrix));
vis = zeros(size(matrix));
T = 210;
mx = 0;
for i = 1 : size(matrix, 1)
    for j = 1 : size(matrix, 2)
        mx = max(mx, matrix(i, j));
    end
end
if(mx > 255)
    mx = 255;
end
queue = QueueFIFO(10000);
for i = 1 : size(matrix, 1)
    for j = 1 : size(matrix, 2)
        if matrix(i, j) == mx
               queue.enqueue([i, j]);
               vis(i, j) = 1;
        end
    end
end
while ~queue.isEmpty()
    node = queue.dequeue();
    i = node(1);
    j = node(2);
    % left
    if j-1 > 0 && vis(i, j-1) == 0 && abs(mx - matrix(i, j-1)) <= T
        vis(i, j-1) = 1;
        queue.enqueue([i, j-1]);
    end
    % right
    if j+1 <= size(matrix, 2) && vis(i, j+1) == 0 && abs(mx - matrix(i, j+1)) <= T
        vis(i, j+1) = 1;
        queue.enqueue([i, j+1]);
    end
    % up
    if i-1 > 0 && vis(i-1, j) == 0 && abs(mx - matrix(i-1, j)) <= T
        vis(i-1, j) = 1;
        queue.enqueue([i-1, j]);
    end
    %down
    if i+1 <= size(matrix, 1) && vis(i+1, j) == 0 && abs(mx - matrix(i+1, j)) <= T
        vis(i+1, j) = 1;
        queue.enqueue([i+1, j]);
    end
end
for i = 1 : size(matrix, 1)
    for j = 1 : size(matrix, 2)
        if vis(i, j) == 1
            final(i, j) = 1;
        end
    end
end
subplot(2,2,1);
imshow(matrix);
subplot(2,2,2);
histogram(matrix);
subplot(2,2,3);
imshow(final);
subplot(2,2,4);
histogram(final);