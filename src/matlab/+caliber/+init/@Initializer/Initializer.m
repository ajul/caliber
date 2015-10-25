classdef Initializer < handle
    
    properties (SetAccess = protected)
        tree;           % tree of Nodes
        
        n;              % number of vertices
        vertexNames;    % cell vector: index -> vertex name
        vertexIndices;  % Map: vertex name -> index
        
        labels;         % Map name -> label
        labelList;      % index -> label
        
        transformQueue; % queue of transformations to add

        Ms;             %4n x 4n matrix containing transformation matrix blocks.
        cellMs;         %version of Ms with cells
        MsDirty;
        cellMsDirty;
        
        maxDoFPerTransformation;
        maxDoFTotal;
        dofSoFar;
        tolR;            % rotational tolerance for determining when a solve is well-conditioned
        tolT;            % translational tolerance
    end
    
    methods
        function obj = Initializer(tree)
            obj.tree = tree;
            
            obj.n = 0;
            
            obj.vertexNames = {};
            obj.vertexIndices = containers.Map('KeyType', 'char', 'ValueType', 'double');
            
            obj.labels = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.labelList = {};
            
            obj.transformQueue = {};
        end
    
        % may set methods below this line to protected
        
        function stateIndices = getStateIndices(obj, states)
            if isnumeric(states)
                stateIndices = states;
                return;
            end
            stateIndices = zeros(length(obj.nodeList), 1);
            for i = 1:length(stateIndices)
                stateName = obj.nodeList{i}.name;
                if isKey(states, stateName)
                    stateIndices(i) = states(stateName);
                else
                    stateIndices(i) = 1;
                end
            end
        end
        
        %% graph methods
        
        function addVertex(obj, name)
            if ~obj.vertexIndices.isKey(name)
                obj.n = obj.n + 1;
                obj.vertexNames{obj.n} = name;
                obj.vertexIndices(name) = obj.n;
            end
        end
        
        function addTransform(obj, nodeFrom, nodeTo, xf)
            obj.transformQueue(end+1, :) = {nodeFrom, nodeTo, xf};
        end
        
        function vertexIndex = getVertexIndex(obj, vertexID)
            if ischar(vertexID)
                if ~isKey(obj.vertexIndices, vertexID)
                    error('warning:init', 'No vertex named ''%s''.', vertexID);
                end
                vertexIndex = obj.vertexIndices(vertexID);
            else
                vertexIndex = vertexID;
            end
        end
        
        function setM(obj, nodeFromIndex, nodeToIndex, M)
            if obj.cellMsDirty
                error('caliber:init', 'Attempted to access Ms when cellMs are dirty.');
            end
            fromIndices = (-3:0) + 4 * nodeFromIndex;
            toIndices = (-3:0) + 4 * nodeToIndex;
            obj.Ms(fromIndices, toIndices) = M;
            h = M(4, 4);
            obj.Ms(toIndices, fromIndices) = inv(M) .* (h .* h);
            obj.MsDirty = 1;
        end
        
        function H = getHomogeneous(obj)
            if obj.cellMsDirty
                error('caliber:init', 'Attempted to access Ms when cellMs are dirty.');
            end
            indices = (1:obj.n) * 4;
            H = obj.Ms(indices, indices);
        end
        
        function result = getCellM(obj, nodeFromIndex, nodeToIndex)
            if obj.MsDirty
                error('caliber:init', 'Attempted to access cellMs when Ms are dirty.');
            end
            result = obj.cellMs{nodeFromIndex, nodeToIndex};
        end
        
        function result = getCellMs(obj, mask)
            if obj.MsDirty
                error('caliber:init', 'Attempted to access cellMs when Ms are dirty.');
            end
            result = obj.cellMs(mask);
        end
        
        function setCellM(obj, nodeFromIndex, nodeToIndex, M)
            if obj.MsDirty
                error('caliber:init', 'Attempted to access cellMs when Ms are dirty.');
            end
            obj.cellMs{nodeFromIndex, nodeToIndex} = M;
            h = M(4, 4);
            obj.cellMs{nodeToIndex, nodeFromIndex} = inv(M) .* (h .* h);
            obj.cellMsDirty = 1;
        end
        
        function setCellMsToSingle(obj, mask, M)
            if obj.MsDirty
                error('caliber:init', 'Attempted to access cellMs when Ms are dirty.');
            end
            [rows, cols] = find(mask);
            for i = 1:length(rows)
                obj.setCellM(rows(i), cols(i), M);
            end
            obj.cellMsDirty = 1;
        end
        
        function M = getLabelM(obj, labelName)
            if ~isKey(obj.labels, labelName)
                warning('caliber:init', 'No label named ''%s''', labelName);
                M = [];
                return;
            end
            M = obj.labels(labelName).M;
            if isempty(M)
                return;
            end
            M = caliber.math.normalizeRigid(M);
        end
        
        function initSolve(obj)
            import caliber.init.Label
            obj.Ms = eye(4 * obj.n);
            
            for i = 1:size(obj.transformQueue, 1)
                [nodeFrom, nodeTo, xf] = obj.transformQueue{i, :};
                initTransform(nodeFrom, nodeTo, xf);
            end
            
            function initTransform(nodeFrom, nodeTo, xf)
                nodeFromIndex = obj.getVertexIndex(nodeFrom);
                nodeToIndex = obj.getVertexIndex(nodeTo);
                
                if isempty(nodeFromIndex) || isempty(nodeToIndex)
                    return;
                end
                
                if ischar(xf)
                    if obj.labels.isKey(xf)
                        label = obj.labels(xf);
                    else
                        label = caliber.init.Label(obj, xf, length(obj.labelList) + 1);
                        obj.labels(xf) = label;
                        obj.labelList{end+1} = label;
                    end
                    
                    label.addEdge(nodeFromIndex, nodeToIndex);
                else
                    obj.setM(nodeFromIndex, nodeToIndex, xf);
                end
            end
            
            obj.updateCellMs();
        end
        
        function updateMs(obj)
            if obj.cellMsDirty
                obj.Ms = cell2mat(obj.cellMs);
                obj.cellMsDirty = 0;
            end
            obj.MsDirty = 0;
        end
                
        function updateCellMs(obj)
            if obj.MsDirty
                cellDivide = 4 * ones(obj.n, 1);
                obj.cellMs = mat2cell(obj.Ms, cellDivide, cellDivide);
                obj.MsDirty = 0;
            end
            obj.cellMsDirty = 0;
        end
    end
end
