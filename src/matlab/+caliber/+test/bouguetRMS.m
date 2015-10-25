function rmsError = bouguetRMS( filenames, indices )
%BOUGUETRMS 
    n = numel(filenames);
    errors = cell(1, n);
    
    for i = 1:n
        data = load(filenames{i}, 'ex');
        errors{i} = data.ex;
        if nargin > 1
            errors{i} = errors{i}(:, indices);
        end
    end
    
    
    errors = cell2mat(errors);
    errors = reshape(errors, 1, []);
    rmsError = sqrt(mean(errors.*errors));
end

