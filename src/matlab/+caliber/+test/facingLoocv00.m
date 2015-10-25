import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

deviceFile1 = 'data/facing00/a_results.mat';
deviceFile2 = 'data/facing00/d_results.mat';

[optResiduals, predictResiduals] = caliber.facingDevicesLoocv(deviceFile1, deviceFile2, 13);

fprintf('Prediction pixel residual stats:\n');
[ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( optResiduals )

fprintf('Prediction pixel error stats:\n');
for i = 1:length(predictResiduals)
    [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( predictResiduals{i})
end