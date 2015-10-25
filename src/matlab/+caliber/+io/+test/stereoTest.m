% clear;
close all;
import containers.Map
import caliber.math.*
import caliber.initopt.InitOpt
import caliber.io.bouguet
import caliber.plot.*
import caliber.math.projection.*

rotFunc = @axisAngle;

intrinsics = {1, 'f', 1:2};
distortions = {1, 'kc', 1:2};
extrinsics = {1, {'r', 't'}, 1:3};
extrinsics2 = {1:2, {'r', 't'}, 1:3};


[ imagePoints_color1, worldPoints_color1, ~, ~, Q_color1, imageError_color1 ] = bouguet('caliber_data/stereo_test_00/color.mat', 1);
[ imagePoints_gray1, worldPoints_gray1, ~, ~, Q_gray1, imageError_gray1 ] = bouguet('caliber_data/stereo_test_00/gray.mat', 1);
[ imagePoints_color2, worldPoints_color2, K_color, kc_color, Q_color2, imageError_color2 ] = bouguet('caliber_data/stereo_test_00/color.mat', 2);
[ imagePoints_gray2, worldPoints_gray2, K_gray, kc_gray, Q_gray2, imageError_gray2  ] = bouguet('caliber_data/stereo_test_00/gray.mat', 2);

initOpt = InitOpt();

initOpt.addNode('color', 'root', {K_color}, kc_color, {eye(4)}, [intrinsics; distortions]);
initOpt.addNode('gray', 'color', {K_gray}, kc_gray, {[]}, [extrinsics; intrinsics; distortions]);
initOpt.addNode('pointset', 'root', {}, [], {[], []}, extrinsics2);
initOpt.addObservation('color', 'pointset', imagePoints_color1, worldPoints_color1, Q_color1, Map());
initOpt.addObservation('gray', 'pointset', imagePoints_gray1, worldPoints_gray1, Q_gray1, Map());
initOpt.addObservation('color', 'pointset', imagePoints_color2, worldPoints_color2, Q_color2, Map({'pointset'},{2}));
initOpt.addObservation('gray', 'pointset', imagePoints_gray2, worldPoints_gray2, Q_gray2, Map({'pointset'},{2}));

startImage_color1 = standardProjection( K_color, kc_color, Q_color1, worldPoints_color1);
startImage_gray1 = standardProjection( K_gray, kc_gray, Q_gray1, worldPoints_gray1);
startImage_color2 = standardProjection( K_color, kc_color, Q_color2, worldPoints_color2);
startImage_gray2 = standardProjection( K_gray, kc_gray, Q_gray2, worldPoints_gray2);

imageError_color1 = reshape(imageError_color1, 1, []);
imageError_gray1 = reshape(imageError_gray1, 1, []);
imageError_color2 = reshape(imageError_color2, 1, []);
imageError_gray2 = reshape(imageError_gray2, 1, []);

[ rmsError, meanError, medianError, maxError ] = errorStats( [imageError_color1;imageError_gray1;imageError_color2;imageError_gray2])

%% solve 
initOpt.solveInit(rotFunc);
initMs = initOpt.initializer.graphInit.getMRootTable();
plotTransforms(initMs(:, 1), initMs(:, 2));

[ rmsError, meanError, medianError, maxError ] = errorStats( initOpt.optimizer.computeErrors() )

initOpt.solveOpt();
result = initOpt.optimizer.getTweakTable();
fprintf('Result:\n');
for i=1:size(result, 1)
    fprintf('%s %d %s %d %g %g %g\n', result{i, 1}, result{i, 2}, result{i, 3}, result{i, 4}, result{i, 5}, result{i, 6}, 3 * result{i, 7});
end

stereoSeparation = initOpt.optimizer.getRelativeM('color', 'gray', Map())
imageSeparation = initOpt.optimizer.getRelativeM('color', 'pointset', Map())
[ rmsError, meanError, medianError, maxError ] = errorStats( initOpt.optimizer.computeErrors() )

%% plot results
plotImagePoints(imagePoints_color1, initOpt.optimizer.observations{1}.projectedImage(rotFunc), startImage_color1);
plotImagePoints(imagePoints_gray1, initOpt.optimizer.observations{2}.projectedImage(rotFunc), startImage_gray1);
plotImagePoints(imagePoints_color2, initOpt.optimizer.observations{3}.projectedImage(rotFunc), startImage_color2);
plotImagePoints(imagePoints_gray2, initOpt.optimizer.observations{4}.projectedImage(rotFunc), startImage_gray2);