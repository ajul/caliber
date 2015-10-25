classdef Observation < handle
    %OBSERVATION Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function b = isBound(obj)
            b = ~isempty(obj.cameraStateIndices);
        end
        
        function plotImagePoints(obj)
            % Creates a full plot of the image points for this observation. Default does nothing.
            warning('caliber:plot', ...
                'plotImagePoints() not implemented for class %s.', class(obj));
        end
        
        function drawExtrinsics(obj, scale)
            % Draws a 3-D representation of this observation, to be used
            % inside a larger plot function or method. Default does
            % nothing.
            warning('caliber:plot', ...
                'drawExtrinsics(scale) not implemented for class %s.', class(obj));
        end
        
        function M = relativeM(obj)
            % gets the relative transformation between 
            M = obj.cameraNode.relativeM(obj.pointNode, obj.cameraStateIndices, obj.pointStateIndices);
        end
        
        function syn = makeSynthetic(obj)
            error('caliber:observation', 'makeSynthetic() not implemented for class %s.', class(obj));
        end
        
        function clo = clone(obj)
            error('caliber:observation', 'clone() not implemented for class %s.', class(obj));
        end
        
        function updateFull(obj, optimizer)
            % default behavior does nothing
        end
        
        % called at the beginning of each iteration after tweaks have
        % been assigned
        function updateIteration(obj)
            % default behavior does nothing
        end
    end
    
    methods (Abstract)
        % uses tree to resolve node names
        bind(obj, tree)
        
        % gets estimated transformation matrices
        % cell array whose rows are {nodeFrom, nodeTo, nodeFromStates,
        % nodeToStates, transformationMatrix}
        Qs = estimatedTransformations(obj);
        
        % computes the projected image as a matrix
        imagePoints = projectedImage(obj)
        
        % computes the difference between the reprojection and the observed
        % points as a column vector
        imageError = reprojectionError(obj)
        
        % computes the derivative of the image points with respect to the
        % given parameter
        errorJacobian = reprojectionErrorJacobian(obj, tweak)
    end
    
end
