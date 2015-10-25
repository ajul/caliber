function [stateValues, dataStates] = findStates( data )
%ROWMAP takes a matrix and returns an array of unique rows
%and index assignments of data rows into that array
n = size(data, 1);

stateValues = [];
dataStates = zeros(n, 1);

for i = 1:n
    row = data(i, :);
    for j = 1:size(stateValues, 1)
        if all(row == stateValues(j, :))
            dataStates(i) = j;
            break;
        end
    end
    
    if ~dataStates(i)
        stateValues = [stateValues; row];
        dataStates(i) = size(stateValues, 1);
    end
end

end

