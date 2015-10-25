function [ r, o, tmag ] = xf2screw( M )
%XF2SCREW
    R = M(1:3, 1:3);
    t = M(1:3, 4);
    r = caliber.math.logmVector(R);
    axis = r / norm(r);
    tmag = dot(axis, t);
    o = [(R - eye(3)); r'] \ [(r * tmag - t); 0];
end
