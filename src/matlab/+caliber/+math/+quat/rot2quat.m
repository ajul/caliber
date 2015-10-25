function q = rot2quat(M)
    r = caliber.math.logmVector(M);
    theta = norm(r);
    q = [cos(0.5 * theta); sin(0.5 * theta) * r / theta];
end
