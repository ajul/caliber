clear all;
close all;

numr = 3;
numt = 1;

X = caliber.math.randRigid()
Y = caliber.math.randRigid()
Z = caliber.math.randRigid()
P = caliber.math.randRigid()

r = randn(3, 1);

Rs = cell(1, numr);
for i = 1:numr
    Rs{i} = [caliber.math.axisAngle(r * randn()) zeros(3, 1); 0 0 0 1];
end

Ts = cell(1, numt);
for i = 1:numt
    Ts{i} = [eye(3) [0; 0; 10 * randn()]; 0 0 0 1];
end

extrinsicTweaks = {{'r', 't'}, 1:3, 1};
initOpt = caliber.initopt.InitOpt();

switch 2
    
    case 1

        initOpt.addNode('pointset', 'root', {P}, struct(), {});

        initOpt.addNode('Tbase', 'root', {[]}, struct(), extrinsicTweaks);
        initOpt.addNode('T', 'Tbase', Ts, struct(), {});

        initOpt.addNode('Rbase', 'T', {[]}, struct(), extrinsicTweaks);
        initOpt.addNode('R', 'Rbase', Rs, struct(), {});

        initOpt.addNode('camera', 'R', {[]}, struct(), extrinsicTweaks);
        
        for i = 1:length(Ts)
            for j = 1:length(Rs)
                Q = (X * Ts{i} * Y * Rs{j} * Z) \ P;
                cameraStates = containers.Map({'T', 'R'}, {i, j});
                observation = caliber.observation.TransformationObservation('camera', 'pointset', Q, cameraStates);
                initOpt.addObservation(observation);
            end
        end

    case 2

        initOpt.addNode('pointset', 'root', {P}, struct(), {});

        initOpt.addNode('Rbase', 'root', {[]}, struct(), extrinsicTweaks);
        initOpt.addNode('R', 'Rbase', Rs, struct(), {});

        initOpt.addNode('Tbase', 'R', {[]}, struct(), extrinsicTweaks);
        initOpt.addNode('T', 'Tbase', Ts, struct(), {});

        initOpt.addNode('camera', 'T', {[]}, struct(), extrinsicTweaks);
        
        for i = 1:length(Rs)
            for j = 1:length(Ts)
                Q = (X * Rs{i} * Y * Ts{j} * Z) \ P;
                cameraStates = containers.Map({'R', 'T'}, {i, j});
                observation = caliber.observation.TransformationObservation('camera', 'pointset', Q, cameraStates);
                initOpt.addObservation(observation);
            end
        end
end


initializerOptions = caliber.init.initializerOptionsSet('SecondaryLabels', 'None');
initOpt.solveInit(initializerOptions);
initOpt.optimizer.plotExtrinsics();
title('Initalizer solution');
initOpt.optimizer.printSolutionStats();

initOpt.initializer.plotTree();
