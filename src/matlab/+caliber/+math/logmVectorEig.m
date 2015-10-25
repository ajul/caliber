function logA = logmVectorEig(A)
%Alternate implementation of logmVector that handles 180 degree rotations.
    A = A(1:3, 1:3);
    n = norm(A, 'fro') / sqrt(3);
    theta = acos((trace(A) - n) / (2 * n));
    [V, D] = eig(A);
    [~, idx] = max(real(diag(D)));
    logA = V(:, idx) * theta;
end
