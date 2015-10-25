classdef IndependentObservation < caliber.observation.StandardObservation
    %TREEOBS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        worldPoints;    % 3 x n matrix of world points
        Q;              % estimated transformation
    end
    
    methods
        function obj = IndependentObservation(cameraNodeName, pointNodeName, imagePoints, worldPoints, Q, cameraStates, pointStates)
            if ~ischar(cameraNodeName)
                error('caliber:observation', ...
                    'cameraNodeName must be a string, got type ''%s'' instead', ...
                    class(cameraNodeName));
            end
            
            if ~ischar(pointNodeName)
                error('caliber:observation', ...
                    'pointNodeName must be a string, got type ''%s'' instead', ...
                    class(pointNodeName));
            end
            
            if ~isa(cameraStates, 'containers.Map')
                error('caliber:observation', ...
                    'cameraStates must be of type ''containers.Map'', got type ''%s'' instead', ...
                    class(cameraStates));
            end
            
            if nargin < 7
                obj.pointStates = cameraStates;
            else
                obj.pointStates = pointStates;
            end
            
            if ~isa(obj.pointStates, 'containers.Map')
                error('caliber:observation', ...
                    'pointStates must be of type ''containers.Map'', got type ''%s'' instead', ...
                    class(pointStates));
            end
            
            obj.cameraNodeName = cameraNodeName;
            obj.pointNodeName = pointNodeName;
            obj.Q = Q;
            obj.imagePoints = imagePoints;
            obj.worldPoints = worldPoints;
            obj.cameraStates = cameraStates;
            
        end
        
        function Qs = estimatedTransformations(obj) 
            Qs = {obj.cameraNode, obj.pointNode, obj.cameraStateIndices, obj.pointStateIndices, obj.Q};
        end
        
        function syn = makeSynthetic(obj, sigma)
            synImagePoints = obj.projectedImage();
            synImagePoints = sigma * randn(size(synImagePoints)) + synImagePoints;
            if isempty(obj.Q)
                synQ = obj.relativeM();
            else
                synQ = obj.Q;
            end
            syn = caliber.observation.IndependentObservation(obj.cameraNodeName, obj.pointNodeName, ...
                synImagePoints, obj.worldPoints, synQ, obj.cameraStates, obj.pointStates);
        end
        
        function clo = clone(obj)
            clo = caliber.observation.IndependentObservation(obj.cameraNodeName, obj.pointNodeName, ...
                obj.imagePoints, obj.worldPoints, obj.Q, obj.cameraStates, obj.pointStates);
        end
    end
    
    methods (Access = protected)
        
        function points = getPoints(obj)
            points = obj.worldPoints;
        end
        
        function dpredErr = nonstandardJacobian(obj, tweak)
            dpredErr = sparse(size(obj.worldPoints, 2) * 2, nnz(tweak.paramIndices));
        end
    end
end
