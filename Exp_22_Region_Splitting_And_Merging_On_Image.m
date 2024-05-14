matrix = imread('cameraman.jpg');
if size(matrix, 3) == 3
    matrix = rgb2gray(matrix);
end
sgtitle('2112003', 'FontSize', 13);
matrix = uint8(matrix);
T = 145;
queue = QueueFIFO(1000000);
queue.enqueue([1; 1; size(matrix, 1)]);
region = [];
while ~queue.isEmpty()
    cur = queue.dequeue();
    i = cur(1);
    j = cur(2);
    window_size = cur(3);
    mx = max(max(matrix(i : i + window_size - 1, j : j + window_size - 1)));
    mn = min(min(matrix(i : i + window_size - 1, j : j + window_size - 1)));
    if mx - mn <= T
        region = [region; [cur(1), cur(2), cur(3)]];
    else
        new_window_size = window_size / 2;
        while i < cur(1) + window_size
            j = cur(2);
            while j < cur(2) + window_size
                item = [i; j; new_window_size];
                queue.enqueue(item); 
                j = j + new_window_size;
            end
            i = i + new_window_size;
        end
    end
end
mpCell = zeros(size(matrix));
for i = 1 : size(region, 1)
    row_start = region(i, 1);
    col_start = region(i, 2);
    region_size = region(i, 3);
    for j = row_start : row_start + region_size - 1
        for k = col_start : col_start + region_size - 1
            mpCell(j, k) = i;
        end
    end
end
maxArray = zeros(1, size(region, 1));
minArray = zeros(1, size(region, 1));
for i = 1 : size(region, 1)
    row_start = region(i, 1);
    col_start = region(i, 2);
    region_size = region(i, 3);
    mx = max(max(matrix(row_start : row_start + region_size - 1, col_start : col_start + region_size - 1)));
    mn = min(min(matrix(row_start : row_start + region_size - 1, col_start : col_start + region_size - 1)));
    maxArray(i) = mx;
    minArray(i) = mn;
end
final = zeros(size(matrix));
vis = zeros(size(matrix));
for k = 1 : size(region, 1)
    i = region(k, 1);
    j = region(k, 2);
    if vis(i, j) == 1
        continue;
    end
    vis(i, j) = 1;
    rg = mpCell(i, j);
    x = i;
    y = j;
    q2 = QueueFIFO(10000000);
    q2.enqueue([i, j]);
    while ~q2.isEmpty()
        node = q2.dequeue();
        i = node(1);
        j = node(2);
        R1 = mpCell(i, j);
        mpCell(i, j) = rg;
        mx1 = maxArray(R1);
        mn1 = minArray(R1);
        % left
        if j - 1 > 0 && vis(i, j-1) == 0
            R2 = mpCell(i, j-1);
            mx2 = maxArray(R2);
            mn2 = minArray(R2);
            if all([abs(mx1 - mn2) <= T, abs(mx2-mn1) <= T]) 
                maxArray(R1) = max(mx1, mx2);
                maxArray(R2) = max(mx1, mx2);
                minArray(R2) = min(mn1, mn2);
                minArray(R1) = min(mn1, mn2);
                vis(i, j-1) = 1;
                q2.enqueue([i; j-1]);
            end
        end
        % right
        mx1 = maxArray(R1);
        mn1 = minArray(R1);
        if j +1  <= size(matrix, 2) && vis(i, j+1) == 0
            R2 = mpCell(i, j+1);
            mx2 = maxArray(R2);
            mn2 = minArray(R2);
            if all([abs(mx1 - mn2) <= T, abs(mx2-mn1) <= T]) 
                maxArray(R1) = max(mx1, mx2);
                maxArray(R2) = max(mx1, mx2);
                minArray(R2) = min(mn1, mn2);
                minArray(R1) = min(mn1, mn2);
                vis(i, j+1) = 1;
                q2.enqueue([i; j+1]);
            end
        end
        % up
        mx1 = maxArray(R1);
        mn1 = minArray(R1);
        if i - 1 > 0 && vis(i-1, j) == 0
            R2 = mpCell(i-1, j);
            mx2 = maxArray(R2);
            mn2 = minArray(R2);
            if all([abs(mx1 - mn2) <= T, abs(mx2-mn1) <= T]) 
                maxArray(R1) = max(mx1, mx2);
                maxArray(R2) = max(mx1, mx2);
                minArray(R2) = min(mn1, mn2);
                minArray(R1) = min(mn1, mn2);
                vis(i-1, j) = 1;
                q2.enqueue([i-1; j]);
            end
        end
        % down
        mx1 = maxArray(R1);
        mn1 = minArray(R1);
        if i +1 <= size(matrix, 1) && vis(i+1, j) == 0
            R2 = mpCell(i +1 , j);
            mx2 = maxArray(R2);
            mn2 = minArray(R2);
            if all([abs(mx1 - mn2) <= T, abs(mx2-mn1) <= T]) 
                maxArray(R1) = max(mx1, mx2);
                maxArray(R2) = max(mx1, mx2);
                minArray(R2) = min(mn1, mn2);
                minArray(R1) = min(mn1, mn2);
                vis(i+1, j) = 1;
                q2.enqueue([i+1; j]);
            end
        end
    end
end
for i = 1 : size(matrix, 1)
    for j = 1 : size(matrix, 2)
        final(i, j) = minArray(mpCell(i, j));
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