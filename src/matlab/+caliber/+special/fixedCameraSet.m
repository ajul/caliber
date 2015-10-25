function [tree, initializer, optimizer] = fixedCameraSet( cameraDataFiles, positions, doLoocv )
%STEREOPAIR Function for calibrating a fixed set of cameras that can all
%see a set of pointsets.
%cameraDataFiles: cell vector of Calib_results.mat filenames for the 
%   cameras. The first camera is taken to be at the origin.
%positions: Cell vector indicating which indices within those files to
%   use.
    import containers.Map
    close all;
    
    if nargin < 3
        doLoocv = 0;
    end
    
    %% Setup.
    % Miscellaneous information.
    
    numPositions = length(positions);                       % number of pointset positions
    numCameras = length(cameraDataFiles);                   % number of cameras
    
    % Tweaks and unknowns.
    unknownMsn = cell(numPositions, 1);                     % unknown transformation matrices 
                                                            % for each of n
                                                            % states
    
    imagePoints = cell(numPositions, numCameras);           % i, j -> image points for pointset i, camera j
    worldPoints = cell(numPositions, numCameras);           % i, j -> world points for pointset i, camera j
    data = cell(1, numCameras);                             % j -> calibration matrix for camera j
    Q = cell(numPositions, numCameras);                     % i, j -> estimated camera-pointset transformation 
                                                            % for observation camera j to pointset i
    
    %% Input.
    % Read Bouguet data.
    for i = 1:numCameras
        [imagePoints(:, i), worldPoints(:, i), Q(:, i), data{i}] = caliber.io.bouguet(cameraDataFiles{i}, positions);
    end
    
    % Construct tree.
    tree = caliber.tree.Tree();
    tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
    
    % Put camera1 at the origin.
    tree.addNode(caliber.node.GeneralNode('camera1', 'root', data{1}, {eye(4)}));
    for j = 2:numCameras
        % Each other camera has unknown transformation relative to the
        % root, denoted by [].
        cameraName = sprintf('camera%d', j);
        tree.addNode(caliber.node.GeneralNode(cameraName, 'root', data{j}, {[]}));
    end
    
    % Pointset node is attached to the root. It has n unknown states.
    tree.addNode(caliber.node.GeneralNode('pointset', 'root', struct(), unknownMsn));
    
    % Add in all the observations.
    for i = 1:numPositions
        for j = 1:numCameras
            cameraName = sprintf('camera%d', j);
            observation = caliber.observation.IndependentObservation(cameraName, 'pointset', imagePoints{i, j}, worldPoints{i, j}, Q{i, j}, Map({'pointset'}, {i}));
            tree.addObservation(observation);
        end
    end
    
    %% Solve. 
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

