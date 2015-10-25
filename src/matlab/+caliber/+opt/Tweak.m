classdef Tweak < handle
    %TWEAK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        node;
        paramName;
        paramIndices;
    end
    
    methods
        function obj = Tweak(node, paramName, paramIndices)
            obj.node = node;
            obj.paramName = paramName;
            ind = find(paramIndices);
            obj.paramIndices = zeros(size(paramIndices));
            obj.paramIndices(ind) = 1:length(ind);
        end
        
        function values = getValues(obj)
            values = obj.node.getData(obj);
        end
        
        function setValues(obj, values)
            obj.node.setData(obj, values);
        end
        
        function dValues = dValues(obj)
            [rows, cols, indices] = find(obj.paramIndices);
            dValues = cell(length(indices), 1);
            for i = 1:length(indices)
                dValues{i} = sparse(rows(i), cols(i), 1, size(obj.paramIndices, 1), size(obj.paramIndices, 2), 1);
            end
        end
        
        function display(obj)
            s = sprintf('%-16s  %-8s', obj.node.name, obj.paramName);
            pad = char(ones(1, length(s)) * ' ');
            nonTweakString = '<fixed>     ';
            allData = obj.node.data.(obj.paramName);
            maxSize = 10;
            for i = 1:size(obj.paramIndices, 1)
                if i > 1
                    s = sprintf('%s\n%s', s, pad);
                end
                
                for j = 1:size(obj.paramIndices, 2)
                    if j == maxSize && j < size(obj.paramIndices, 2)
                        s = sprintf('%s  ...', s);
                        break;
                    elseif i == maxSize && i < size(obj.paramIndices, 1)
                        s = sprintf('%s  %-12s', s, '...');
                    elseif obj.paramIndices(i, j)
                        value = allData(i, j);
                        s = sprintf('%s  %- 012.4g', s, value);
                    else
                        s = sprintf('%s  %s', s, nonTweakString);
                    end
                end
                
                if i >= maxSize
                    break;
                end
            end
            s = sprintf('%s\n', s);
            disp(s);
        end
    end
    
    methods (Static)
        function [tweaks, tweakLengths] = makeTweaks(node, paramNames, paramIndices, states )
            if nargin < 4
                states = [];
            end

            if strcmp(states, 'all')
                states = true(1, node.numberOfStates());
            elseif ~isnumeric(states) && ~islogical(states)
                error('caliber:input', ...
                    'states is not a numeric array or ''all''.');
            end

            if isa(paramNames, 'char')
                paramNames = {paramNames};
            elseif ~isa(paramNames, 'cell')
                error('caliber:input', ...
                    'paramNames is not a char or cell of chars.');
            end

            if ~isnumeric(paramIndices) && ~islogical(paramIndices) && ~strcmp(paramIndices, 'all')
                error('caliber:input', ...
                    'states is not a logical array or ''all''.');
            end
            
            n = numel(paramNames);
            
            tweaks = cell(n, 1);
            tweakLengths = zeros(n, 1);

            for i = 1:n
                currParamName = paramNames{i};
                
                if isempty(states)
                    if strcmp(paramIndices, 'all')
                        currParamIndices = true(size(node.data.(currParamName)));
                    else
                        currParamIndices = false(size(node.data.(currParamName)));
                        currParamIndices(paramIndices) = 1;
                    end
                else
                    currParamIndices = false(size(node.data.(currParamName)));
                    if strcmp(paramIndices, 'all')
                        currParamIndices(:, states) = 1;
                    else
                        currParamIndices(paramIndices, states) = 1;
                    end
                end
                tweak = caliber.opt.Tweak(node, currParamName, currParamIndices);
                tweaks{i} = tweak;
                tweakLengths(i) = nnz(tweak.paramIndices);
            end
        end
    end
    
end

