import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

cameraDataFiles = {'data/tablet02/c_results.mat', 'data/tablet02/m_results.mat'};
numCameras = length(cameraDataFiles);

initOpt = caliber.fixedCameraSet( cameraDataFiles, 1:8 );

fprintf('Observation pixel error stats:\n');
obsErrors = initOpt.optimizer.computeErrors();
[ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( obsErrors )
