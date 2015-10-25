classdef GeneralNode < caliber.node.Node
    
    properties (SetAccess = protected)
        initialMs;
    end
    
    methods
        function obj = GeneralNode(name, parentID, data, initialMs)
            obj = obj@caliber.node.Node(name, parentID, data);
            
            if ~iscell(initialMs)
                error('caliber:node', ...
                    'Node ''%s'': baseMs must be a cell array.', ...
                    name);
            end

            if ~isempty(parentID) && isempty(initialMs)
                error('caliber:node', ...
                    'Node ''%s'': Non-root nodes must have at least one state.', ...
                    name)
            end
            
            obj.initialMs = initialMs;
            if ~obj.isRoot()
                obj.data.r = zeros(3, numel(obj.initialMs));
                obj.data.t = zeros(3, numel(obj.initialMs));
            end
        end
        
        function clo = clone(obj)
            clo = caliber.node.GeneralNode(obj.name, obj.parentID, obj.data, obj.initialMs);
        end
        
        function n = numberOfStates(obj)
            n = numel(obj.initialMs);
        end
        
        function result = isKnown(obj, stateIndices)
            if nargin > 1
                if numel(stateIndices) == 1
                    result = ~isempty(obj.initialMs{stateIndices});
                else
                    result = ~isempty(obj.initialMs{stateIndices(obj.index)});
                end
            else
                n = numel(obj.initialMs);
                result = false(size(obj.initialMs));
                for i = 1:n
                    result(i) = ~isempty(obj.initialMs{i});
                end
            end
        end
        
        function M = getInitialM(obj, stateIndices)
            M = obj.initialMs{stateIndices(obj.index)};
        end
        
        function setInitialM(obj, index, M)
            obj.initialMs{index} = M;
        end
        
        function M = M(obj, stateIndices)
            % get the transformation matrix associated with this node
            if length(stateIndices) > 1
                state = stateIndices(obj.index);
            else
                state = stateIndices;
            end
            M = obj.initialMs{state};
            tweakR = caliber.math.axisAngle(obj.data.r(:, state));
            M(1:3, 1:3) = tweakR * M(1:3, 1:3);
            M(1:3, 4) = M(1:3, 4) + obj.data.t(:, state);
        end
        
        function [dMs, tweakIndices] = dMs(obj, state, tweak)
            % get the derivatives of the transformation matrix associated
            % with this node with respect to the tweak
            
            if obj ~= tweak.node
                dMs = {};
                tweakIndices = [];
                return;
            end
            
            switch(tweak.paramName)
                case 't'
                    paramIndices = tweak.paramIndices(:, state);
                    select = logical(paramIndices);
                    tweakIndices = paramIndices(select);
                    dMs = cell(1, 3);
                    for i = 1:3
                        dMs{i} = zeros(4);
                        dMs{i}(i, 4) = 1;
                    end
                    dMs = dMs(select);
                    return;
                case 'r'
                    paramIndices = tweak.paramIndices(:, state);
                    select = logical(paramIndices);
                    tweakIndices = paramIndices(select);
                    dMs = cell(1, 3);
                    for i = 1:3
                        initialM = obj.initialMs{state};
                        baseR = initialM(1:3, 1:3);
                        dtweakR = caliber.math.axisAngle(obj.data.r(:, state), i);
                        dMs{i} = zeros(4);
                        dMs{i}(1:3, 1:3) = dtweakR * baseR;
                    end
                    dMs = dMs(select);
                    return;
                otherwise
                    dMs = {};
                    tweakIndices = [];
                    return;
            end
        end
    end
    
end

