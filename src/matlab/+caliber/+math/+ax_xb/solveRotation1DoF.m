function [ R ] = solveRotation1DoF( as, bs )
%SOLVEROTATION1DOF 
%   inputs: normalized vector directions as, bs
    if isempty(as)
        R = [];
        return;
    end

    r = mean(cross(bs, as), 2);
    s = norm(r);
    
    theta = acos(mean(dot(as, bs, 1)));   % computation could be improved?
    r = r * theta / s;
    
    R = caliber.math.axisAngle(r);
end
