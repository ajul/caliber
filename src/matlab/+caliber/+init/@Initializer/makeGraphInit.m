function obj = makeGraphInit(obj, options)
    % Constructs a GraphInit object corresponding to this Initializer.
    %
    % Vertices are named as (node name):(s1),(s2),...(sn)
    % where s1, s2... are the states on the path from the root
    % to the node.
    %
    % Transformations are named as (node name):(s)
    % where s is the state that the node is in.
    obj = caliber.init.GraphInit();
    
    n = length(obj.observations);

    branches = cell(n*2, 2);
    
    secondaryLabelOption = caliber.init.initializerOptionsGet(options, 'SecondaryLabels', 'OneSide');
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
    
    for i=1:length(obj.observations)
        o = obj.observations{i};
        branch = obj.processObservation(o, obj, secondaryLabelOption);
        branches( (2*i-1):(2*i), : ) = branch;
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

