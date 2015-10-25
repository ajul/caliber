function [ X ] = solveNonparallelTranslation( ta, tb, tolR )
%SOLVENOAXIS Summary of this function goes here
%   Detailed explanation goes here
    
    R = caliber.math.ax_xb.solveRotation0DoF(ta, tb, tolR);
    
    if isempty(R)
        X = [];
        return;
    end
    
    t = zeros(3, 1);
    X = [R t; 0 0 0 1];
    
end

