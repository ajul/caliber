function newBranches = processObservation(obj, o, secondaryLabelOption)
    % Adds an observation to a GraphInit instance.
    % This consists of adding the transformations on the 
    % camera path and the points path, plus one for the 
    % observation itself.
    Qs = o.estimatedTransformations();
    
    for i = 1:size(Qs, 1)
        [fromNode, toNode, fromStateIndices, toStateIndices, Q] = Qs{i, :};
        oldestDifferingDepth = fromNode.oldestDifferingAncestorDepth(toNode, fromStateIndices, toStateIndices);
        fromVertex = addToGraphInit(obj, fromNode, fromStateIndices, secondaryLabelOption, oldestDifferingDepth);
        toVertex = addToGraphInit(obj, toNode, toStateIndices, secondaryLabelOption, oldestDifferingDepth);
        obj.addTransform(fromVertex, toVertex, Q);
    end
    
    newBranches = [Qs(:, [1,3]); Qs(:, [2,4])];
end

function lastVertex = addToGraphInit( obj, node, stateIndices, secondaryLabelOption, oldestDifferingDepth)
    lastVertex = obj.tree.root.getVertexString();

    n = length(node.ancestors);

    for i = 1:n
        ancestor = node.ancestors{i};
        currVertex = ancestor.getVertexString(stateIndices);
        obj.addVertex(currVertex);

        xf = ancestor.getInitialM(stateIndices);
        if isempty(xf)
            xf = ancestor.getEdgeString(stateIndices);
            if secondaryLabelOption > 0
                addSecondaryLabels();
            end
        end

        obj.addTransform(lastVertex, currVertex, xf);

        lastVertex = currVertex;
    end

    function addSecondaryLabels()
        for j = oldestDifferingDepth:(i-1)
            preAncestor = node.ancestors{j};
            prexf = preAncestor.getInitialM(stateIndices);
            if ~isempty(prexf)
                continue;
            end
            preNode = preAncestor.parent(); %parent is at other end of xf
            secondaryLabel = preNode.getPathString(ancestor, stateIndices, stateIndices);
            preVertex = preNode.getVertexString(stateIndices);
            obj.addTransform(preVertex, currVertex, secondaryLabel);
        end
    end
end