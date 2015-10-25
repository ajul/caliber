clear;
close all;
import caliber.opt.*
import caliber.opt.test.*
import caliber.opt.math.projection.*
import containers.Map


%% Set up problem
n = 8;
zdist = 5;
imageNoise = 1e-3;
estRNoise = 1e-3;
estTNoise = 1e-3;
estIntrinsicsNoise = 1e-3;
radialDistortion = 0.25;
estRDNoise = 1e-4;
rotFunc = @cayley;

intrinsics = {...
    1, 'f', 1;...
    1, 'f', 2;...
    1, 'pp', 1;...
    1, 'pp', 2};
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

cTweaks = [intrinsics; distortions];
pTweaks = extrinsics;

gridx = reshape(ones(n, 1) * (1:n), 1, []) / n - 0.5;
gridy = reshape((1:n)' * ones(1, n), 1, []) / n - 0.5;
gridz = zeros(1, n*n);
grid = [gridx; gridy; gridz];

[f1, pp1, K1, f1noise, pp1noise, K1est] = randK(estIntrinsicsNoise);
[f2, pp2, K2, f2noise, pp2noise, K2est] = randK(estIntrinsicsNoise);

rd1 = (rand(2, 1) * 2 - 1) * radialDistortion;
rd2 = (rand(2, 1) * 2 - 1) * radialDistortion;
noiserd1 = (rand(2, 1) * 2 - 1) * estRDNoise;
noiserd2 = (rand(2, 1) * 2 - 1) * estRDNoise;
rd1est = rd1 + noiserd1;
rd2est = rd2 + noiserd2;
S = randRigid(0.1, 1);
P = randRigid(0.1, 1);
P(3, 4) = P(3, 4) + zdist;
noiser = (2 * rand(3, 1) - 1) * estRNoise;
noiseT = (2 * rand(3, 1) - 1) * estTNoise;
noiseR = rotFunc(noiser);
noiseM = [noiseR noiseT; 0 0 0 1];
Pest = noiseM \ P;

fprintf('Actual:\n');
fprintf('c1 fx %g\n', -f1noise(1));
fprintf('c1 fy %g\n', -f1noise(2));
fprintf('c1 ppx %g\n', -pp1noise(1));
fprintf('c1 ppy %g\n', -pp1noise(2));
fprintf('c1 rd1 %g\n', -noiserd1(1));
fprintf('c1 rd2 %g\n', -noiserd1(2));

fprintf('c2 fx %g\n', -f2noise(1));
fprintf('c2 fy %g\n', -f2noise(2));
fprintf('c2 ppx %g\n', -pp2noise(1));
fprintf('c2 ppy %g\n', -pp2noise(2));
fprintf('c2 rd1 %g\n', -noiserd2(1));
fprintf('c2 rd2 %g\n', -noiserd2(2));

fprintf('p rx %g\n', noiser(1));
fprintf('p ry %g\n', noiser(2));
fprintf('p rz %g\n', noiser(3));
fprintf('p tx %g\n', noiseT(1));
fprintf('p ty %g\n', noiseT(2));
fprintf('p tz %g\n', noiseT(3));


Q1 = P;
Q2 = S \ P;

worldPoints = grid;
%worldPoints = rand(3, n);
imagePoints1 = standardProjection(K1, rd1, Q1, worldPoints);
imagePoints2 = standardProjection(K2, rd2, Q2, worldPoints);
imagePoints1 = imagePoints1 + (2 * rand(size(imagePoints1)) - 1) * imageNoise;
imagePoints2 = imagePoints2 + (2 * rand(size(imagePoints2)) - 1) * imageNoise;

nlt = Optimizer(rotFunc);
nlt.addNode('c1', 'root', {K1est}, rd1est, {eye(4)}, cTweaks);
nlt.addNode('c2', 'root', {K2est}, rd2est, {S}, cTweaks);
nlt.addNode('p', 'root', [], [], {Pest}, pTweaks);
nlt.addObservation('c1', 'p', imagePoints1, worldPoints, Map());
nlt.addObservation('c2', 'p', imagePoints2, worldPoints, Map());

%% Derivative testing.
% h = 1e-6;
% tweakNoise = 1e-3;
% numTweaks = size(nlt.tweaks, 1);
% tweaks = (rand(numTweaks, 1) * 2 - 1) * tweakNoise;
% nlt.setTweaks(tweaks);
% M = nlt.getRelativeM('c1', 'p', Map());
% dM = nlt.getRelativedM('c1', 'p', Map(), nlt.tweaks{1, 1}, nlt.tweaks{1, 2}, nlt.tweaks{1, 3})
% imagePoints = projectPoints(f1, rd1, pp1, M, worldPoints)
% dImagePoints = projectPointsDerivative(f1, rd1, pp1, M, f1, rd1, pp1, dM, worldPoints)
% tweaks(1) = tweaks(1) + h;
% nlt.setTweaks(tweaks);
% Mh = nlt.getRelativeM('c1', 'p', Map());
% imagePointsh = projectPoints(f1, rd1, pp1, Mh, worldPoints)
% dMfd = (Mh - M) / h
% dImagePointsfd = (imagePointsh - imagePoints) / h

%% Solve.

options = optimset('Jacobian', 'off');
[x,resnorm,residual,exitflag,output,lambda,jacobian] = nlt.solve(options);
result = nlt.getTweakTable();
fprintf('Result:\n');
for i=1:size(result, 1)
    fprintf('%s %d %s %d %g\n', result{i, 1}, result{i, 2}, result{i, 3}, result{i, 4}, result{i, 5});
end
Presult = nlt.getNode('p').getM(Map(), @axisAngle);
P - Presult
plotImagePoints(imagePoints1, nlt.observations{1}.projectedImage(rotFunc));
plotImagePoints(imagePoints2, nlt.observations{2}.projectedImage(rotFunc));
estJacobian = full(jacobian);
compJacobian = nlt.computeErrorJacobian();


