function [ tree, initializer, optimizer ] = ladybug00(synSigma, doLoocv)
%LADYBUG00 Summary of this function goes here
%   Detailed explanation goes here

    close all;
    
    if nargin < 2
        doLoocv = 0;
    end

    if nargin < 1
        synSigma = 0;
    end

    images = 1:13;
    cameras = 1:5;
    
    % flags
    identicalCameras = 1;
    useStockData = 0;
    
    numDistortion = 6;

    % full set
    pointsetIndices =    [
        1 1 1 1 1 1 1 5 5 5 5 5 5 2 0;...
        2 2 2 2 2 2 2 1 1 1 1 1 1 0 0;... 
        3 3 3 3 3 3 3 2 2 2 2 2 2 4 2;... 
    	4 4 4 4 4 4 4 3 3 3 3 3 3 5 3;... 
    	5 5 5 5 5 5 5 4 4 4 4 4 4 1 4;...
        ];

%     pointsetIndices =    [
%         1 1 1 1 1 1 1 5 5 5 5 5 5 2 0;...
%         2 2 2 2 2 2 2 1 1 1 1 1 1 0 0;... 
%         3 3 3 3 3 3 0 2 2 2 2 2 2 4 0;... 
%     	4 4 4 4 4 4 4 3 3 3 3 3 3 5 0;... 
%     	5 5 5 5 5 5 5 4 4 4 4 4 4 1 4;...
%         ];  
    
    %positionIndices = [1:13 7 4];
    positionIndices = [1:13 7 4];
    
    imagePoints = cell(size(cameras));
    worldPoints = cell(size(cameras));
    Q = cell(size(cameras));
    data = cell(size(cameras));
    
    for i = 1:numel(cameras)
        filename = sprintf('caliber_data/ladybug00/results%d.mat', i);
        [imagePoints{i}, worldPoints{i}, Q{i}, data{i}] = caliber.io.bouguet(filename, 1:find(pointsetIndices(i, :), 1, 'last'));
        rawDistortion = data{i}.kc;
        numRawDistortion = numel(rawDistortion);
        if numDistortion > numRawDistortion
            distortion = zeros(numDistortion, 1);
            distortion(1:numRawDistortion) = rawDistortion;
            data{i}.kc = distortion;
        else
            data{i}.kc = rawDistortion(1:numDistortion);
        end
    end
    
    tree = caliber.tree.Tree();
    
    if identicalCameras
        tree.addNode(caliber.node.GeneralNode('root', [], struct(), {}));
        
        if useStockData
            cameraMs = stockCal();
        else
            cameraMs = cell(1, 5);
            cameraMs{1} = eye(4);
        end
        tree.addNode(caliber.node.GeneralNode('camera', 'root', data{1}, cameraMs));
        
        tree.addNode(caliber.node.GeneralNode('pointset1', 'root', struct(), cell(1, max(positionIndices(images)))));
        for i = 2:max(max(pointsetIndices(cameras, :)))
            pointsetName = sprintf('pointset%d', i);
            tree.addNode(caliber.node.GeneralNode(pointsetName, 'pointset1', struct(), {[]}));
        end

        for i = 1:numel(cameras)
            camera = cameras(i);
            for j = 1:numel(images)
                image = images(j);
                pointset = pointsetIndices(camera, image);
                if pointset == 0
                    continue;
                end
                pointsetName = sprintf('pointset%d', pointset);
                position = positionIndices(image);
                observation = caliber.observation.IndependentObservation('camera', pointsetName, ...
                    imagePoints{camera}{image}, worldPoints{camera}{image}, Q{camera}{image}, containers.Map({'camera', 'pointset1'}, {camera, position}));
                tree.addObservation(observation);
            end
        end
    else
        if useStockData
            cameraMs = stockCal();
        else
            cameraMs = cell(1, 5);
        end
        tree.addNode(caliber.node.GeneralNode('camera1', [], data{1}, {}));
        for i = 2:numel(cameras)
            cameraName = sprintf('camera%d', i);
            tree.addNode(caliber.node.GeneralNode(cameraName, 'camera1', data{i}, cameraMs(i)));
        end
        
        tree.addNode(caliber.node.GeneralNode('pointset1', 'camera1', struct(), cell(1, max(positionIndices(images)))));
        for i = 2:max(max(pointsetIndices(cameras, :)))
            pointsetName = sprintf('pointset%d', i);
            tree.addNode(caliber.node.GeneralNode(pointsetName, 'pointset1', struct(), {[]}));
        end
        
        for i = 1:numel(cameras)
            camera = cameras(i);
            cameraName = sprintf('camera%d', camera);
            for j = 1:numel(images)
                image = images(j);
                pointset = pointsetIndices(camera, image);
                if pointset == 0
                    continue;
                end
                
                pointsetName = sprintf('pointset%d', pointset);
                position = positionIndices(image);
                observation = caliber.observation.IndependentObservation(cameraName, pointsetName, ...
                    imagePoints{camera}{image}, worldPoints{camera}{image}, Q{camera}{image}, containers.Map({'pointset1'}, {position}));
                tree.addObservation(observation);
            end
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
        
        if synSigma > 0
            synOpt = optimizer.makeSynthetic(synSigma);
            synOpt.loocv();
        end
    end
end

function stockMs = stockCal()
    stockData = [-1.168758 1.561528 -1.168629 0.041806 -0.001857 -0.000046;...
        -2.305427 1.563318 2.725116 0.011610 -0.039996 -0.000357;...
        -2.362743 1.558137 1.410379 -0.034564 -0.023102 -0.000246;...
        -1.036126 1.561567 1.480476 -0.033344 0.025822 0.000475;...
        2.608381 1.569996 -2.420058 0.014492 0.039132 0.000173;
        ];

    stockData(:, 4:6) = stockData(:, 4:6) * 1e3;

    rawMs = cell(1, 5);

    for i = 1:5
        rawMs{i} = caliber.math.eulerZYX(stockData(i, :));
    end
    
    % hacky hacky hacky
    
    stockMs = cell(1, 5);
    stockMs{1} = eye(4);
    for i = 2:5
        stockM = rawMs{1} \ rawMs{i};
        stockM(1:3, 1:3) = stockM(1:3, 1:3)';
        stockMs{i} = stockM;
    end
end
