function [ t ] = solveTranslation1DoF( R, infoA, infoB )
%SOLVETRANSLATION1DOF Summary of this function goes here
%   Detailed explanation goes here

    n = infoA.n;
    RA = cell(n, 1);
    b = cell(n, 1);
    for i = 1:n
        RA{i} = infoA.R{i} - eye(3);
        b{i} = R * infoB.t(:, i) - infoA.t(:, i);
    end
    
    RA = [cell2mat(RA); infoA.r'];
    b = [cell2mat(b); zeros(n, 1)];
    
    t = RA \ b;

end

