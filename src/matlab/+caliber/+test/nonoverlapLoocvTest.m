import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

f1 = 'data/stereo_03/m_results.mat';
f2 = 'data/stereo_03/c_results.mat';

[optResiduals, predictResiduals] = caliber.nonoverlapLoocv(f1, f2, 1:12);

fprintf('Optimization pixel residual stats:\n');
[ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( optResiduals )

fprintf('Prediction pixel error stats:\n');
for i = 1:length(predictResiduals)
    [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( predictResiduals{i})
end