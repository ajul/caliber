classdef PrismaticJoint < caliber.node.Node
    %PRISMATICJOINT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        positions;
    end
    
    methods
        function obj = PrismaticJoint(name, parentID, data, positions)
            obj = obj@caliber.node.Node(name, parentID, data);
            
            obj.positions = positions;
        end
        
        function n = numberOfStates(obj)
            n = numel(obj.positions);
        end
        
        function result = isKnown(obj, stateIndices)
            if nargin > 1
                result = true();
            else
                result = true(size(obj.positions));
            end
        end
        
        function M = getInitialM(obj, stateIndices)
            position = obj.positions(stateIndices(obj.index)) * obj.data.gain;
            M = [eye(3) [0;0;position]; 0 0 0 1];
        end
        
        function setInitialM(obj, index, M)
            error('caliber:node', 'PrismaticJoint does not support unknown transformations');
        end
        
        function M = M(obj, stateIndices)
            % get the transformation matrix associated with this node
            if length(stateIndices) > 1
                state = stateIndices(obj.index);
            else
                state = stateIndices;
            end
            position = obj.positions(state) * obj.data.gain;
            M = [eye(3) [0;0;position]; 0 0 0 1];
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
                case 'gain'
                    if tweak.paramIndices
                        position = obj.positions(state);
                        M = [zeros(3) [0;0;position]; 0 0 0 0];
                        dMs = {M};
                        tweakIndices = 1;
                        return;
                    else
                        dMs = {};
                        tweakIndices = [];
                        return;
                    end
                otherwise
                    dMs = {};
                    tweakIndices = [];
                    return;
            end
        end
    end
    
end

