close all;
clear all;

import caliber.math.*

numCameras = 8;
pointsPerSide = 9;
numSets = 2;
viewsPerSet = 6;
pixelNoise = 0.1;

cameraRadius = 20;
pointsetRadius = 100;
pointsetVarR = 0;
pointsetVarT = 0;
viewVarR = 0.01;
viewVarT = 5;
focalLength = 3000;
resolution = [3072; 2048];
                
numViews = numSets * viewsPerSet;
worldPoints = gridCoordinates2d(pointsPerSide);

K = [eye(2) * focalLength, 0.5 * resolution; 0 0 1];
kc = [0;0];
data = struct();
data.K = K;
data.kc = kc;
data.worldPoints = worldPoints;
data.resolution = resolution;

standR = axisAngle([-pi/2; 0; 0]);
standM = [standR [0;0;0]; 0 0 0 1];

cameraMs = cell(numCameras, 1);
pointMs = cell(numCameras, 1);
baseMs = cell(numViews, 1);

currBaseIndex = 1;

for i = 1:numCameras
    angle = 2 * pi * (i-1) / numCameras;
    R = caliber.math.axisAngle([0; 0; angle]);
    RM = [R [0;0;0]; 0 0 0 1];
    cameraMs{i} = RM * [eye(3) [0; cameraRadius; 0]; 0 0 0 1] * standM;
    pointMs{i} = RM * [eye(3) [0; pointsetRadius; 0]; 0 0 0 1] * standM * randRigid(pointsetVarR, pointsetVarT);
    
    if i <= numSets
        for j = 1:viewsPerSet
            baseMs{currBaseIndex} = RM * randRigid(viewVarR, viewVarT);
            currBaseIndex = currBaseIndex + 1;
        end
    end
end

Kparams = [1 0 1; 0 1 1; 0 0 0];
cameraTweaks = {'K', Kparams, 0;...
                    'kc', 'all', 0};                        % tweak intrinsics for 1 state 
extrinsicTweaksAll = {{'r', 't'}, 'all', 'all'};      % tweak extrinsics for each of n states
                
initOpt = caliber.initopt.InitOpt();

initOpt.addNode('base', 'root', baseMs, struct(), extrinsicTweaksAll);

for i = 1:numCameras
    cameraName = sprintf('camera%d', i);
    pointsetName = sprintf('pointset%d', i);
    initOpt.addNode(cameraName, 'base', cameraMs(i), data, [cameraTweaks; extrinsicTweaksAll]);
    initOpt.addNode(pointsetName, 'root', pointMs(i), struct(), extrinsicTweaksAll);
end

currBaseIndex = 1;

for setIndex = 1:numSets
    for viewIndex = 1:viewsPerSet
        for cameraIndex = 1:numCameras
            pointsetIndex = caliber.math.mod1(cameraIndex + setIndex - 1, numCameras);
            cameraName = sprintf('camera%d', cameraIndex);
            pointsetName = sprintf('pointset%d', pointsetIndex);
            observation = caliber.observation.IndependentObservation(cameraName, pointsetName, [], worldPoints, [], containers.Map({'base'}, {currBaseIndex}));
            initOpt.addObservation(observation);
        end
        currBaseIndex = currBaseIndex + 1;
    end
end

initOpt.solveInit();
initOpt.optimizer.plotExtrinsics();
title('Original extrinsics');

syn = initOpt.makeSynthetic(pixelNoise);
% syn.solve();
% syn.optimizer.plotExtrinsics();
% title('Synthetic extrinsics');

[optResiduals, predictErrors] = syn.loocv();