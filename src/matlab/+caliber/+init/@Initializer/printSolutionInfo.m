function printSolutionInfo(obj)
%PRINTSOLUTIONINFO 
    fprintf('Labels:\n');
    for i = 1:length(obj.labelList)
        label = obj.labelList{i};
        if label.isSolved()
            fprintf('    %s: solved\n', label.name);
        else
            fprintf('    %s: not solved\n', label.name);
        end
    end
end

