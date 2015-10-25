function [ result ] = nodeData( obj, node, paramName )
%NODEDATA Gets data associated with a node
    node = obj.getNode(node);
    result = node.data.(paramName);
end

