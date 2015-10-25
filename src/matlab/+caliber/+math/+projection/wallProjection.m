function [ result ] = wallProjection( M, unitPlanePoints, derivType, dValue )
%WALLPROJECTION Given a "wall" defined by M, projects points on the unit
%plane onto that wall.
    if nargin < 3
        derivType = 0;
    end
    
    n = size(unitPlanePoints, 2);
    
    unitPlanePoints = [unitPlanePoints; ones(1, n)];
    H = M(1:3, [1 2 4]);
    wallPlanePoints = H \ unitPlanePoints;
    
    switch(derivType)
        case 0
            result = [wallPlanePoints(1, :) ./ wallPlanePoints(3, :); wallPlanePoints(2, :) ./ wallPlanePoints(3, :); zeros(1, n)];
        case 1
            dH = dValue(1:3, [1 2 4]);
            dWallPlanePoints = - (H \ dH) * (H \ unitPlanePoints);
            w2 = wallPlanePoints(3, :) .* wallPlanePoints(3, :);
            result = [(dWallPlanePoints(1, :) .* wallPlanePoints(3, :) - wallPlanePoints(1, :) .* dWallPlanePoints(3, :))./ w2;...
                (dWallPlanePoints(2, :) .* wallPlanePoints(3, :) -  wallPlanePoints(2, :) .* dWallPlanePoints(3, :))./ w2;...
                zeros(1, n)];
        case 2
            dValue = [dValue; zeros(1, n)];
            dWallPlanePoints = H \ dValue;
            w2 = wallPlanePoints(3, :) .* wallPlanePoints(3, :);
            result = [(dWallPlanePoints(1, :) .* wallPlanePoints(3, :) -  wallPlanePoints(1, :) .* dWallPlanePoints(3, :))./ w2;...
                (dWallPlanePoints(2, :) .* wallPlanePoints(3, :) -  wallPlanePoints(2, :) .* dWallPlanePoints(3, :))./ w2;...
                zeros(1, n)];
    end
end

