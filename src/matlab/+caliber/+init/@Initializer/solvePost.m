function solvePost( obj )
%SOLVEPOST Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:length(obj.tree.nodeList)
        node = obj.tree.ndeList{i};
        for j = 1:node.numberOfStates()
            if ~node.isKnown(j)
                xfname = sprintf('%s:%d', node.name, j);
                M = obj.getLabelM(xfname);
                if isempty(M)
                    warning('caliber:init', 'State %u of node ''%s'' is unused. Setting to the identity transformation.\n', j, node.name);
                    M = eye(4);
                end
                node.setInitialM(j, M);
            end
        end
    end
end

