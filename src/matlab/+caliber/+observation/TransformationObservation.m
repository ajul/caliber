classdef TransformationObservation < caliber.observation.Observation
    %TRANSFORMATIONOBSERVATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        M;
        Q;
    end
    
    methods
        function obj = TransformationObservation(cameraName, pointName, Q, cameraStates, pointStates) 
            obj.cameraNodeName = cameraName;
            obj.pointNodeName = pointName;
            obj.Q = Q;
            
            obj.cameraStates = cameraStates;
            if nargin >= 5
                obj.pointStates = pointStates;
            else
                obj.pointStates = cameraStates;
            end
        end
        
        function Q = getQ(obj) 
            Q = obj.Q;
        end
        
        function updateIteration(obj)
            obj.M = obj.cameraNode.relativeM(obj.pointNode, obj.cameraStateIndices, obj.pointStateIndices);
        end
        
        function predImage = projectedImage(obj)
            % computes the current predicted image
            predImage = obj.M;
        end
        
        function predErr = reprojectionError(obj)
            % compute the errors in the predicted image points
            % returns a 2n x 1 vector of errors
            predPoints = obj.projectedImage();
            predErr = reshape(predPoints - obj.Q, 16, 1);
        end
        
        function J = reprojectionErrorJacobian(obj, tweak)
            % compute the derivatives of the errors in the predicted image points
            % returns a 2n x nnz(tweak.paramIndices) vector of derivatives
            
            [dMs, tweakIndices] = obj.cameraNode.dRelativeMs(obj.pointNode, obj.cameraStateIndices, obj.pointStateIndices, tweak);
            rows = (1:16)' * ones(1, numel(tweakIndices));
            cols = zeros(16, numel(tweakIndices));
            values = zeros(16, numel(tweakIndices));
            for i = 1:numel(tweakIndices)
                cols(:, i) = tweakIndices(i);
                dPoints = dMs{i};
                values(:, i) = reshape(dPoints, 16, 1);
            end
            J = sparse(rows, cols, values, 16, nnz(tweak.paramIndices));
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
        end
    end
    
end

