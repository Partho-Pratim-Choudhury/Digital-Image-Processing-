% Without using user defined queue data structure

matrix = [0, 1, 2, 0;
          2, 5, 6, 1;
          1, 4, 7, 3;
          6, 2, 5, 1];
disp(matrix);

T = 2;

sx = 3;
sy = 3;

[m, n] = size(matrix);
visited = zeros(m, n);
output = zeros(m, n);

queue = [sx, sy];
while ~isempty(queue)
    x = queue(1, 1);
    y = queue(1, 2);
    queue(1, :) = [];
    
    if x >= 1 && x <= m && y >= 1 && y <= n && visited(x, y) == 0
        visited(x, y) = 1;
        if(x - 1 >= 1 && abs(matrix(x-1, y) - matrix(sx, sy)) <= T)
            output(x-1, y) = 1;
            queue = [queue; x-1, y];
        end
        if(y + 1 <= n && abs(matrix(x, y+1) - matrix(sx, sy)) <= T)
            output(x, y+1) = 1;
            queue = [queue; x, y+1];
        end
        if(x + 1 <= m && abs(matrix(x+1, y) - matrix(sx, sy)) <= T)
            output(x+1, y) = 1;
            queue = [queue; x+1, y];
        end
        if(y - 1 >= 1 && abs(matrix(x, y-1) - matrix(sx, sy)) <= T)
            output(x, y-1) = 1;
            queue = [queue; x, y-1];
        end
    end
end

disp(output);
