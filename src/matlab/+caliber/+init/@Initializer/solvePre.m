function solvePre( obj, options )
%SOLVEINIT Summary of this function goes here
%   Detailed explanation goes here
    observations = obj.tree.observations;
    n = length(observations);
    
    secondaryLabelOption = caliber.init.optionsGet(options, 'SecondaryLabels', 'OneSide');
    switch secondaryLabelOption
        case 'None'
            secondaryLabelOption = 0;
        case 'OneSide'
            secondaryLabelOption = 1;
        case 'BothSides'
            secondaryLabelOption = 2;
        case 'All'
            secondaryLabelOption = 3;
    end
    
    branches = {};
    
    obj.addVertex(obj.tree.root.getVertexString());
    for i=1:length(observations)
        o = observations{i};
        newBranches = obj.processObservation(o, secondaryLabelOption);
        branches = [branches; newBranches];
    end
    
    if secondaryLabelOption == 3
        for i = 1:(2*n)
             [fromNode, fromIndices] = branches{i, :};
             for j = (i+1):(2*n)
                 [toNode, toIndices] = branches{j, :};
                 fromNode.addCrossVertices(obj, fromIndices, toNode, toIndices);
             end
        end
    elseif secondaryLabelOption == 2
        for i = 1:n
             [fromNode, fromIndices] = branches{2*i-1, :};
             [toNode, toIndices] = branches{2*i, :};
             addCrossVertices(obj, fromNode, fromIndices, toNode, toIndices);
        end
    end

end

function addCrossVertices(obj, node, stateIndices, targetNode, targetStateIndices)
    startDepth = node.oldestDifferingAncestorDepth(targetNode, stateIndices, targetStateIndices);
    for depth = startDepth:length(obj.ancestors)
        ancestor = node.ancestors{depth};
        if ancestor.isKnown(stateIndices)
            continue;
        end

        vertex = ancestor.getVertexString(stateIndices);

        for targetDepth = startDepth:length(targetNode.ancestors)
            targetAncestor = targetNode.ancestors{targetDepth};
            if targetAncestor.isKnown(targetStateIndices)
                continue;
            end

            targetVertex = targetAncestor.getVertexString(targetStateIndices);

            if ancestor.index < targetAncestor.index
                label = ancestor.getPathString(targetAncestor, stateIndices, targetStateIndices);
                obj.addTransform(vertex, targetVertex, label);
            else
                label = targetAncestor.getPathString(ancestor, targetStateIndices, stateIndices );
                obj.addTransform(targetVertex, vertex, label);
            end
        end
    end
end

