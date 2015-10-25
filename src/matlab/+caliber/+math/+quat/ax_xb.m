function [X, c] = ax_xb( As, Bs )
%AX_XBDQ Dual quaternion AX = XB method of Daniilidis. Hand-eye calibration
%using dual quaternions. International Journal of Robotics Research,
%18:286-298, 1999. 
    n = length(As);
    
    T = cell(n, 1);
    
    for i = 1:n
        S = computeS(As{i}, Bs{i});
        T{i} = S;
    end

    T = cell2mat(T);
    
    [~, S, V] = svd(T);
    
    c = S(6, 6);
    
    u1 = V(1:4, 7);
    v1 = V(5:8, 7);
    u2 = V(1:4, 8);
    v2 = V(5:8, 8);
    
    [s1, s2] = quadraticEquation(u1'*v1, u1'*v2 + u2'*v1, u2'*v2);
    
    S1 = s1*s1*(u1'*u1) + 2*s1*(u1'*u2) + (u2'*u2);
    S2 = s2*s2*(u1'*u1) + 2*s2*(u1'*u2) + (u2'*u2);
    
    if S1 > S2
        l2 = sqrt(1 / S1);
        l1 = l2 * s1;
    else
        l2 = sqrt(1 / S2);
        l1 = l2 * s2;
    end
    
    q = l1 * V(:, 7) + l2 * V(:, 8);
    
    R = caliber.math.quat.quat2rot(q(1:4));
    t = 2 * caliber.math.quat.quatmult(q(5:8), caliber.math.quat.quatconj(q));
    
    X = [R t(2:4); 0 0 0 1];
end


function S = computeS(A, B)
    function [q, qp] = computeQuaternions(M)
        q = caliber.math.quat.rot2quat(M);
        t = [0; M(1:3, 4)];
        qp = 0.5 * caliber.math.quat.quatmult(t, q);
    end

    [qa, qpa] = computeQuaternions(A);
    [qb, qpb] = computeQuaternions(B);
    
    va = qa(2:4);
    vpa = qpa(2:4);
    vb = qb(2:4);
    vpb = qpb(2:4);
    
    block1 = va - vb;
    block2 = caliber.math.crossProductMatrix(va + vb);
    block3 = zeros(3, 1);
    block4 = zeros(3);
    block5 = vpa - vpb;
    block6 = caliber.math.crossProductMatrix(vpa + vpb);
    
    S = {block1, block2, block3, block4;...
        block5, block6, block1, block2};
    
    S = cell2mat(S);
end

function [x1, x2] = quadraticEquation(a, b, c)
    sqrtDet = sqrt(b*b - 4*a*c);
    x1 = (-b + sqrtDet) / (2 * a);
    x2 = (-b - sqrtDet) / (2 * a);
end