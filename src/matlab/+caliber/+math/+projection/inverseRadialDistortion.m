function [ unitPlanePoints ] = inverseRadialDistortion( kc, distortedPoints, derivType, dValue )
%RADIALDISTORTION Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 3
        derivType = 0;
    end
    
    n = size(distortedPoints, 2);
    
    
    switch(derivType)
        case 0
            unitPlanePoints = zeros(2, n);
            for i = 1:n
                distortedPoint = distortedPoints(:, i);
                opts = optimset('Display', 'off');
                unitPlanePoints(:, i) = lsqnonlin(makefn0(kc, distortedPoint), distortedPoint, [], [], opts);
            end
        case 1
            error('caliber:math:projection', 'Not implemented');
        case 2
            error('caliber:math:projection', 'Not implemented');
    end
end

function result = makefn0(kc, distortedPoint)
    function error = resultfn(unitPlanePoint)
        error = caliber.math.projection.radialDistortion(kc, unitPlanePoint) - distortedPoint;
    end

    result = @resultfn;
end
