function tablet00 (synSigma, doLoocv)

import containers.Map
import caliber.io.bouguet
close all;

if nargin < 2
    doLoocv = 0;
end

if nargin < 1
    synSigma = 0;
end

numPositions = 8;
numResults = 5;

unknownMsn = cell(numPositions, 1);

imagePoints = cell(numPositions, 5);
worldPoints = cell(numPositions, 5);
data = cell(1, 5);
Q = cell(numPositions, 5);
imageError = cell(numPositions, 5);

[imagePoints(:, 1), worldPoints(:, 1), Q(:, 1), data{1}] = bouguet('data/tablet02/cm_results.mat', 1:numPositions);
[imagePoints(:, 2), worldPoints(:, 2), Q(:, 2), data{2}] = bouguet('data/tablet02/mm_results.mat', 1:numPositions);
[imagePoints(:, 3), worldPoints(:, 3), Q(:, 3), data{3}] = bouguet('data/tablet02/cm_results.mat', (1:numPositions)+numPositions);
[imagePoints(:, 4), worldPoints(:, 4), Q(:, 4), data{4}] = bouguet('data/tablet02/mm_results.mat', (1:numPositions)+numPositions);
[imagePoints(:, 5), worldPoints(:, 5), Q(:, 5), data{5}] = bouguet('data/tablet02/t_results.mat', 1:numPositions);

tree = caliber.tree.Tree();
tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));

tree.addNode(caliber.node.GeneralNode('camera1', 'root', data{1}, {eye(4)}));
tree.addNode(caliber.node.GeneralNode('camera2', 'camera1', data{2}, {[]}));
tree.addNode(caliber.node.GeneralNode('pointset', 'root', struct(), unknownMsn));
tree.addNode(caliber.node.GeneralNode('tablet_pointset', 'root', struct(), unknownMsn));
tree.addNode(caliber.node.GeneralNode('tablet_camera', 'tablet_pointset', data{5}, {[]}));

for i = 1:numPositions
    state = Map({'pointset', 'tablet_pointset'}, {i, i});
    observation = caliber.observation.IndependentObservation('camera1', 'pointset', imagePoints{i, 1}, worldPoints{i, 1}, Q{i, 1}, state, state);
    tree.addObservation(observation);
    
    observation = caliber.observation.IndependentObservation('camera2', 'pointset', imagePoints{i, 2}, worldPoints{i, 2}, Q{i, 2}, state, state);
    tree.addObservation(observation);
    
    observation = caliber.observation.IndependentObservation('camera1', 'tablet_pointset', imagePoints{i, 3}, worldPoints{i, 3}, Q{i, 3}, state, state);
    tree.addObservation(observation);
    
    observation = caliber.observation.IndependentObservation('camera2', 'tablet_pointset', imagePoints{i, 4}, worldPoints{i, 4}, Q{i, 4}, state, state);
    tree.addObservation(observation);
    
    observation = caliber.observation.IndependentObservation('tablet_camera', 'pointset', imagePoints{i, 5}, worldPoints{i, 5}, Q{i, 5}, state, state);
    tree.addObservation(observation);
end

tree.plotTree();

if doLoocv
	[initializer, optimizer] = tree.loocv('auto');
	caliber.plot.plotPixelErrors(optimizer);
    title('LOOCV pixel errors');
else
    initializer = caliber.init.Initializer(tree);
    optimizer = caliber.opt.Optimizer(tree);
    optimizer.addTweaks('auto');
    initializer.solve();

    tree.plotExtrinsics();
    tree.plotPixelErrors();
    title('Kinematic estimation pixel errors');

    optimizer.solve();

    tree.plotExtrinsics();
    tree.plotPixelErrors();
    title('Nonlinear optimization pixel errors');
    optimizer.printSolutionInfo();
end


if synSigma > 0
    synOpt = optimizer.makeSynthetic(synSigma);
    synOpt.loocv();
end

% [residuals, errors] = initOpt.loocv(rotFunc);
% 
% allErrors = [];
% for i = 1:length(errors)
%     allErrors = [allErrors; errors{i}];
% end
% 
% fprintf('Optimization pixel residual stats:\n');
% [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( residuals )
% 
% fprintf('Prediction pixel error stats:\n');
% [ rSq, rmsError, meanError, medianError, minError, maxError ] = caliber.math.errorStats( allErrors )