function K = computeK(f, pp)
%COMPUTEK Summary of this function goes here
K = [diag(f) pp; 0 0 1];
end

