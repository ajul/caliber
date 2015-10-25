function M = rootM( obj, node, states )
%ROOTM Summary of this function goes here
%   Detailed explanation goes here
    node = obj.getNode(node);
    stateIndices = obj.getStateIndices(states);
    M = node.depthM(stateIndices, 1);
end

