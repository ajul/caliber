import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

f1 = 'caliber_data/nonoverlap05/D_Results.mat';
f2 = 'caliber_data/nonoverlap05/M_Results.mat';
f3 = 'caliber_data/nonoverlap05/C_Results.mat';
f4 = 'caliber_data/nonoverlap05/R_Results.mat';

[optResiduals, predictResiduals] = caliber.nonoverlapLoocv({f2, f3, f4}, 1:6);

fprintf('Optimization pixel residual stats:\n');
[ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( optResiduals )

fprintf('Prediction pixel error stats:\n');
[ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( cell2mat(predictResiduals) )