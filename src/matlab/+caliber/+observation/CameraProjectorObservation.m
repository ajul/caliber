classdef CameraProjectorObservation < caliber.observation.Observation
    %CAMERAPROJECTOROBSERVATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        projectorNodeName;
        screenNodeName;
        cameraNodeName;     
        
        projectorStates;    	% containers.Map node names -> states
        screenStates;
        cameraStates;       % containers.Map node names -> states
        
        
        % derived props
        projectorNode;          % point node (handle)
        screenNode;
        cameraNode;         % camera node (handle)
        
        projectorStateIndices;
        screenStateIndices;
        cameraStateIndices;
        
        projectorImagePoints;
        cameraImagePoints;
        
        Q;
        
        projectorK;
        projectorkc;
        projectorM;
        
        cameraK;
        camerakc;
        cameraM;
    end
    
    methods
        
        function obj = CameraProjectorObservation(projectorNodeName, screenNodeName, cameraNodeName, projectorImagePoints, cameraImagePoints, Q, projectorStates, screenStates, cameraStates)
            % Q: tranformation from projector to camera
            if nargin < 8
                obj.screenStates = projectorStates;
            else
                obj.screenStates = screenStates;
            end
            
            if nargin < 9
                obj.cameraStates = projectorStates;
            else
                obj.cameraStates = cameraStates;
            end
            
            obj.projectorStates = projectorStates;
            
            obj.projectorNodeName = projectorNodeName;
            obj.screenNodeName = screenNodeName;
            obj.cameraNodeName = cameraNodeName;
            obj.projectorImagePoints = projectorImagePoints;
            obj.cameraImagePoints = cameraImagePoints;
            
            obj.Q = Q;
        end
    
        function bind(obj, tree)
            obj.cameraNode = tree.getNode(obj.cameraNodeName);
            obj.projectorNode = tree.getNode(obj.projectorNodeName);
            obj.screenNode = tree.getNode(obj.screenNodeName);
            
            obj.projectorStateIndices = tree.getStateIndices(obj.projectorStates);
            obj.screenStateIndices = tree.getStateIndices(obj.screenStates);
            obj.cameraStateIndices = tree.getStateIndices(obj.cameraStates);
        end
        
        function updateIteration(obj)
            obj.projectorM = obj.projectorNode.relativeM(obj.screenNode, obj.projectorStateIndices, obj.screenStateIndices);
            obj.projectorkc = obj.projectorNode.data.kc;
            obj.projectorK = obj.projectorNode.data.K;
            
            obj.cameraM = obj.cameraNode.relativeM(obj.screenNode, obj.cameraStateIndices, obj.screenStateIndices);
            obj.camerakc = obj.cameraNode.data.kc;
            obj.cameraK = obj.cameraNode.data.K;
        end
        
        function Qs = estimatedTransformations(obj) 
            Qs = {obj.projectorNode, obj.cameraNode, obj.projectorStateIndices, obj.cameraStateIndices, obj.Q};
        end
        
        function predImage = projectedImage(obj)
            worldPoints = caliber.math.projection.standardReverseProjection(obj.projectorK, obj.projectorkc, obj.projectorM, obj.projectorImagePoints);
            predImage = caliber.math.projection.standardProjection(obj.cameraK, obj.camerakc, obj.cameraM, worldPoints);
        end
        
        function predErr = reprojectionError(obj)
            % compute the errors in the predicted image points
            % returns a 2n x 1 vector of errors
            predPoints = obj.projectedImage();
            predErr = reshape(predPoints - obj.cameraImagePoints, size(predPoints, 2) * 2, 1);
        end
        
        function J = reprojectionErrorJacobian(obj, tweak)
            
            worldPoints = caliber.math.projection.standardReverseProjection(obj.projectorK, obj.projectorkc, obj.projectorM, obj.projectorImagePoints);
            
            % projector-side extrinsics
            [dMs, tweakIndices] = obj.projectorNode.dRelativeMs(obj.screenNode, obj.projectorStateIndices, obj.screenStateIndices, tweak);
            numIndices = numel(tweakIndices);
            rows = (1:(size(worldPoints, 2) * 2))' * ones(1, numIndices);
            cols = zeros(size(worldPoints, 2) * 2, numIndices);
            values = zeros(size(worldPoints, 2) * 2, numIndices);
            for i = 1:numIndices
                cols(:, i) = tweakIndices(i);
                dWorldPoints = caliber.math.projection.standardReverseProjection(obj.projectorK, obj.projectorkc, obj.projectorM, obj.projectorImagePoints, 3, dMs{i});
                dPredImage = caliber.math.projection.standardProjection(obj.cameraK, obj.camerakc, obj.cameraM, worldPoints, 4, dWorldPoints);
                values(:, i) = reshape(dPredImage, size(worldPoints, 2) * 2, 1);
            end
            JProjectorExtrinsics = sparse(rows, cols, values, size(worldPoints, 2) * 2, nnz(tweak.paramIndices));
            
            % camera-side extrinsics
            [dMs, tweakIndices] = obj.cameraNode.dRelativeMs(obj.screenNode, obj.cameraStateIndices, obj.screenStateIndices, tweak);
            numIndices = numel(tweakIndices);
            rows = (1:(size(worldPoints, 2) * 2))' * ones(1, numIndices);
            cols = zeros(size(worldPoints, 2) * 2, numIndices);
            values = zeros(size(worldPoints, 2) * 2, numIndices);
            for i = 1:numIndices
                cols(:, i) = tweakIndices(i);
                dPredImage = caliber.math.projection.standardProjection(obj.cameraK, obj.camerakc, obj.cameraM, worldPoints, 3, dMs{i});
                values(:, i) = reshape(dPredImage, size(worldPoints, 2) * 2, 1);
            end
            JCameraExtrinsics = sparse(rows, cols, values, size(worldPoints, 2) * 2, nnz(tweak.paramIndices));
            
            numParams = nnz(tweak.paramIndices);
            
            % intrinsics
            switch(tweak.paramName)
                case {'kc'}
                    if tweak.node == obj.projectorNode
                        dkcs = tweak.dValues();
                        JProjectorIntrinsics = zeros(size(worldPoints, 2) * 2, numParams);
                        for i = 1:numParams
                            dWorldPoints = caliber.math.projection.standardReverseProjection(obj.projectorK, obj.projectorkc, obj.projectorM, obj.projectorImagePoints, 2, dkcs{i});
                            col = caliber.math.projection.standardProjection(obj.cameraK, obj.camerakc, obj.cameraM, worldPoints, 4, dWorldPoints);
                            JProjectorIntrinsics(:, i) = reshape(col, size(worldPoints, 2) * 2, 1);
                        end
                    else
                        JProjectorIntrinsics = sparse(0);
                    end
                    
                    if tweak.node == obj.cameraNode
                        dkcs = tweak.dValues();
                        JCameraIntrinsics = zeros(size(worldPoints, 2) * 2, numParams);
                        for i = 1:numParams
                            col = caliber.math.projection.standardProjection(obj.cameraK, obj.camerakc, obj.cameraM, worldPoints, 2, dkcs{i});
                            JCameraIntrinsics(:, i) = reshape(col, size(worldPoints, 2) * 2, 1);
                        end
                    else
                        JCameraIntrinsics = sparse(0);
                    end
                    JIntrinsics = JProjectorIntrinsics + JCameraIntrinsics;
                    
                case {'K'}
                    if tweak.node == obj.projectorNode
                        dKs = tweak.dValues();
                        JProjectorIntrinsics = zeros(size(worldPoints, 2) * 2, numParams);
                        for i = 1:numParams
                            dWorldPoints = caliber.math.projection.standardReverseProjection(obj.projectorK, obj.projectorkc, obj.projectorM, obj.projectorImagePoints, 1, dKs{i});
                            col = caliber.math.projection.standardProjection(obj.cameraK, obj.camerakc, obj.cameraM, worldPoints, 4, dWorldPoints);
                            JProjectorIntrinsics(:, i) = reshape(col, size(worldPoints, 2) * 2, 1);
                        end
                    else
                        JProjectorIntrinsics = sparse(0);
                    end
                    
                    if tweak.node == obj.cameraNode
                        dKs = tweak.dValues();
                        JCameraIntrinsics = zeros(size(worldPoints, 2) * 2, numParams);
                        for i = 1:numParams
                            col = caliber.math.projection.standardProjection(obj.cameraK, obj.camerakc, obj.cameraM, worldPoints, 1, dKs{i});
                            JCameraIntrinsics(:, i) = reshape(col, size(worldPoints, 2) * 2, 1);
                        end
                    else
                        JCameraIntrinsics = sparse(0);
                    end
                    JIntrinsics = JProjectorIntrinsics + JCameraIntrinsics;
                otherwise
                    JIntrinsics = sparse(0);
            end

            J = JProjectorExtrinsics + JCameraExtrinsics + JIntrinsics;
        end
        
        function plotImagePoints(obj)
            caliber.plot.plotImagePoints(obj.cameraImagePoints, obj.projectedImage());
            title(sprintf('%s:%s to %s:%s to %s:%s', ...
                obj.projectorNode.name, obj.projectorNode.getStateString(obj.projectorStateIndices), ...
                obj.screenNode.name, obj.screenNode.getStateString(obj.screenStateIndices), ...
                obj.cameraNode.name, obj.cameraNode.getStateString(obj.cameraStateIndices)));
        end
    end
    
end

