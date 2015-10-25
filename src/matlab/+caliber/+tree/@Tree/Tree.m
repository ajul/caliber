classdef Tree < handle
    %TREE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        root;
        nodes;
        nodeList;
        observations;       % cell vector of observations {nodeFrom, nodeTo, M, state}
                            % state is a Map: node name -> state index
        observationWeights;
        predictions;        % like observations, but not used in optimization
        optReturnValues;
    end
    
    methods
        
        function obj = Tree()
            % creates a tree with a single root node
            obj.root = [];
            obj.nodes = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.nodeList = {};
            obj.observations = {};
            obj.observationWeights = [];
            obj.predictions = {};
        end
        
        function node = addNode(obj, node)
            % Adds a node to the tree.
            
            if ~isa(node, 'caliber.node.Node')
                error('caliber:tree', ...
                    'node must be of a subclass of ''caliber.node.Node'', got ''%s'' instead', ...
                    class(observation));
            end
            
            if node.isRoot()
                if ~isempty(obj.root)
                    error('caliber:tree', ...
                        'Tree already has a root node.');
                end
                
                if ~(isempty(node.parent) && isempty(node.initialMs))
                    error('caliber:tree', ...
                        'First node is the root and cannot have parents or states.');
                end
                
                obj.root = node;
            else
                if isKey(obj.nodes, node.name)
                    error('caliber:tree', ...
                        'Node ''%s'': Node already exists with that name.', ...
                        name);
                end
                
                parent = obj.getNode(node.parentID);
                node.setParent(parent);
            end
            
            index = length(obj.nodeList) + 1;
            node.setIndex(index);
            obj.nodes(node.name) = node;
            obj.nodeList{end+1} = node;
        end
        
        function node = getNode(obj, nodeID)
            % Casts nodeid into a node handle.
            if isa(nodeID, 'char')
                if ~isKey(obj.nodes, nodeID)
                    warning('caliber:tree', 'No node exists with name ''%s''.', nodeID);
                end
                node = obj.nodes(nodeID);
            elseif isnumeric(nodeID)
                node = obj.nodeList(nodeID);
            elseif isa(nodeID, 'caliber.node.Node')
                node = nodeID;
            else
                error('caliber:tree', ...
                        'nodeID must be a char, numeric, or caliber.node.Node, got type %s instead.', ...
                        name, class(nodeID));
            end
        end
        
        function addObservation(obj, observation, weight)
            % Adds an observation to the system.
            if nargin < 3
                weight = 1;
            end
            
            if ~isa(observation, 'caliber.observation.Observation')
                error('caliber:tree', ...
                    'observation must be of a subclass of ''caliber.observation.Observation'', got ''%s'' instead', ...
                    class(observation));
            end
            
            if ~isfloat(weight)
                error('caliber:tree', ...
                    'observation weight must be of a floating-point type, got type ''%s'' instead', ...
                    class(weight));
            end
            
            observation.bind(obj);
            
            if weight > 0
                obj.observations{end+1} = observation;
                obj.observationWeights(end+1) = weight;
            else
                obj.predictions{end+1} = observation;
            end
        end
        
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
    end
    
end

