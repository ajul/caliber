import caliber.math.*
import caliber.math.projection.*
import containers.Map

numPositions2 = 12;
numPositions3 = 8;

numSquares = 8;
squareSize = 20;

sigma = 0.1;
rotError = 0;
transError = 0;
rotPose = 0.25;
transPose = 100;
sideAngle = 0.75 * pi;

cameraTweaks = {1, {'f', 'pp', 'kc'}, 1:2};
extrinsticTweaks = {1, {'r', 't'}, 1:3};

worldPoints = [squareSize * gridCoordinates2d(numSquares) - 0.5 * squareSize * numSquares; zeros(1, numSquares * numSquares)];

K = [2400 0 0; 0 2400 0; 0 0 1];
Kest = [2401 0 1; 0 2399 -1; 0 0 1];
kc = [0.1; -0.2];
kcest = [0.2; -0.3];
C2 = [axisAngle([0  sideAngle 0]) [ 50; 0; -100];    0 0 0 1];
C3 = [axisAngle([0 -sideAngle 0]) [-50; 0; -100];    0 0 0 1];
P1 = [eye(3)                      [0; 0; 1000];      0 0 0 1];
P2 = [axisAngle([0  sideAngle 0]) [ 1000; 0; -1000]; 0 0 0 1];
P3 = [axisAngle([0 -sideAngle 0]) [-1000; 0; -1000]; 0 0 0 1];

numPositions = max(numPositions2, numPositions3);
Q = cell(numPositions, 3);
imagePoints = cell(numPositions, 3);
for i = 1:numPositions
    T = randRigid(rotPose, transPose);
    imagePoints{i, 1} = fullProjection(K, kc,           inv(T) * P1, worldPoints) + sigma * randn(2, size(worldPoints, 2));
    imagePoints{i, 2} = fullProjection(K, kc, inv(C2) * inv(T) * P2, worldPoints) + sigma * randn(2, size(worldPoints, 2));
    imagePoints{i, 3} = fullProjection(K, kc, inv(C3) * inv(T) * P3, worldPoints) + sigma * randn(2, size(worldPoints, 2));
    Q{i, 1} =           inv(T) * P1 * randRigid(rotError, transError);
    Q{i, 2} = inv(C2) * inv(T) * P2 * randRigid(rotError, transError);
    Q{i, 3} = inv(C3) * inv(T) * P3 * randRigid(rotError, transError);
end

initOpt3 = caliber.initopt.InitOpt();

initOpt3.addNode('pointset1', 'root', {}, [], {eye(4)}, {});
initOpt3.addNode('pointset2', 'pointset1', {}, [], {[]}, extrinsticTweaks);
initOpt3.addNode('pointset3', 'pointset1', {}, [], {[]}, extrinsticTweaks);

initOpt3.addNode('camera1', 'root', Kest, kcest, cell(numPositions3, 1), [cameraTweaks; {1:numPositions3, {'r', 't'}, 1:3}]);
initOpt3.addNode('camera2', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);
initOpt3.addNode('camera3', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);

for i = 1:numPositions3
    initOpt3.addObservation('camera1', 'pointset1', imagePoints{i, 1}, worldPoints, Q{i, 1}, Map({'camera1'}, {i}));
    initOpt3.addObservation('camera2', 'pointset2', imagePoints{i, 2}, worldPoints, Q{i, 2}, Map({'camera1'}, {i}));
    initOpt3.addObservation('camera3', 'pointset3', imagePoints{i, 3}, worldPoints, Q{i, 3}, Map({'camera1'}, {i}));
end

initOpt3.solveInit();
initOpt3.optimizer.plotPixelErrors();
title('Initalizer pixel errors');
initOpt3.optimizer.plotExtrinsics();
title('Initalizer solution');

initOpt3.solveOpt();
initOpt3.optimizer.printSolutionInfo();

initOpt3.optimizer.plotPixelErrors();
title('Optimizer pixel errors');
initOpt3.optimizer.plotExtrinsics();
title('Optimizer solution');


initOpt2 = caliber.initopt.InitOpt();

initOpt2.addNode('pointset1', 'root', {}, [], {eye(4)}, {});
initOpt2.addNode('pointset2', 'pointset1', {}, [], {[]}, extrinsticTweaks);

initOpt2.addNode('camera1', 'root', Kest, kcest, cell(numPositions2, 1), [cameraTweaks; {1:numPositions2, {'r', 't'}, 1:3}]);
initOpt2.addNode('camera2', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);

for i = 1:numPositions2
    initOpt2.addObservation('camera1', 'pointset1', imagePoints{i, 1}, worldPoints, Q{i, 1}, Map({'camera1'}, {i}));
    initOpt2.addObservation('camera2', 'pointset2', imagePoints{i, 2}, worldPoints, Q{i, 2}, Map({'camera1'}, {i}));
end

initOpt2.solveInit();
initOpt2.optimizer.plotPixelErrors();
title('Initalizer pixel errors');
initOpt2.optimizer.plotExtrinsics();
title('Initalizer solution');

initOpt2.solveOpt();
initOpt2.optimizer.printSolutionInfo();

initOpt2.optimizer.plotPixelErrors();
title('Optimizer pixel errors');
initOpt2.optimizer.plotExtrinsics();
title('Optimizer solution');