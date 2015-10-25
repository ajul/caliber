function [ A ] = normc( A )
%NORMC Normalizes the columns of A (via the 2-norm)
    s = ones(size(A, 1), 1) * sqrt(sum(A .* A, 1));
    A = A ./ s;
end

