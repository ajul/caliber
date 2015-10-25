function [ imagePoints ] = cameraIntrinsics( K, distortedPoints, derivType, dValue )
%PIXELSIZE Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 3
        derivType = 0;
    end
    
    n = size(distortedPoints, 2);
    
    switch(derivType)
        case 0
            imagePoints = K * [distortedPoints; ones(1, n)];
        case 1
            imagePoints = dValue * [distortedPoints; ones(1, n)];
        case 2
            % the principal point is fixed and does not contribute to
            % derivative
            imagePoints = K(1:2, 1:2) * dValue;
    end
    
    imagePoints = imagePoints(1:2, :);
    
end
