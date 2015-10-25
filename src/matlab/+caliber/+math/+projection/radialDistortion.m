function [ distortedPoints ] = radialDistortion( kc, unitPlanePoints, derivType, dValue )
%RADIALDISTORTION Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 3
        derivType = 0;
    end
    
    n = size(unitPlanePoints, 2);
    numCoeff = numel(kc);
    r2 = sum(unitPlanePoints .* unitPlanePoints, 1);
    
    switch(derivType)
        case 0
            L = ones(1, n);
            rPow = ones(1, n);
            for i = 1:numCoeff
                rPow = rPow .* r2;
                L = L + kc(i) * rPow;
            end
            distortedPoints = unitPlanePoints .* (ones(2, 1) * L);
        case 1
            rPow = ones(1, n);
            L = zeros(1, n);
            for i = 1:numCoeff
                rPow = rPow .* r2;
                L = L + dValue(i) * rPow;
            end
            distortedPoints = unitPlanePoints .* (ones(2, 1) * L);
        case 2
            dr2 = 2 * sum(unitPlanePoints .* dValue, 1);
            L = ones(1, n);
            dL = zeros(1, n);
            rPow = ones(1, n);
            for i = 1:numCoeff
                dL = dL + kc(i) * i * (rPow .* dr2);
                rPow = rPow .* r2;
                L = L + kc(i) * rPow;
            end
            distortedPoints = unitPlanePoints .* (ones(2, 1) * dL)...
                + dValue .* (ones(2, 1) * L);
    end
end

