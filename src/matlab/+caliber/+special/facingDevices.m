function [tree, initializer, optimizer] = facingDevices( deviceFile1, deviceFile2, positions, doLoocv )
%FACINGDEVICES Function for calibrating two facing devices 
% that each have a camera and a displayed pointset.
% deviceFile1, deviceFile2: Calib_results.mat for the two cameras.
%   Remember that each camera takes a picture of the *other* device's
%   pointset.
% positions: Cell vector indicating which indices within those files to
%   use.
    import caliber.io.bouguet
    import containers.Map
    
    if nargin < 4
        doLoocv = 0;
    end
    
    numPositions = length(positions);
    
    imagePoints = cell(numPositions, 2);
    worldPoints = cell(numPositions, 2);
    Q = cell(numPositions, 2);
    data = cell(1, 2);
    
    [imagePoints(:, 1), worldPoints(:, 1), Q(:, 1), data{1}] = bouguet(deviceFile1, positions);
    [imagePoints(:, 2), worldPoints(:, 2), Q(:, 2), data{2}] = bouguet(deviceFile2, positions);
    
    tree = caliber.tree.Tree();
    tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
    tree.addNode(caliber.node.GeneralNode('pointset1', 'root', struct(), {eye(4)}));
    tree.addNode(caliber.node.GeneralNode('camera1', 'pointset1', data{1}, {[]}));
    tree.addNode(caliber.node.GeneralNode('pointset2', 'root', struct(), cell(numPositions, 1)));
    tree.addNode(caliber.node.GeneralNode('camera2', 'pointset2', data{2}, {[]}));
    
    for i = 1:numPositions
        observation = caliber.observation.IndependentObservation('camera1', 'pointset2', imagePoints{i, 1}, worldPoints{i, 1}, Q{i, 1}, Map({'pointset2'}, {i}));
        tree.addObservation(observation);
        observation = caliber.observation.IndependentObservation('camera2', 'pointset1', imagePoints{i, 2}, worldPoints{i, 2}, Q{i, 2}, Map({'pointset2'}, {i}));
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

