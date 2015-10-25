function [ value ] = optionsGet( opts, param, defaultValue )
%INITIALIZEROPTIONSGET Summary of this function goes here
%   Detailed explanation goes here
    % check value?
    
    value = opts.(param);
    
    if isempty(value) && nargin >= 3
        value = defaultValue;
    end

end

