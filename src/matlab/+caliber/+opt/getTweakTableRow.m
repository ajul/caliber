function [ row ] = getTweakTableRow( tweakTable, node, state, paramName, paramIndex )
%GETTWEAKTABLEROW Get a row from a tweak table by node, state, paramName, and
%paramIndex.
    for i = 1:size(tweakTable, 1)
        row = tweakTable(i, :);
        if strcmp(node, row{1}) && state == row{2} && strcmp(paramName, row{3}) && paramIndex == row{4}
            return
        end
    end
    row = [];
end

