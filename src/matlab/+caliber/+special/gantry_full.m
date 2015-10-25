function [tree, initializer, optimizer] = gantry_full(datafile, angles, objectImageIndices, arm2ImageIndices)
% datafile = filename of Bouguet output
%   create this by running Bouguet over the complete set of images
%   selecting the object checkerboard, then running it again
%   selecting the second arm checkerboard, then merging the results (either order)
%   make sure that each set has all the images; if a checkerboard 
%   is not visible in a particular image, disable the image in bouguet
% angles(i, :) = [base angle, arm angle, object angle, arm 2 angle]
%   one angle set for each image
% objectImageIndices: image indices in the Bouguet file where object checkerboard was visible
% arm2ImageIndices: image indices in the Bouguet file where second arm checkerboard was visible
import caliber.math.axisAngle
import caliber.io.bouguet
import containers.Map

close all;

% determine unique angles for each joint and convert to rigid
% transformation matrices
[baseStateAngles, ~, baseObsStates] = unique(angles(:, 1), 'rows');
[armStateAngles, ~, armObsStates] = unique(angles(:, 2), 'rows');
[objectStateAngles, ~, objectObsStates] = unique(angles(:, 3), 'rows');
[arm2StateAngles, ~, arm2ObsStates] = unique(angles(:, 4), 'rows');
baseStateAngles = caliber.math.deg2rad(baseStateAngles);
armStateAngles = caliber.math.deg2rad(armStateAngles);
objectStateAngles = caliber.math.deg2rad(objectStateAngles);
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

numObjectAngles = size(objectStateAngles, 1);
objectAngles = cell(numObjectAngles, 1);
for i = 1:numObjectAngles
    objectAngles{i} = [axisAngle([0; 0; objectStateAngles(i)]), zeros(3, 1); 0 0 0 1];
end

numArm2Angles = size(arm2StateAngles, 1);
arm2Angles = cell(numArm2Angles, 1);
for i = 1:numArm2Angles
    arm2Angles{i} = [axisAngle([-arm2StateAngles(i); 0; 0]), zeros(3, 1); 0 0 0 1];
end

% number of images
numImages = size(angles, 1);

imagePoints = cell(numImages, 2);
worldPoints = cell(numImages, 2);

Q = cell(numImages, 2);

% read out data from Bouguet results
objectAngleIndices = mod(objectImageIndices - 1, numImages) + 1;
arm2AngleIndices = mod(arm2ImageIndices - 1, numImages) + 1;
[imagePoints(objectAngleIndices, 1), worldPoints(objectAngleIndices, 1), Q(objectAngleIndices, 1), data] = bouguet(datafile, objectImageIndices);
[imagePoints(arm2AngleIndices, 2), worldPoints(arm2AngleIndices, 2), Q(arm2AngleIndices, 2), ~]          = bouguet(datafile, arm2ImageIndices);

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
tree.addNode(caliber.node.GeneralNode('arm', 'base_rotation', struct(), {[]}));
tree.addNode(caliber.node.GeneralNode('arm_rotation', 'arm', struct(), armAngles));
tree.addNode(caliber.node.GeneralNode('camera', 'arm_rotation', data, {[]}));

tree.addNode(caliber.node.GeneralNode('object_base', 'root', struct(), {[]}));
tree.addNode(caliber.node.GeneralNode('object_rotation', 'object_base', struct(), objectAngles));
tree.addNode(caliber.node.GeneralNode('object_pointset', 'object_rotation', struct(), {[]}));

tree.addNode(caliber.node.GeneralNode('arm2', 'root', struct(), {[]}));
tree.addNode(caliber.node.GeneralNode('arm2_rotation', 'arm2', struct(), arm2Angles));
tree.addNode(caliber.node.GeneralNode('arm2_pointset', 'arm2_rotation', struct(), {[]}));

% add observations
% arguments to IndependentObservation constructor are:
% * camera node
% * target node
% * detected points in the image
% * corresponding world point in the target frame
% * estimated rigid transfrmation
% * state of the tree at time of observation (nodes without a state
% assignment default to their first state)
for i = 1:length(objectImageIndices);
    idx = objectAngleIndices(i);
    observation = caliber.observation.IndependentObservation('camera', 'object_pointset', imagePoints{idx, 1}, worldPoints{idx, 1}, Q{idx, 1}, ...
        Map({'base_rotation', 'arm_rotation', 'object_rotation', 'arm2_rotation'}, ...
        {baseObsStates(idx), armObsStates(idx), objectObsStates(idx), arm2ObsStates(idx)}));
    tree.addObservation(observation);
end

for i = 1:length(arm2ImageIndices);
    idx = arm2AngleIndices(i);
    observation = caliber.observation.IndependentObservation('camera', 'arm2_pointset', imagePoints{idx, 2}, worldPoints{idx, 2}, Q{idx, 2}, ...
        Map({'base_rotation', 'arm_rotation', 'object_rotation', 'arm2_rotation'}, ...
        {baseObsStates(idx), armObsStates(idx), objectObsStates(idx), arm2ObsStates(idx)}));
    tree.addObservation(observation);
end

tree.plotTree();

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
