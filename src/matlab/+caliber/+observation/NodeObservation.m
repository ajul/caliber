classdef NodeObservation < caliber.observation.StandardObservation
    %NODEOBSERVATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        pointIndices;   % 1 x n matrix of world point indices
        Q;              % estimated transformation
    end
    
    methods
        function obj = NodeObservation(cameraNodeName, pointNodeName, imagePoints, pointIndices, Q, cameraStates, pointStates)
            if ~ischar(cameraName)
                error('caliber:observation', ...
                    'cameraNodeName must be a string, got type ''%s'' instead', ...
                    class(cameraNodeName));
            end
            
            if ~ischar(pointName)
                error('caliber:observation', ...
                    'pointNodeName must be a string, got type ''%s'' instead', ...
                    class(pointNodeName));
            end
            
            if ~isa(cameraStates, 'containers.Map')
                error('caliber:observation', ...
                    'cameraStates must be of type ''containers.Map'', got type ''%s'' instead', ...
                    class(cameraStates));
            end
            
            if ~isa(pointStates, 'containers.Map')
                error('caliber:observation', ...
                    'pointStates must be of type ''containers.Map'', got type ''%s'' instead', ...
                    class(pointStates));
            end
            
            obj.cameraNodeName = cameraNodeName;
            obj.pointNodeName = pointNodeName;
            obj.Q = Q;
            obj.imagePoints = imagePoints;
            
            obj.pointIndices = pointIndices;
            
            obj.cameraStates = cameraStates;
            if nargin >= 7
                obj.pointStates = pointStates;
            else
                obj.pointStates = cameraStates;
            end
        end
        
        function Qs = estimatedTransformations(obj) 
            Qs = {obj.cameraNode, obj.pointNode, obj.cameraStateIndices, obj.pointNodeIndices, obj.Q};
        end
    end
    
    methods (Access = protected)
        
        function points = getPoints(obj)
            points = obj.pointNode.data.points(:, obj.pointIndices);
        end
        
        function dpredErr = nonstandardJacobian(obj, tweak)
            nPoints = nnz(obj.pointIndices);
            if tweak.node ~= obj.pointNode || ~strcmp(tweak.paramName, 'points')
                dpredErr = sparse(2*nPoints, nnz(tweak.paramIndices));
                return;
            else
                rows = cell(1, 6);
                cols = cell(1, 6);
                values = cell(1, 6);
                for i = 1:3
                    paramIndicesFromNodePointIndices = tweak.paramIndices(i, :); % nodePointIndex -> paramIndex or 0
                    paramIndicesFromObsPointIndices = paramIndicesFromNodePointIndices(obj.pointIndices); % obsPointIndex -> paramIndex or 0
                    obsPointIndicesFromUsedPointIndices = find(paramIndicesFromObsPointIndices); % usedPointIndex -> paramIndex
                    
                    obsPointIndicesFromNodePointIndices = false(1, size(obj.pointNode.data.points, 2));
                    obsPointIndicesFromNodePointIndices(obj.pointIndices) = 1;
                    usedPointIndicesFromNodePointIndices = obsPointIndicesFromNodePointIndices & logical(paramIndicesFromNodePointIndices);
                    usedPoints = obj.pointNode.data.points(:, usedPointIndicesFromNodePointIndices);
                    
                    dUsedPoints = zeros(3, length(usedPoints));
                    dUsedPoints(i, :) = 1;
                    dReproj = caliber.math.projection.standardProjection(obj.K, obj.kc, obj.M, usedPoints, 4, dUsedPoints);
                    rows{i} = obsPointIndicesFromUsedPointIndices * 2 - 1;
                    rows{i+3} = obsPointIndicesFromUsedPointIndices * 2;
                    cols{i} = paramIndicesFromObsPointIndices(obsPointIndicesFromUsedPointIndices);
                    cols{i+3} = paramIndicesFromObsPointIndices(obsPointIndicesFromUsedPointIndices);
                    values{i} = dReproj(1, :);
                    values{i+3} = dReproj(2, :);
                end
                dpredErr = sparse(cell2mat(rows), cell2mat(cols), cell2mat(values), 2*nPoints, nnz(tweak.paramIndices));
            end
        end
    end
    
end

