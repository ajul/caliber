function logA = logmVector(A)
%LOGMVECTOR Takes the logarithm of a rotation matrix and expresses it as
%a vector. Warning: Uses logm, and so cannot handle 180 degree rotations.
    % Default impelmentation.
    L = logm(A(1:3,1:3));
    logA = real([L(3, 2); L(1, 3); L(2, 1)]);
end

function logA = logmStandard(A)
	% Default impelmentation.
    L = logm(A(1:3,1:3));
    logA = real([L(3, 2); L(1, 3); L(2, 1)]);
end

function logA = logmVectorEig(A)
%Alternate implementation of logmVector.
    A = A(1:3, 1:3);
    n = norm(A, 'fro') / sqrt(3);
    theta = acos((trace(A) - n) / (2 * n));
    [V, D] = eig(A);
    [~, idx] = max(real(diag(D)));
    logA = V(:, idx) * theta;
end
