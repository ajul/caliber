function [ rSq, rmsError, meanError, medianError, minError, maxError ] = errorStats( estimated, actual )
%ERRORSTATS Summary of this function goes here
%   Detailed explanation goes here
    if nargin == 2
        errors = estimated - actual;
    else
        errors = estimated;
    end
    errors = reshape(errors, 1, []);
    rSq = sum(errors.*errors);
    rmsError = sqrt(mean(errors.*errors));
    meanError = mean(abs(errors));
    medianError = median(abs(errors));
    minError = min(abs(errors));
    maxError = max(abs(errors));
end
