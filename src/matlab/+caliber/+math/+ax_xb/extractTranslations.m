function [ t ] = translationInfo( Ms )
%TRANSLATIONINFO Summary of this function goes here
%   Detailed explanation goes here
    n = length(Ms);
    
    t = zeros(3, n);
    
    for i = 1:n
        t(:, i) = Ms{i}(1:3, 4);
    end

end

