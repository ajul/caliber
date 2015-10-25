% clear;
close all;
import containers.Map
import caliber.math.*
import caliber.initopt.InitOpt
import caliber.io.bouguet
import caliber.plot.*
import caliber.math.projection.*

rotFunc = @axisAngle;

estRNoise = 0;
estTNoise = 0;
estfNoise = 0;
estkcNoise = 0;

intrinsics = {...
    1, 'f', 1;...
    1, 'f', 2};
distortions = {...
    1, 'kc', 1;...
    1, 'kc', 2;...
    };
extrinsics = {...
    1, 'r', 1; ...
    1, 'r', 2; ...
    1, 'r', 3; ...
    1, 't', 1; ...
    1, 't', 2; ...
    1, 't', 3};


[ imagePoints, worldPoints, K, kc, Q ] = bouguet('toolbox_calib/calib_example/Calib_Results.mat',1);

[ffKnoise, ppKnoise, Knoise] = randK( estfNoise, 0 )
kcNoise = (rand(2, 1) * 2 - 1) * estkcNoise
[rQnoise, tQnoise, Qnoise] = randM( estRNoise, estTNoise, rotFunc )

Qest = Qnoise \ Q;
Kest = K - Knoise;
kcest = kc - kcNoise;

initOpt = InitOpt();

initOpt.addNode('camera', 'root', {Kest}, kcest, {eye(4)}, [intrinsics; distortions]);
initOpt.addNode('pointset', 'root', {}, [], {[]}, extrinsics);
initOpt.addObservation('camera', 'pointset', imagePoints, worldPoints, Qest, Map());

startImage = standardProjection( Kest, kcest, Qest, worldPoints);
%% solve 
options = optimset('Jacobian', 'on');
[x,resnorm,residual,exitflag,output,lambda,jacobian] = initOpt.solve(rotFunc, options);
result = initOpt.optimizer.getTweakTable();
fprintf('Result:\n');
for i=1:size(result, 1)
    fprintf('%s %d %s %d %g %g %g\n', result{i, 1}, result{i, 2}, result{i, 3}, result{i, 4}, result{i, 5}, result{i, 6}, 3 * result{i, 7});
end

%% plot results
plotImagePoints(imagePoints, initOpt.optimizer.observations{1}.projectedImage(rotFunc), startImage);

estJacobian = full(jacobian);
compJacobian = initOpt.optimizer.computeErrorJacobian();