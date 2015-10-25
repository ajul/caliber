function [ synTree ] = makeSynthetic( obj, sigma )
%MAKESYNTHETIC Summary of this function goes here
%   Detailed explanation goes here
    synTree = caliber.tree.Tree();
    for j = 1:numel(obj.nodeList)
        synTree.addNode(obj.nodeList{j}.clone());
    end
    for j = 1:numel(obj.observations)
        synTree.addObservation(obj.observations{j}.makeSynthetic(sigma), obj.observationWeights(j));
    end
end
