import caliber.math.*
import caliber.math.projection.*
import containers.Map

numPositions2 = 12;
numPositions3 = 8;
numPositions4 = 6;

numSquares = 8;
squareSize = 20;
cameraDist = 50;
pointDist = 1500;

sigma = 0.1;
rotError = 0;
transError = 0;
rotPose = 0.25;
transPose = 100;

cameraTweaks = {1, {'f', 'pp', 'kc'}, 1:2};
extrinsticTweaks = {1, {'r', 't'}, 1:3};

worldPoints = [squareSize * gridCoordinates2d(numSquares) - 0.5 * squareSize * numSquares; zeros(1, numSquares * numSquares)];

K = [2400 0 0; 0 2400 0; 0 0 1];
Kest = [2401 0 1; 0 2399 -1; 0 0 1];
kc = [0.1; -0.2];
kcest = [0.2; -0.3];
C1 = [1 0 0 0;             0 1 0 0;   0 0 1 cameraDist;    0 0 0 1] * randRigid(0.02, 5);
C2 = [-1 0 0 0;            0 1 0 0;   0 0 -1 -cameraDist;  0 0 0 1] * randRigid(0.02, 5);
C3 = [0 0 1  cameraDist;   0 1 0 0;  -1 0 0 0;             0 0 0 1] * randRigid(0.02, 5);
C4 = [0 0 -1 -cameraDist;  0 1 0 0;   1 0 0 0;             0 0 0 1] * randRigid(0.02, 5);
P1 = [1 0 0 0;             0 1 0 0;   0 0 1 pointDist;     0 0 0 1] * randRigid(0.02, 5);
P2 = [-1 0 0 0;            0 1 0 0;   0 0 -1 -pointDist;   0 0 0 1] * randRigid(0.02, 5);
P3 = [0 0 1  pointDist;    0 1 0 0;  -1 0 0 0;             0 0 0 1] * randRigid(0.02, 5);
P4 = [0 0 -1 -pointDist;   0 1 0 0;   1 0 0 0;             0 0 0 1] * randRigid(0.02, 5);

numPositions = numPositions2;
Q = cell(numPositions, 4);
imagePoints = cell(numPositions, 4);
for i = 1:numPositions
    T = randRigid(rotPose, transPose);
    imagePoints{i, 1} = fullProjection(K, kc, inv(C1) * inv(T) * P1, worldPoints) + sigma * randn(2, size(worldPoints, 2));
    imagePoints{i, 2} = fullProjection(K, kc, inv(C2) * inv(T) * P2, worldPoints) + sigma * randn(2, size(worldPoints, 2));
    imagePoints{i, 3} = fullProjection(K, kc, inv(C3) * inv(T) * P3, worldPoints) + sigma * randn(2, size(worldPoints, 2));
    imagePoints{i, 4} = fullProjection(K, kc, inv(C4) * inv(T) * P4, worldPoints) + sigma * randn(2, size(worldPoints, 2));
    Q{i, 1} = inv(C1) * inv(T) * P1 * randRigid(rotError, transError);
    Q{i, 2} = inv(C2) * inv(T) * P2 * randRigid(rotError, transError);
    Q{i, 3} = inv(C3) * inv(T) * P3 * randRigid(rotError, transError);
    Q{i, 4} = inv(C4) * inv(T) * P4 * randRigid(rotError, transError);
end

initOpt4 = caliber.initopt.InitOpt();

initOpt4.addNode('pointset1', 'root', {}, [], {P1}, {});
initOpt4.addNode('pointset2', 'pointset1', {}, [], {[]}, extrinsticTweaks);
initOpt4.addNode('pointset3', 'pointset1', {}, [], {[]}, extrinsticTweaks);
initOpt4.addNode('pointset4', 'pointset1', {}, [], {[]}, extrinsticTweaks);

initOpt4.addNode('camera1', 'root', Kest, kcest, cell(numPositions4, 1), [cameraTweaks; {1:numPositions4, {'r', 't'}, 1:3}]);
initOpt4.addNode('camera2', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);
initOpt4.addNode('camera3', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);
initOpt4.addNode('camera4', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);

for i = 1:numPositions4
    initOpt4.addObservation('camera1', 'pointset1', imagePoints{i, 1}, worldPoints, Q{i, 1}, Map({'camera1'}, {i}));
    initOpt4.addObservation('camera2', 'pointset2', imagePoints{i, 2}, worldPoints, Q{i, 2}, Map({'camera1'}, {i}));
    initOpt4.addObservation('camera3', 'pointset3', imagePoints{i, 3}, worldPoints, Q{i, 3}, Map({'camera1'}, {i}));
    initOpt4.addObservation('camera4', 'pointset4', imagePoints{i, 4}, worldPoints, Q{i, 4}, Map({'camera1'}, {i}));
end

initOpt4.solveInit();
initOpt4.optimizer.plotPixelErrors();
title('Initalizer pixel errors');
initOpt4.optimizer.plotExtrinsics();
title('Initalizer solution');

initOpt4.solveOpt();
initOpt4.optimizer.printSolutionInfo();

initOpt4.optimizer.plotPixelErrors();
title('Optimizer pixel errors');
initOpt4.optimizer.plotExtrinsics();
title('Optimizer solution');


initOpt4 = caliber.initopt.InitOpt();

initOpt4.addNode('pointset1', 'root', {}, [], {P1}, {});
initOpt4.addNode('pointset2', 'pointset1', {}, [], {[]}, extrinsticTweaks);
initOpt4.addNode('pointset3', 'pointset1', {}, [], {[]}, extrinsticTweaks);
initOpt4.addNode('pointset4', 'pointset1', {}, [], {[]}, extrinsticTweaks);

initOpt4.addNode('camera1', 'root', Kest, kcest, cell(numPositions4, 1), [cameraTweaks; {1:numPositions4, {'r', 't'}, 1:3}]);
initOpt4.addNode('camera2', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);
initOpt4.addNode('camera3', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);
initOpt4.addNode('camera4', 'camera1', Kest, kcest, {[]}, [cameraTweaks; extrinsticTweaks]);

for i = 1:numPositions4
    initOpt4.addObservation('camera1', 'pointset1', imagePoints{i, 1}, worldPoints, Q{i, 1}, Map({'camera1'}, {i}));
    initOpt4.addObservation('camera2', 'pointset2', imagePoints{i, 2}, worldPoints, Q{i, 2}, Map({'camera1'}, {i}));
    initOpt4.addObservation('camera3', 'pointset3', imagePoints{i, 3}, worldPoints, Q{i, 3}, Map({'camera1'}, {i}));
    initOpt4.addObservation('camera4', 'pointset4', imagePoints{i, 4}, worldPoints, Q{i, 4}, Map({'camera1'}, {i}));
end

initOpt4.solveInit();
initOpt4.optimizer.plotPixelErrors();
title('Initalizer pixel errors');
initOpt4.optimizer.plotExtrinsics();
title('Initalizer solution');

initOpt4.solveOpt();
initOpt4.optimizer.printSolutionInfo();

initOpt4.optimizer.plotPixelErrors();
title('Optimizer pixel errors');
initOpt4.optimizer.plotExtrinsics();
title('Optimizer solution');

initOpt3 = caliber.initopt.InitOpt();

initOpt3.addNode('pointset1', 'root', {}, [], {P1}, {});
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