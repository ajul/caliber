function plotImagePoints( varargin )
% plotImagePoints(...)
% plotImagePoints(..., filename)
% plots up to three sets of image points, expressed as 2xn arrays
% points corresponding to the same index are connected by a black line
% optional last argument saves the figure to a file and closes it
    colors = {'b', 'r', 'g'};
    markers = {'o', '+', 's'};
    n = -1;
    
    if isa(varargin{end}, 'char')
        numSets = length(varargin) - 1;
        doSave = 1;
    else
        numSets = length(varargin);
        doSave = 0;
    end
    
    for i=1:numSets
        varargin{i} = reshape(varargin{i}, 2, []);
        if n < 0 || size(varargin{i}, 2) > n
            n = size(varargin{i}, 2);
        end
    end

    lineX = [];
    lineY = [];
    for i=1:numSets
        data = varargin{i};
        lineX = [lineX; data(1, 1:n)];
        lineY = [lineY; data(2, 1:n)];
    end

    figure;
    axis equal;
    set(gca,'YDir','reverse')
    hold on;
    line(lineX, lineY, 'Color', 'k');
    for i=1:numSets
        data = varargin{i};
        scatter(data(1, :), data(2, :), colors{i}, markers{i});
    end
    hold off;
    
    if doSave
        saveas(gcf, varargin{end});
    end
end

