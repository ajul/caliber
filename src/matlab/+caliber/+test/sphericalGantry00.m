function [tree, initializer, optimizer] = sphericalGantry00(synSigma, doLoocv)
if nargin < 2
    doLoocv = 0;
end

if nargin < 1
    synSigma = 0;
end

baseAngles = [0; 60; 120; 180; 240; 300] * pi / 180;
armAngles = [-60; -30; 30; 60] * pi / 180;
imageStates = [reshape(ones(4, 1) * (1:6), [], 1), reshape((1:4)' * ones(1, 6), [], 1), [zeros(8, 1); ones(16, 1)]];

% initOpt = caliber.sphericalGantryPredict('data/spherical_00/results_no_rect.mat', baseAngles, armAngles, imageStates);
% 
% fprintf('Observation pixel error stats:\n');
% obsErrors = initOpt.optimizer.computeErrors();
% [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( obsErrors )
% 
% fprintf('Prediction pixel error stats:\n');
% predictErrors = initOpt.optimizer.computeErrors(1);
% [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( predictErrors )

[tree, initializer, optimizer] =  caliber.special.sphericalGantry('data/spherical_00/Calib_Results.mat', baseAngles, armAngles, imageStates, doLoocv);

if synSigma > 0
    synOpt = optimizer.makeSynthetic(synSigma);
    synOpt.loocv();
end