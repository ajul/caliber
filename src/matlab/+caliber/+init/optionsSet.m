function [ opts ] = optionsSet( varargin )
%INITIALIZEROPTIONS 
    if isempty(varargin)
        opts = emptyOptions();
        % print possible options?
        return;
    end

    if isstruct(varargin{1})
        opts = varargin{1};
        firstOptIndex = 2;
    else
        opts = emptyOptions();
        firstOptIndex = 1;
    end
    
    i = firstOptIndex;
    
    while i < length(varargin)
        k = varargin{i};
        v = varargin{i+1};
        checkOption(k, v);
        opts.(k) = v;
        i = i + 2;
    end
end

function opts = emptyOptions()
    opts = struct();
    opts.MaxDoFPerTransformation = [];
    opts.MaxDoFTotal = [];
    opts.SecondaryLabels = [];
    opts.TolR = [];
    opts.TolT = [];
end

function checkOption(k, v)
    switch k
        case {'MaxDoFPerTransformation', 'TolR', 'TolT', 'MaxDoFTotal'}
            if ~isnumeric(v)
                error('caliber:init', 'Value for option ''%s'' must be numeric.', k);
            end
        case 'SecondaryLabels'
            if ~ischar(v) || ~isStringInSet(v, {'None', 'OneSide', 'BothSides', 'All'})
                error('caliber:init', 'Value for option ''%s'' must be ''None'', ''OneSide'', ''BothSides'', or ''All''.', k);
            end
        otherwise
            error('caliber:init', 'Invalid option ''%s''.', k);
    end
end

function result = isStringInSet(s, ss)
    for i = 1:length(ss)
        if strcmp(s, ss{i})
            result = 1;
            return;
        end
    end
    result = 0;
end

