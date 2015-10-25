function [ unitPlanePoints ] = normalizedProjection( M, worldPoints, derivType, dValue )
%NORMALIZEDPROJECTION Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 3
        derivType = 0;
    end
    
    n = size(worldPoints, 2);
    cameraPoints = M * [worldPoints; ones(1, n)];
    cameraPoints = cameraPoints(1:3, :);
    
    switch(derivType)
        case 0
            unitPlanePoints = [cameraPoints(1, :) ./ cameraPoints(3, :);...
                cameraPoints(2, :) ./ cameraPoints(3, :)];
        case 1
            dcameraPoints = dValue * [worldPoints; ones(1, n)];
            dcameraPoints = dcameraPoints(1:3, :);
            
            zsq = cameraPoints(3, :) .* cameraPoints(3, :);
            unitPlanePoints = [dcameraPoints(1, :) ./ cameraPoints(3, :);...
                dcameraPoints(2, :) ./ cameraPoints(3, :)] -...
                [cameraPoints(1, :) .* dcameraPoints(3, :) ./ zsq;...
                cameraPoints(2, :) .* dcameraPoints(3, :) ./ zsq];
        case 2
            dcameraPoints = M(1:3, 1:3) * dValue;
            
            zsq = cameraPoints(3, :) .* cameraPoints(3, :);
            unitPlanePoints = [dcameraPoints(1, :) ./ cameraPoints(3, :);...
                dcameraPoints(2, :) ./ cameraPoints(3, :)] -...
                [cameraPoints(1, :) .* dcameraPoints(3, :) ./ zsq;...
                cameraPoints(2, :) .* dcameraPoints(3, :) ./ zsq];
    end
end
