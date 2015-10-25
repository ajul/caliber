function [tree, initializer, optimizer] = stereo00(synSigma, doLoocv)

import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

if nargin < 2
    doLoocv = 0;
end

if nargin < 1
    synSigma = 0;
end

cameraDataFiles = {'data/stereo_03/c_results.mat', 'data/stereo_03/m_results.mat'};

% initOpt = caliber.fixedCameraSetPredict(cameraDataFiles, 2, 1);
% 
% fprintf('Observation pixel error stats:\n');
% obsErrors = initOpt.optimizer.computeErrors();
% [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( obsErrors )
% 
% fprintf('Prediction pixel error stats:\n');
% predictErrors = initOpt.optimizer.computeErrors(1);
% [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( predictErrors )

[tree, initializer, optimizer] = caliber.special.fixedCameraSet(cameraDataFiles, 1:12, doLoocv);

% allResiduals = [];
% for i = 1:length(residuals)
%     allResiduals = [allResiduals; residuals{i}];
% end

if synSigma > 0
    synOpt = optimizer.makeSynthetic(synSigma);
    synOpt.loocv();
end