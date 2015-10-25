function [ synOpt ] = makeSynthetic( obj, sigma )
%MAKESYNTHETIC Summary of this function goes here
%   Detailed explanation goes here
    synTree = obj.tree.makeSynthetic(sgma);
    synOpt = caliber.opt.Optimizer(synTree);
    for i = 1:numel(obj.tweaks)
        tweak = obj.tweaks{i};
        synOpt.addTweaks({tweak.node.name, tweak.paramName, logical(tweak.paramIndices), []});
    end
end
