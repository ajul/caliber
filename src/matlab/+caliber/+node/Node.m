classdef Node < handle
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        name;           % name of this node (unique)
        ancestors;      % cell array of ancestors
        parentID;       % parents are only resolved when added to a tree
        parent;
        children;       
        index;
        data;
        
        % plot information
        plotDimensions;
        plotPosition;
    end
    
    methods
        %% constructor and initialization
        
        function obj = Node(name, parentID, data)
            if isempty(data)
                data = struct();
            end
            
            if ~ischar(name)
                error('caliber:node', ...
                    'Name must be a string.');
            end

            if ~isstruct(data)
                error('caliber:node', ...
                    'Node ''%s'': data must be of type struct, got %s instead.', ...
                    name, class(data));
            end

            obj.parentID = parentID;
            if isempty(parentID)
                obj.ancestors = {};
            end
            
            obj.name = name;
            obj.data = data;
            
            obj.children = {};
        end
        
        function setParent(obj, parent)
            obj.parent = parent;
            obj.ancestors = parent.ancestors;
            obj.ancestors{end+1} = obj;
            parent.children{end+1} = obj;
        end
        
        function setIndex(obj, index)
            obj.index = index;
        end
        
        function b = isRoot(obj)
            b = isempty(obj.parentID);
        end
        
        function clo = clone(obj)
            error('caliber:node', 'clone() not implemented for class %s.', class(obj));
        end
        
        %% tree methods 
    
        function idx = getStateIndex(obj, stateIndices)
            idx = stateIndices(obj.index);
        end

        function depth = oldestDifferingAncestorDepth(obj, targetNode, stateIndices, targetStateIndices)
            depthMax = min(length(obj.ancestors), length(targetNode.ancestors));
            for i = 1:depthMax
                ancestor = obj.ancestors{i};
                targetAncestor = targetNode.ancestors{i};
                if ancestor ~= targetAncestor || ...
                    stateIndices(ancestor.index)  ~= targetStateIndices(targetAncestor.index)
                    depth = i;
                    return;
                end
            end
            depth = depthMax + 1;
        end
        
        function s = getStateString(obj, stateIndices, startDepth)
            % get a comma-separated string of all states from the root to
            % this node
            if nargin < 3
                startDepth = 1;
            end
            
            s = '';
            for i = startDepth:(length(obj.ancestors))
                ancestor = obj.ancestors{i};
                s = sprintf('%s,%d', s, stateIndices(ancestor.index));
            end
            s = s(2:end);
        end
        
        function s = getVertexString(obj, stateIndices, startDepth)
            if nargin < 3
                startDepth = 1;
            end
            if isempty(obj.ancestors)
                s = obj.name; %special case for root
            else
                s = sprintf('%s:%s', obj.name, obj.getStateString(stateIndices, startDepth));
            end
        end
        
        function s = getEdgeString(obj, stateIndices)
            s = sprintf('%s:%u', obj.name, obj.getStateIndex(stateIndices));
        end
        
        function s = getPathString(obj, targetNode, stateIndices, targetStateIndices)
            depth = obj.oldestDifferingAncestorDepth(targetNode, stateIndices, targetStateIndices);
            objS = obj.getVertexString(stateIndices, depth);
            otherS = targetNode.getVertexString(targetStateIndices, depth);
            s = sprintf('%s->%s', objS, otherS);
        end
        
        function result = getData(obj, tweak)
            result = reshape(obj.data.(tweak.paramName)(logical(tweak.paramIndices)), [], 1);
        end
        
        function setData(obj, tweak, values)
            obj.data.(tweak.paramName)(logical(tweak.paramIndices)) = values;
        end
        
        function dData = dData(obj, tweak)
            [rows, cols, indices] = find(tweak.paramIndices);
            dData = cell(length(indices), 1);
            for i = 1:length(indices)
                dData{i} = sparse(rows(i), cols(i), 1, size(tweak.paramIndices, 1), size(tweak.paramIndices, 2), 1);
            end
        end
        
        function depthM = depthM(obj, stateIndices, depth)
            depthM = eye(4);
            for i = depth:length(obj.ancestors)
                ancestor = obj.ancestors{i};
                depthM = depthM * ancestor.M(stateIndices);
            end
        end
        
        function [dDepthMs, tweakIndices] = dDepthMs(obj, stateIndices, depth, tweak)
            tweakDepth = length(tweak.node.ancestors);
            if tweakDepth < depth || tweakDepth > length(obj.ancestors) || tweak.node ~= obj.ancestors{tweakDepth}
                dDepthMs = {};
                tweakIndices = [];
                return;
            end
            
            [dMs, tweakIndices] = tweak.node.dMs(stateIndices(tweak.node.index), tweak);
            
            if tweakDepth > 1
                aboveM = obj.ancestors{tweakDepth-1}.depthM(stateIndices, depth);
            else
                aboveM = eye(4);
            end
            belowM = obj.depthM(stateIndices, tweakDepth+1);
            
            dDepthMs = cell(size(dMs));
            
            for i = 1:numel(dMs)
                dDepthMs{i} = aboveM * dMs{i} * belowM;
            end
        end
        
        function M = relativeM(obj, targetNode, stateIndices, targetStateIndices)
            depth = obj.oldestDifferingAncestorDepth(targetNode, stateIndices, targetStateIndices);
            M = obj.depthM(stateIndices, depth) \ targetNode.depthM(targetStateIndices, depth);
        end
        
        function [dMs, tweakIndices] = dRelativeMs(obj, targetNode, stateIndices, targetStateIndices, tweak)
            depth = obj.oldestDifferingAncestorDepth(targetNode, stateIndices, targetStateIndices);
            
            depthM = obj.depthM(stateIndices, depth);
            [dDepthMs, sourceTweakIndices] = obj.dDepthMs(stateIndices, depth, tweak);
            targetDepthM = targetNode.depthM(targetStateIndices, depth);
            [targetdDepthMs, targetTweakIndices] = targetNode.dDepthMs(targetStateIndices, depth, tweak);
            
            relativeM = depthM \ targetDepthM;
            
            nSource = numel(sourceTweakIndices);
            nTarget = numel(targetTweakIndices);
            
            dMs = cell(1, nSource + nTarget);
            tweakIndices = [sourceTweakIndices(:); targetTweakIndices(:)]';
            
            for i = 1:nSource
                dMs{i} = - depthM \ dDepthMs{i} * relativeM;
            end
            
            for i = 1:nTarget
                dMs{i + nSource} = depthM \ targetdDepthMs{i};
            end
        end
    end
    
    methods (Abstract)
        result = isKnown(obj, stateIndices)
        n = numberOfStates(obj) % number of states
        M = getInitialM(obj, stateIndices)
        setInitialM(obj, index, M)
        M = M(obj, stateIndices)
        [dMs, tweakIndices] = dMs(obj, state, tweak)
    end
end
