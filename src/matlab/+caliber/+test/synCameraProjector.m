close all;
clear all;
clc;

import caliber.math.*

numViews = 12;
pointsPerSide = 6;
focalLength = 3000;
resolution = [640; 480];
sigma = 0.1;

screenRealPoints = gridCoordinates2d(pointsPerSide);
projectorPoints = gridCoordinates2d(pointsPerSide) * 30;
projectorPoints = projectorPoints(1:2, :);

K = [eye(2) * focalLength, 0.5 * resolution; 0 0 1];
kc = [0;0];
cameraData = struct();
cameraData.K = K;
cameraData.kc = kc;
cameraData.resolution = resolution;

projectorData = struct();
projectorData.K = inv(K);
projectorData.kc = kc;
projectorData.resolution = resolution;

X = randRigid(0.01, 10)

tree = caliber.tree.Tree();
tree.addNode(caliber.node.GeneralNode('screen', [], struct(), {}));
tree.addNode(caliber.node.GeneralNode('camera', 'screen', cameraData, cell(numViews, 1)));
tree.addNode(caliber.node.GeneralNode('projector', 'camera', projectorData, {[]}));

for i = 1:numViews
    % M = randRigid(0.1, 10) + [zeros(4, 3) [0;0;100;0]];
    M = [eye(3) [0;0;100]; 0 0 0 1];
    Mprojector = X * M;
    
    screenProjectedPoints = caliber.math.projection.standardReverseProjection(inv(K), kc, Mprojector, projectorPoints);
    
    cameraPoints1 = caliber.math.projection.standardProjection(K, kc, M, screenRealPoints);
    cameraPoints1 = cameraPoints1 + randn(size(cameraPoints1)) * sigma;
    
    cameraPoints2 = caliber.math.projection.standardProjection(K, kc, M, screenProjectedPoints);
    cameraPoints2 = cameraPoints2 + randn(size(cameraPoints2)) * sigma;
    
    o1 = caliber.observation.IndependentObservation('camera', 'screen', cameraPoints1, screenRealPoints, M, containers.Map({'camera'}, {i}));
    o2 = caliber.observation.CameraProjectorObservation('projector', 'screen', 'camera', projectorPoints, cameraPoints2, eye(4), containers.Map({'camera'}, {i}));
    tree.addObservation(o1);
    tree.addObservation(o2);
end

tree.plotTree();

initializer = caliber.init.Initializer(tree);
optimizer = caliber.opt.Optimizer(tree);
tweaks = {'camera', {'r', 't'}, 'all', 'all';
    'projector', {'r', 't'}, 'all', 'all'};
%optimizer.addTweaks(tweaks);
optimizer.addTweaks('auto');
initializer.solve();

% tree.plotExtrinsics();
tree.plotPixelErrors();
% tree.plotImagePoints();

% options = optimset();
options = optimset('DerivativeCheck', 'on');
optimizer.solve(options);

% tree.plotExtrinsics();
tree.plotPixelErrors();
% tree.plotImagePoints();
optimizer.printSolutionInfo();
