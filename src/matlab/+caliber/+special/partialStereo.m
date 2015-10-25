function optimizer = partialStereo( resultFile1, resultFile2, pairs )
%PARTIALSTEREO 

    [imagePoints1, worldPoints1, Q1, data1] = caliber.io.bouguet(resultFile1, 'all');
    [imagePoints2, worldPoints2, Q2, data2] = caliber.io.bouguet(resultFile2, 'all');
    n1 = length(Q1);
    n2 = length(Q2);
    nTotal = n1 + n2;
    nPairs = size(pairs, 1);
    nPositions = nTotal - nPairs;
    
    states1 = zeros(n1, 1);
    states2 = zeros(n2, 1);
    
    currState = 1;
    for i = 1:nPairs
        states1(pairs(i, 1)) = currState;
        states2(pairs(i, 2)) = currState;
        currState = currState + 1;
    end
    
    for i = 1:n1
        if ~states1(i)
            states1(i) = currState;
            currState = currState + 1;
        end
    end
    
    for i = 1:n2
        if ~states2(i)
            states2(i) = currState;
            currState = currState + 1;
        end
    end
    
    Kparams = [1 0 1; 0 1 1; 0 0 0];
    cameraTweaks = {'K', Kparams, 0;...
                    'kc', 'all', 0};                        % tweak intrinsics for 1 state 
    extrinsticTweaks = {{'r', 't'}, 'all', 1};                % tweak extrinsics for 1 state
    extrinsticTweaksn = {{'r', 't'}, 'all', 1:nPositions};  % tweak extrinsics for each of n states
    unknownMsn = cell(nPositions, 1);                     % unknown transformation matrices 
                                                            % for each of n
                                                            % states
    
    initOpt = caliber.initopt.InitOpt();
    initOpt.addNode('camera1', 'root', {eye(4)}, data1, cameraTweaks);
    initOpt.addNode('camera2', 'camera1', {[]}, data2, [cameraTweaks; extrinsticTweaks]);
    initOpt.addNode('pointset', 'root', unknownMsn, struct(), extrinsticTweaksn);
    
    for i = 1:n1
        observation = caliber.observation.IndependentObservation('camera1', 'pointset', imagePoints1{i}, worldPoints1{i}, Q1{i}, containers.Map({'pointset'}, {states1(i)}));
        initOpt.addObservation(observation);
    end
    
    for i = 1:n2
        observation = caliber.observation.IndependentObservation('camera2', 'pointset', imagePoints2{i}, worldPoints2{i}, Q2{i}, containers.Map({'pointset'}, {states2(i)}));
        initOpt.addObservation(observation);
    end
    
    optimizer = initOpt.solve();
end

