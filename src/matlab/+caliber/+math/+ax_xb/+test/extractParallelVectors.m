function [ a, b ] = extractParallelVectors(A, B)
    a = sqrtm(A(1:3, 1:3)') * A(1:3, 4);
    b = sqrtm(B(1:3, 1:3)') * B(1:3, 4);
    
    ra = caliber.math.logmVector(A);
    rb = caliber.math.logmVector(B);
    theta = 0.5 * (norm(ra) + norm(rb));
    denom = 2 * sin(theta / 2);
    
    a = a / denom;
    b = b / denom;
end

