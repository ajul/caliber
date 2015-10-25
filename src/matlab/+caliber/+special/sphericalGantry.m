function [tree, initializer, optimizer] = sphericalGantry( datafile, baseAngles, armAngles, imageStates, doLoocv )
%SPHERICALGANTRY 
% imageStates: n x 2 array; rows are state indices [baseState, armState]
    import containers.Map
    import caliber.io.bouguet
    import caliber.opt.getTweakTableRow
    import caliber.math.*
    import caliber.plot.*
    import caliber.math.projection.*
    close all;
    
    if nargin < 5
        doLoocv = 0;
    end
    
    numImages = size(imageStates, 1);
    
    [imagePoints, worldPoints, Q, data] = bouguet(datafile, 1:numImages);

    baseMatrices = cell(size(baseAngles));
    for i = 1:numel(baseAngles)
        baseMatrices{i} = [axisAngle([0; 0; baseAngles(i)]), zeros(3, 1); 0 0 0 1];
    end
    
    armMatrices = cell(size(armAngles));
    for i = 1:numel(armAngles)
        angle = armAngles(i);
        armMatrices{i} = [axisAngle([angle; 0; 0]), zeros(3, 1); 0 0 0 1];
    end
    
    tree = caliber.tree.Tree();
    tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
    
    tree.addNode(caliber.node.GeneralNode('pointset', 'root', struct(), {[]}));
    tree.addNode(caliber.node.GeneralNode('base_rotation', 'root', struct(), baseMatrices));
    tree.addNode(caliber.node.GeneralNode('arm', 'base_rotation', struct(), {[]}));
    tree.addNode(caliber.node.GeneralNode('arm_rotation', 'arm', struct(), armMatrices));
    tree.addNode(caliber.node.GeneralNode('camera', 'arm_rotation', data, {[]}));
    
    for i = 1:numImages
        observation = caliber.observation.IndependentObservation('camera', 'pointset', imagePoints{i}, worldPoints{i}, Q{i}, ...
            Map({'base_rotation', 'arm_rotation'}, {imageStates(i, 1), imageStates(i, 2)}));
        tree.addObservation(observation);
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

