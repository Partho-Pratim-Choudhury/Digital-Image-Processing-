classdef QueueFIFO < handle
    properties
        queue
        maxSize
    end
    
    methods
        function obj = QueueFIFO(maxSize)
            obj.queue = {};
            obj.maxSize = maxSize;
        end
        
        function enqueue(obj, item)
            if length(obj.queue) >= obj.maxSize
                error('Queue is full');
            end
            obj.queue{end+1} = item;
        end
        
        function item = dequeue(obj)
            if isempty(obj.queue)
                error('Queue is empty');
            end
            item = obj.queue{1};
            obj.queue(1) = [];
        end
        
        function isEmpty = isEmpty(obj)
            isEmpty = isempty(obj.queue);
        end
    end
end