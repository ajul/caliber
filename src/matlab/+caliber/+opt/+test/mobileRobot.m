clear;
close all;
import caliber.opt.*
import caliber.opt.test.*
import caliber.opt.math.projection.*
import containers.Map

zdist = 10;
n = 8;
imageNoise = 2e-3;
estRNoise = 2e-3;
estTNoise = 2e-3;
estIntrinsicsNoise = 2e-3;
radialDistortion = 0.25;
estRDNoise = 2e-2;
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
extrinsics2 = {...
    2, 'r', 1; ...
    2, 'r', 2; ...
    2, 'r', 3; ...
    2, 't', 1; ...
    2, 't', 2; ...
    2, 't', 3};

cTweaks = {};
pTweaks = extrinsics;

gridx = reshape(ones(n, 1) * (1:n), 1, []) / n - 0.5;
gridy = reshape((1:n)' * ones(1, n), 1, []) / n - 0.5;
gridz = zeros(1, n*n);
grid = [gridx; gridy; gridz];

X = randRigid(0.1, 0.1);
Z = randRigid(0.1, 1);
P = randRigid(0.1, 1);
[R1, R2] = randRigid(0.1, 1);
P(3, 4) = P(3, 4) + zdist;
Q1 = inv(X) * inv(R1) * inv(Z) * P;
Q2 = inv(X) * inv(R2) * inv(Z) * P;
Q3 = inv(X) * inv(R1) * P;
Q4 = inv(X) * inv(R2) * P;

[f, pp, K, fnoise, ppnoise, Kest] = randK(estIntrinsicsNoise);
kc = (rand(2, 1) * 2 - 1) * radialDistortion;
rdnoise = (rand(2, 1) * 2 - 1) * estRDNoise;
rdest = kc + rdnoise;
[r1noise, t1noise, M1noise] = randM( estRNoise, estTNoise, rotFunc );
[r2noise, t2noise, M2noise] = randM( estRNoise, estTNoise, rotFunc );
[r3noise, t3noise, M3noise] = randM( estRNoise, estTNoise, rotFunc );
[r4noise, t4noise, M4noise] = randM( estRNoise, estTNoise, rotFunc );
[rPnoise, tPnoise, Pnoise] = randM( estRNoise, estTNoise, rotFunc );
[rXnoise, tXnoise, Xnoise] = randM( estRNoise, estTNoise, rotFunc );
[rZnoise, tZnoise, Znoise] = randM( estRNoise, estTNoise, rotFunc );
Q1est = M1noise \ Q1;
Q2est = M2noise \ Q2;
Q3est = M3noise \ Q3;
Q4est = M4noise \ Q4;
Pest = Pnoise \ P;
Xest = Xnoise \ X;
Zest = Znoise \ Z;

worldPoints = grid;
imagePoints1 = randImage( K, kc, Q1, worldPoints, imageNoise );
imagePoints2 = randImage( K, kc, Q2, worldPoints, imageNoise );
imagePoints3 = randImage( K, kc, Q3, worldPoints, imageNoise );
imagePoints4 = randImage( K, kc, Q4, worldPoints, imageNoise );

nlt = Optimizer(rotFunc);
nlt.addNode('chassis', 'root', {}, [], {Zest, eye(4)}, extrinsics);
nlt.addNode('hand', 'chassis', {}, [], {R1, R2}, {});
nlt.addNode('camera', 'hand', {K}, rdest, {Xest}, [extrinsics; intrinsics; distortions]);
nlt.addNode('pointset', 'root', {}, [], {Pest}, extrinsics);
nlt.addObservation('camera', 'pointset', imagePoints1, worldPoints, Map());
nlt.addObservation('camera', 'pointset', imagePoints2, worldPoints, Map({'hand'}, {2}));
nlt.addObservation('camera', 'pointset', imagePoints3, worldPoints, Map({'chassis'}, {2}));
nlt.addObservation('camera', 'pointset', imagePoints4, worldPoints, Map({'chassis', 'hand'}, {2, 2}));

start1 = nlt.observations{1}.projectedImage(rotFunc);
start2 = nlt.observations{2}.projectedImage(rotFunc);
start3 = nlt.observations{3}.projectedImage(rotFunc);
start4 = nlt.observations{4}.projectedImage(rotFunc);

options = optimset('Jacobian', 'on', 'MaxFunEvals', 3000, 'PlotFcns', {@optimplotresnorm; @optimplotstepsize});
[x,resnorm,residual,exitflag,output,lambda,jacobian] = nlt.solve(options);
result = nlt.getTweakTable();
fprintf('Result:\n');
for i=1:size(result, 1)
    fprintf('%s %d %s %d %g\n', result{i, 1}, result{i, 2}, result{i, 3}, result{i, 4}, result{i, 5});
end

plotImagePoints(imagePoints1, nlt.observations{1}.projectedImage(rotFunc), start1);
plotImagePoints(imagePoints2, nlt.observations{2}.projectedImage(rotFunc), start2);
plotImagePoints(imagePoints3, nlt.observations{3}.projectedImage(rotFunc), start3);
plotImagePoints(imagePoints4, nlt.observations{4}.projectedImage(rotFunc), start4);
estJacobian = full(jacobian);
compJacobian = nlt.computeErrorJacobian();