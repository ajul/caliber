close all;
clear all;

import caliber.math.*

numSets = 4;
viewsPerSet = 4;
pointsPerSide = 9;
focalLength = 3000;
resolution = [3072; 2048];
sigma = 0.1;

worldPoints = gridCoordinates2d(pointsPerSide);

K = [eye(2) * focalLength, 0.5 * resolution; 0 0 1];
kc = [0;0];
data = struct();
data.K = K;
data.kc = kc;
data.resolution = resolution;

translations = randn(numSets, 1);
rotations = cell(viewsPerSet, 1);
rotationAxis = randn(3, 1);
for i = 1:viewsPerSet
    rotations{i} = [axisAngle(rotationAxis * randn() * 0.1) [0;0;0]; 0 0 0 1];
end

P = randRigid() + [zeros(3) [0;0;100]; 0 0 0 0];
X = randRigid();
Y = randRigid();
Z = randRigid();

tree = caliber.tree.Tree();
tree.addNode(caliber.node.GeneralNode('camera1', [], data, {}));
tree.addNode(caliber.node.GeneralNode('translation_base', 'camera1', struct(), {[]}));
s = struct();
s.gain = 1.1;
tree.addNode(caliber.node.PrismaticJoint('translation', 'translation_base', s, translations));
tree.addNode(caliber.node.GeneralNode('rotation_base', 'translation', struct(), {[]}));
tree.addNode(caliber.node.GeneralNode('rotation', 'rotation_base', struct(), rotations));
tree.addNode(caliber.node.GeneralNode('camera2', 'rotation', data, {[]}));

tree.addNode(caliber.node.GeneralNode('pointset', 'camera1', struct(), {[]}));

for i = 1:numSets
    for j = 1:viewsPerSet
        M1 = P;
        T = [eye(3) [0;0;translations(i)]; 0 0 0 1];
        R = rotations{j};
        M2 = inv(X * T * Y * R * Z) * P;
        imagePoints1 = caliber.math.projection.standardProjection( K, kc, M1, worldPoints );
        imagePoints1 = imagePoints1 + randn(size(imagePoints1)) * sigma;
        imagePoints2 = caliber.math.projection.standardProjection( K, kc, M2, worldPoints );
        imagePoints2 = imagePoints2 + randn(size(imagePoints2)) * sigma;
        
        o1 = caliber.observation.IndependentObservation('camera1', 'pointset', imagePoints1, worldPoints, M1, containers.Map({'translation', 'rotation'}, {i, j}));
        o2 = caliber.observation.IndependentObservation('camera2', 'pointset', imagePoints2, worldPoints, M2, containers.Map({'translation', 'rotation'}, {i, j}));
        tree.addObservation(o1);
        tree.addObservation(o2);
    end
end

tree.plotTree();

initializer = caliber.init.Initializer(tree);
optimizer = caliber.opt.Optimizer(tree);
optimizer.addTweaks('auto');
initializer.solve();

tree.plotExtrinsics();
tree.plotPixelErrors();

optimizer.solve();

tree.plotExtrinsics();
tree.plotPixelErrors();
optimizer.printSolutionInfo();

