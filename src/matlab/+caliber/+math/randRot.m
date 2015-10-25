function M = randRot(maxCos)
%RANDROT Random rotation matrix.
%maxRot: maximum -cos of rotation
    import caliber.math.randDir
    if nargin < 1
        maxCos = 1;
    end
    
    axis = randDir();
    randcos = 1 - rand() * 2 * maxCos;
    magnitude = acos(randcos);
    rot = axis * magnitude;
    logM = [0, -rot(3), rot(2); rot(3), 0, -rot(1); -rot(2), rot(1), 0];
    M = expm(logM);
end
