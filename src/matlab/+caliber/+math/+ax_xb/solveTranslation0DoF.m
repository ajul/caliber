function [ t ] = solveTranslation0DoF( R, infoA, infoB )
%SOLVETRANSLATION0DOF Summary of this function goes here
%   Detailed explanation goes here
    n = infoA.n;

    C = cell(n, 1);
    d = cell(n, 1);
    
    for i = 1:n
        C{i} = eye(3) - infoA.R{i};
        d{i} = infoA.t(:, i) - R * infoB.t(:, i);
    end
    
    C = cell2mat(C);
    d = cell2mat(d);
    
    t = C \ d;

end

