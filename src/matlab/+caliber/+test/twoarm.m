function [tree, initializer, optimizer] = twoarm(synSigma, doLoocv, assume)

import caliber.math.axisAngle
import caliber.io.bouguet
import containers.Map

close all;

if nargin < 3
    assume = 0;
end

if nargin < 2
    doLoocv = 0;
end

if nargin < 1
    synSigma = 0;
end

% angles(i, :) = [base angle, arm angle, unused, arm 2 angle]
% datafile = filename of Bouguet output

angles = [10 -120 0 -30;...
10 -120 0 -60;...
10 -120 0 -90;...
10 -100 0 -60;...
10 -100 0 -90;...
10 -100 0 -120;...
10 -60 0 -90;...
10 -60 0 -120;...
10 -60 0 -150;...
10 -30 0 -120;...
10 -30 0 -150;...
345 120 0 30;...
345 120 0 60;...
345 120 0 90;...
345 100 0 60;...
345 100 0 90;...
345 100 0 120;...
345 60 0 90;...
345 60 0 120;...
345 60 0 150;...
345 30 0 120;...
345 30 0 150;...
300 30 0 130;...
300 60 0 135;...
300 60 0 90;...
300 120 0 90;...
300 120 0 60;...
300 120 0 30;...
300 120 0 0;...
55 -30 0 -120;...
55 -60 0 -90;...
55 -60 0 -135;...
55 -90 0 -60;...
55 -90 0 -90;...
55 -90 0 -120;...
55 -120 0 -90;...
55 -120 0 -60;...
55 -120 0 -30;...
55 -120 0 0;...
90 60 0 0;...
90 30 0 0;...
90 -30 0 0;...
90 -60 0 0];

datafile = 'caliber_data/cal2arms/merged_results.mat';

% determine unique angles for each joint and convert to rigid
% transformation matrices
[baseStateAngles, ~, baseObsStates] = unique(angles(:, 1), 'rows');
[armStateAngles, ~, armObsStates] = unique(angles(:, 2), 'rows');
[arm2StateAngles, ~, arm2ObsStates] = unique(angles(:, 4), 'rows');
baseStateAngles = caliber.math.deg2rad(baseStateAngles);
armStateAngles = caliber.math.deg2rad(armStateAngles);
arm2StateAngles = caliber.math.deg2rad(arm2StateAngles);

numBaseAngles = size(baseStateAngles, 1);
baseAngles = cell(numBaseAngles, 1);
for i = 1:numBaseAngles
    baseAngles{i} = [axisAngle([0; 0; baseStateAngles(i)]), zeros(3, 1); 0 0 0 1];
end

numArmAngles = size(armStateAngles, 1);
armAngles = cell(numArmAngles, 1);
for i = 1:numArmAngles
    armAngles{i} = [axisAngle([armStateAngles(i); 0; 0]), zeros(3, 1); 0 0 0 1];
end

numArm2Angles = size(arm2StateAngles, 1);
arm2Angles = cell(numArm2Angles, 1);
for i = 1:numArm2Angles
    arm2Angles{i} = [axisAngle([-arm2StateAngles(i); 0; 0]), zeros(3, 1); 0 0 0 1];
end

% number of images
numImages = size(angles, 1);
% the mobile calibration target was visible in these images
mobileIndices = 1:39;
% the fixed calibration target was visible in these images
fixedIndices = [7:11, 18:25, 30:32, 40:43];

imagePoints = cell(numImages, 2);
worldPoints = cell(numImages, 2);

Q = cell(numImages, 2);

% read out data from Bouguet results
[imagePoints(mobileIndices, 1), worldPoints(mobileIndices, 1), Q(mobileIndices, 1), data] = bouguet(datafile, mobileIndices);
[imagePoints(fixedIndices, 2), worldPoints(fixedIndices, 2), Q(fixedIndices, 2), ~] = bouguet(datafile, numImages + fixedIndices);

% build the kinematic tree
% arguments to GeneralNode constructor are: 
% * name of the node
% * name of the parent
% * struct containing camera intrinsics if the node is a camera
% * cell array of rigid transformation matrices, one for each state, empty
% matrices if unknown
tree = caliber.tree.Tree();
tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
tree.addNode(caliber.node.GeneralNode('base_rotation', 'root', struct(), baseAngles));
if assume >= 1
    tree.addNode(caliber.node.GeneralNode('arm', 'base_rotation', struct(), {eye(4)}));
else
    tree.addNode(caliber.node.GeneralNode('arm', 'base_rotation', struct(), {[]}));
end
tree.addNode(caliber.node.GeneralNode('arm_rotation', 'arm', struct(), armAngles));

    tree.addNode(caliber.node.GeneralNode('camera', 'arm_rotation', data, {[]}));


tree.addNode(caliber.node.GeneralNode('fixed_pointset', 'root', struct(), {[]}));

if assume >= 2
    tree.addNode(caliber.node.GeneralNode('arm2', 'root', struct(), {eye(4)}));
else
    tree.addNode(caliber.node.GeneralNode('arm2', 'root', struct(), {[]}));
end
tree.addNode(caliber.node.GeneralNode('arm2_rotation', 'arm2', struct(), arm2Angles));
tree.addNode(caliber.node.GeneralNode('mobile_pointset', 'arm2_rotation', struct(), {[]}));

% add observations
% arguments to IndependentObservation constructor are:
% * camera node
% * target node
% * detected points in the image
% * corresponding world point in the target frame
% * estimated rigid transfrmation
% * state of the tree at time of observation (nodes without a state
% assignment default to their first state)
for i = 1:length(fixedIndices);
    idx = fixedIndices(i);
    observation = caliber.observation.IndependentObservation('camera', 'fixed_pointset', imagePoints{idx, 2}, worldPoints{idx, 2}, Q{idx, 2}, ...
        Map({'base_rotation', 'arm_rotation', 'arm2_rotation'}, {baseObsStates(idx), armObsStates(idx), arm2ObsStates(idx)}));
    tree.addObservation(observation);
end

for i = 1:length(mobileIndices);
    idx = mobileIndices(i);
    observation = caliber.observation.IndependentObservation('camera', 'mobile_pointset', imagePoints{idx, 1}, worldPoints{idx, 1}, Q{idx, 1}, ...
        Map({'base_rotation', 'arm_rotation', 'arm2_rotation'}, {baseObsStates(idx), armObsStates(idx), arm2ObsStates(idx)}));
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
    [~, predictErrors] = synOpt.loocv();
    caliber.plot.plotPixelErrors(predictErrors);
end
