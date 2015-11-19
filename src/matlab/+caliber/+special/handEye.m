function [tree, initializer, optimizer] = handEye( datafile, armMatrices, doLoocv )
% Basic hand-eye calibration with a single camera and static pointset.
% datafile: Bouguet file containing n images from the eye.
% armMatrices: cell of n matrices between the base of the arm and the hand
% It is assumed that the order of the images in the datafile and the order of the corresponding armMatrices are the same.
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
    
    numImages = numel(armMatrices);
    
    [imagePoints, worldPoints, Q, data] = bouguet(datafile, 1:numImages);
    
    tree = caliber.tree.Tree();
    tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
    
    % The first argument is the name of the node being added.
    % The second argument is the name of the parent node.
    % The third argument is any intrinsic data associated with the node.
    % The fourth argument is a list of states represented by transformation matrices relative to the parent. 
    % An empty matrix represents an unknown transformation.
    tree.addNode(caliber.node.GeneralNode('pointset', 'root', struct(), {[]}));
    tree.addNode(caliber.node.GeneralNode('hand', 'root', struct(), armMatrices));
    tree.addNode(caliber.node.GeneralNode('camera', 'hand', data, {[]}));
    
    for i = 1:numImages
        observation = caliber.observation.IndependentObservation('camera', 'pointset', imagePoints{i}, worldPoints{i}, Q{i}, ...
            Map({'hand'}, {i}));
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

