function [ tree, initializer, optimizer ] = gantryObject( datafile, objectAngles, cameraArmAngles)
%GANTRYPLATFORM 
% Inputs:
%   datafile: filename of Bouguet Calib_results.mat containing data for n
%   observations
%   objectAngles: n x 1 matrix containing rotations of the object base in
%   degrees
%   cameraArmAngles: n x 2 matrix containing rotations of the camera arm in
%   degrees
    import caliber.math.axisAngle

    % find unique angles of the camera arm and object
    [objectAngles, ~, objectStates] = unique(objectAngles, 'rows');
    [cameraArmAngles, ~, cameraArmStates] = unique(cameraArmAngles, 'rows');
    objectAngles = deg2rad(objectAngles);
    cameraArmAngles = deg2rad(cameraArmAngles);
    
    numObjectStates = size(objectAngles, 1);
    numCameraArmStates = size(cameraArmAngles, 1);
    numImages = length(cameraArmStates);
    
    % convert to matrices
    objectMatrices = cell(numObjectStates, 1);
    cameraArmMatrices = cell(numCameraArmStates, 1);
    
    for i = 1:numObjectStates
        objectMatrices{i} = [axisAngle([0; 0; objectAngles(i)]), zeros(3, 1); 0 0 0 1];
    end
    
    for i = 1:numCameraArmStates
        M1 = [axisAngle([0; 0; cameraArmAngles(i, 1)]), zeros(3, 1); 0 0 0 1];
        M2 = [axisAngle([cameraArmAngles(i, 2); 0; 0]), zeros(3, 1); 0 0 0 1];
        cameraArmMatrices{i} = M1 * M2;
    end
    
    % read Bouguet data
    [imagePoints, worldPoints, Q, data] = caliber.io.bouguet(datafile, 1:numImages);
    
    % construct the tree
    tree = caliber.tree.Tree();
    tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
    
    tree.addNode(caliber.node.GeneralNode('object_table', 'root', struct(), objectMatrices));
    tree.addNode(caliber.node.GeneralNode('pointset', 'object_table', struct(), {[]}));
    
    tree.addNode(caliber.node.GeneralNode('camera_base', 'root', struct(), {[]}));
    tree.addNode(caliber.node.GeneralNode('camera_arm', 'camera_base', struct(), cameraArmMatrices));
    tree.addNode(caliber.node.GeneralNode('camera', 'camera_arm', data, {[]}));
    
    % add observations
    for i = 1:numImages
        states = containers.Map({'object_table', 'camera_arm'}, {objectStates(i), cameraArmStates(i)});
        observation = caliber.observation.IndependentObservation('camera', 'pointset', imagePoints{i}, worldPoints{i}, Q{i}, states);
        tree.addObservation(observation);
    end
    
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

