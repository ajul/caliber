close all;

nObservations = 8;
nPoints = 8;
visibility = 0.5;

pointsSpread = 4;
rotationSpread = 0.1;
translationSpread = 10;

imageNoise = 0.1;
pointsNoise = 0.1;

focalNoise = 0.01;
principalNoise = 10;
kcNoise = 0.1;

rotationNoise = 0.001;
translationNoise = 0.01;

% test: no noise
% imageNoise = 0.1;
% pointsNoise = 0;
% 
% focalNoise = 0;
% principalNoise = 0;
% kcNoise = 0;
% 
% rotationNoise = 0;
% translationNoise = 0;

points = randn(3, nPoints*nPoints*nPoints) * pointsSpread;

% curr = 1;
% for i = 0:nPoints-1
%     for j = 0:nPoints-1
%         for k = 0:nPoints-1
%             points(:, curr) = [i;j;k] * pointsSpread;
%             curr = curr+1;
%         end
%     end
% end

pointsEst = points + randn(size(points)) * pointsNoise;
pointData = struct();
pointData.points = pointsEst;

cameraData = struct();

f = [3000; 3000];
resolution = [4000; 3000];
pp = resolution * 0.5;
K = [diag(f) pp; 0 0 1];
kc = [0; 0];

Kest = [diag(f .* exp(randn(2, 1) * focalNoise)), pp + randn(2, 1) * principalNoise; 0 0 1];
kcest = kc + randn(2, 1) * kcNoise;

cameraData.K = Kest;
cameraData.kc = kcest;
cameraData.resolution = resolution;

M = cell(nObservations, 1);
Mest = cell(nObservations, 1);
for i = 1:nObservations
    M{i} = caliber.math.randRigid(rotationSpread, translationSpread) + [0 0 0 0; 0 0 0 0; 0 0 0 -100 ; 0 0 0 1];
    Mest{i} = M{i} * caliber.math.randRigid(rotationNoise, translationNoise);
end

% pointTweakIndices = true(size(pointsEst));
% pointTweakIndices(:, 1:2) = 0;

Kparams = [1 0 1; 0 1 1; 0 0 0];
cameraTweaks = {'K', Kparams, 0;...
                'kc', 'all', 0;...
                {'r', 't'}, 'all', 'all'};
pointTweaks = {'points', 'all', 0};

opt = caliber.opt.Optimizer();

opt.addNode( 'pointset', 'root', {eye(4)}, pointData, pointTweaks);
opt.addNode( 'camera', 'root', Mest, cameraData, cameraTweaks);

for i = 1:nObservations
    seenIndices = rand(1, size(points, 2)) < visibility;
    seenPoints = points(:, seenIndices);
    imagePoints = caliber.math.projection.standardProjection(K, kc, inv(M{i}), seenPoints);
    imagePointsEst = imagePoints + randn(size(imagePoints)) * imageNoise;
    observation = caliber.observation.NodeObservation('camera', 'pointset', imagePointsEst, seenIndices, [], containers.Map({'camera'}, {i}));
    opt.addObservation(observation);
end

opt.plotPixelErrors();
opt.plotExtrinsics();
opt.solve();
opt.plotPixelErrors();
opt.plotExtrinsics();
