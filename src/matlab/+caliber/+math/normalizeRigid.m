function M = normalizeRigid(M)
    h = M(4, 4);
    %r = caliber.math.logmVector(M);
    %R = caliber.math.axisAngle(r);
    [U, S, V] = svd(M(1:3, 1:3));
    R = U * V';
    t = M(1:3, 4) / h;

    M = [R t; 0 0 0 1];
end
