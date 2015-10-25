classdef StandardObservation < caliber.observation.Observation
    %STANDARDOBSERVATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        cameraNodeName;     
        pointNodeName;
        cameraStates;       % containers.Map node names -> states
        pointStates;    	% containers.Map node names -> states
        
        % derived props
        cameraNode;         % camera node (handle)
        pointNode;          % point node (handle)
        cameraStateIndices;
        pointStateIndices;
        
        imagePoints;
        
        M;
        kc;
        K;
    end
    
    methods
        function bind(obj, tree)
            obj.cameraNode = tree.getNode(obj.cameraNodeName);
            obj.pointNode = tree.getNode(obj.pointNodeName);
            
            obj.cameraStateIndices = tree.getStateIndices(obj.cameraStates);
            obj.pointStateIndices = tree.getStateIndices(obj.pointStates);
        end
        
        function updateIteration(obj)
            obj.M = obj.cameraNode.relativeM(obj.pointNode, obj.cameraStateIndices, obj.pointStateIndices);
            obj.kc = obj.cameraNode.data.kc;
            obj.K = obj.cameraNode.data.K;
        end
        
        function predImage = projectedImage(obj)
            % computes the current predicted image
            points = obj.getPoints();
            predImage = caliber.math.projection.standardProjection(obj.K, obj.kc, obj.M, points);
        end
        
        function predImage = origProjectedImage(obj)
            % computes the starting predicted image
            points = obj.getPoints();
            predImage = caliber.math.projection.standardProjection(obj.cameraNode.data.K, obj.cameraNode.data.kc, obj.Q, points);
        end
        
        function predErr = reprojectionError(obj)
            % compute the errors in the predicted image points
            % returns a 2n x 1 vector of errors
            predPoints = obj.projectedImage();
            predErr = reshape(predPoints - obj.imagePoints, size(predPoints, 2) * 2, 1);
        end
        
        function J = reprojectionErrorJacobian(obj, tweak)
            % compute the derivatives of the errors in the predicted image points
            % returns a 2n x nnz(tweak.paramIndices) vector of derivatives
            
            numParams = nnz(tweak.paramIndices);
            points = obj.getPoints();
            [dMs, tweakIndices] = obj.cameraNode.dRelativeMs(obj.pointNode, obj.cameraStateIndices, obj.pointStateIndices, tweak);
            numIndices = numel(tweakIndices);
            rows = (1:(size(points, 2) * 2))' * ones(1, numIndices);
            cols = zeros(size(points, 2) * 2, numIndices);
            values = zeros(size(points, 2) * 2, numIndices);
            for i = 1:numIndices
                cols(:, i) = tweakIndices(i);
                dPoints = caliber.math.projection.standardProjection(obj.K, obj.kc, obj.M, points, 3, dMs{i});
                values(:, i) = reshape(dPoints, size(points, 2) * 2, 1);
            end
            Jextrinsic = sparse(rows, cols, values, size(points, 2) * 2, nnz(tweak.paramIndices));

            switch(tweak.paramName)
                case {'kc'}
                    points = obj.getPoints();
                    if tweak.node ~= obj.cameraNode
                        Jintrinsic = sparse([], [], [], size(points, 2) * 2, nnz(tweak.paramIndices));
                    else
                        dkcs = tweak.dValues();
                        Jintrinsic = zeros(size(points, 2) * 2, numParams);
                        for i = 1:numParams
                            col = caliber.math.projection.standardProjection(obj.K, obj.kc, obj.M, points, 2, dkcs{i});
                            Jintrinsic(:, i) = reshape(col, size(points, 2) * 2, 1);
                        end
                    end
                case {'K'}
                    points = obj.getPoints();
                    if tweak.node ~= obj.cameraNode
                        Jintrinsic = sparse([], [], [], size(points, 2) * 2, nnz(tweak.paramIndices));
                    else
                        dKs = tweak.dValues();
                        Jintrinsic = zeros(size(points, 2) * 2, numParams);
                        for i = 1:numParams
                            col = caliber.math.projection.standardProjection(obj.K, obj.kc, obj.M, points, 1, dKs{i});
                            Jintrinsic(:, i) = reshape(col, size(points, 2) * 2, 1);
                        end
                    end
                otherwise
                    Jintrinsic = nonstandardJacobian(obj, tweak);
            end
            
            J = Jextrinsic + Jintrinsic;
        end
        
        function plotImagePoints(obj)
            caliber.plot.plotImagePoints(obj.imagePoints, obj.projectedImage());
            title(sprintf('%s:%s to %s:%s', obj.cameraNode.name, obj.cameraNode.getStateString(obj.cameraStateIndices),...
                obj.pointNode.name, obj.pointNode.getStateString(obj.pointStateIndices)));
        end
        
        function plotOrigImagePoints(obj)
            caliber.plot.plotImagePoints(obj.imagePoints, obj.origProjectedImage());
            title(sprintf('%s:%s to %s:%s', obj.cameraNode.name, obj.cameraNode.getStateString(obj.cameraStateIndices),...
                obj.pointNode.name, obj.pointNode.getStateString(obj.pointStateIndices)));
        end
        
        function drawExtrinsics(obj, scale)
            %% draw frames
            cameraLabel = sprintf('%s:%s', obj.cameraNode.name, obj.cameraNode.getStateString(obj.cameraStateIndices));
            cameraM = obj.cameraNode.depthM(obj.cameraStateIndices, 1);
            pointLabel = sprintf('%s:%s', obj.pointNode.name, obj.pointNode.getStateString(obj.pointStateIndices));
            pointM = obj.pointNode.depthM(obj.pointStateIndices, 1);
            caliber.plot.drawFrame(cameraM, scale, cameraLabel);
            caliber.plot.drawFrame(pointM, scale, pointLabel);
            
            %% connect the two frames
            
            line([cameraM(1, 4) pointM(1, 4)], [cameraM(2, 4) pointM(2, 4)], [cameraM(3, 4) pointM(3, 4)],... 
                'Color', [0.9375 0.9375 0.9375], 'LineStyle', '--');
            
            %% draw camera frustrum
            if isfield(obj.cameraNode.data, 'resolution')
                resolution = obj.cameraNode.data.resolution;
                caliber.plot.drawCameraFrustrum( cameraM, obj.K, resolution, scale )
            end
            
            %% draw point bounding box
            pointBoxColor = [0.75 0.75 0.75];
            points = obj.getPoints();
            pointBounds = [min(points, [], 2) max(points, [], 2)];
            boxCoords = zeros(3, 2, 2, 2);
            for i = 1:2
                for j = 1:2
                    for k = 1:2
                        corner = [pointBounds(1, i); pointBounds(2, j); pointBounds(3, k)];
                        corner = pointM * [corner; 1];
                        boxCoords(:, i, j, k) = corner(1:3);
                    end
                end
            end
            
            for i = 1:2
                for j = 1:2
                    line([boxCoords(1, 1, i, j) boxCoords(1, 2, i, j)],...
                        [boxCoords(2, 1, i, j) boxCoords(2, 2, i, j)],...
                        [boxCoords(3, 1, i, j) boxCoords(3, 2, i, j)],...
                        'Color', pointBoxColor);
                    line([boxCoords(1, i, 1, j) boxCoords(1, i, 2, j)],...
                        [boxCoords(2, i, 1, j) boxCoords(2, i, 2, j)],...
                        [boxCoords(3, i, 1, j) boxCoords(3, i, 2, j)],...
                        'Color', pointBoxColor);
                    line([boxCoords(1, i, j, 1) boxCoords(1, i, j, 2)],...
                        [boxCoords(2, i, j, 1) boxCoords(2, i, j, 2)],...
                        [boxCoords(3, i, j, 1) boxCoords(3, i, j, 2)],...
                        'Color', pointBoxColor);
                end
            end
        end
        
        function K = getK(obj)
           K = [diag(obj.data.f) obj.data.pp; 0 0 1]; 
        end
        
        function dKs = getdKs(obj, tweak)
            dKs = cell(1, 2);
            if tweak.node ~= obj.cameraNode
                return;
            end
            switch(tweak.paramName)
                case 'f'
                    for i = 1:2
                        if tweak.paramIndices(i)
                            dKs{i}(i, i) = 1;
                        end
                    end
                case 'pp'
                    for i = 1:2
                        if tweak.paramIndices(i)
                            dKs{i}(i, 3) = 1;
                        end
                    end
                otherwise
                    error('caliber:internal', 'non-''f'' or ''pp'' tweak given to getdK()');
            end
        end
    end
    
    methods (Abstract, Access = protected)
        points = getPoints(obj)
        
        J = nonstandardJacobian(obj, tweak)
    end
    
end

