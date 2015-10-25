function result = checkI(A, tolR)
    %CHECKI Checks if the rotational part of A is too close to I
    %result is 1 if close to I, -1 if close to a 180 degree rotation, 0
    %otherwise
    
    % d = norm(caliber.math.logmVector(A));
    R = A(1:3, 1:3);
    [~, D] = eig(R);
    d = abs(max(imag(diag(D))));
    if d < tolR
        if trace(D) > 1
            result = 1;
        else
            result = -1;
        end
    else
        result = 0;
    end
end
