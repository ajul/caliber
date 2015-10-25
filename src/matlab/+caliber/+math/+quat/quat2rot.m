function R = quat2rot(q)
    r = q(2:4);
    r = r / norm(r) * acos(q(1)) * 2;
    R = caliber.math.axisAngle(r);
end
