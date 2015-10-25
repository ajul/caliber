function M = eulerZYX( v )
%EULERZYX Summary of this function goes here
%   Detailed explanation goes here
    r = v(1:3);
    s = sin(r);
    c = cos(r);

    M = [c(1)*c(2), c(1)*s(2)*s(3)-c(3)*s(1), s(1)*s(3)+c(1)*c(3)*s(2);...
        c(2)*s(1),  c(1)*c(3)+s(1)*s(2)*s(3), c(3)*s(1)*s(2)-c(1)*s(3);...
        -s(2),      c(2)*s(3),                c(2)*c(3)];
    
    if numel(v) == 6
        t = zeros(3, 1);
        t(:) = v(4:6);
        M = [M t; 0 0 0 1];
    end
end

