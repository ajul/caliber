function [ M ] = nodeM( obj, node, stateIndex )
%NODEM Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 3
        stateIndex = 1;
    end
    node = obj.getNode(node);
    M = node.M(stateIndex);
end

