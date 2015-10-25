function [tree, initializer, optimizer] = nonoverlap( resultFiles, positions, doLoocv )
    import containers.Map
    import caliber.io.bouguet
    close all;
    
    if nargin < 3
        doLoocv = 0;
    end
    
    numPositions = length(positions);
    numCameras = length(resultFiles);
    
    unknownMsn = cell(numPositions, 1);
    
    imagePoints = cell(numPositions, numCameras);
    worldPoints = cell(numPositions, numCameras);
    Q = cell(numPositions, numCameras);
    data = cell(1, numCameras);
    
    
    for i = 1:numCameras
        [imagePoints(:, i), worldPoints(:, i), Q(:, i), data{i}] = bouguet(resultFiles{i}, positions);
    end
    
    tree = caliber.tree.Tree();
    tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
    
    tree.addNode(caliber.node.GeneralNode('pointset1', 'root', struct(), {eye(4)}));
    for i = 2:numCameras
        pointset = sprintf('pointset%d', i);
        tree.addNode(caliber.node.GeneralNode(pointset, 'pointset1', struct(), {[]}));
    end

    tree.addNode(caliber.node.GeneralNode('camera1', 'root', data{1}, unknownMsn));
    for i = 2:numCameras
        camera = sprintf('camera%d', i);
        tree.addNode(caliber.node.GeneralNode(camera, 'camera1', data{i}, {[]}));
    end
    
    for i = 1:numPositions
        for j = 1:numCameras
            camera = sprintf('camera%d', j);
            pointset = sprintf('pointset%d', j);
            observation = caliber.observation.IndependentObservation(camera, pointset, imagePoints{i, j}, worldPoints{i, j}, Q{i, j}, Map({'camera1'}, {i}));
            tree.addObservation(observation);
        end
    end
    
    tree.plotTree();

    if doLoocv
        [initializer, optimizer] = tree.loocv('auto');
        caliber.plot.plotPixelErrors(optimizer);
        title('LOOCV pixel errors');
    else
        initializer = caliber.init.Initializer(tree);
        optimizer = caliber.opt.Optimizer(tree);
        optimizer.addTweaks('auto');
        initializer.solve();

        tree.plotExtrinsics();
        tree.plotPixelErrors();
        title('Kinematic estimation pixel errors');

        optimizer.solve();

        tree.plotExtrinsics();
        tree.plotPixelErrors();
        title('Nonlinear optimization pixel errors');
        optimizer.printSolutionInfo();
    end
end

