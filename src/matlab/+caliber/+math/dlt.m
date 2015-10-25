function [ H ] = dlt( x, y )
%DLT Direct Linear Transformation
% Source:
% Richard Hartley and Andrew Zisserman (2003). Multiple View Geometry in
% computer vision. Cambridge University Press.

    n = size(x, 2);
    [x, Tx] = normalizePoints(x);
    [y, Ty] = normalizePoints(y);
    
    A = cell(n, 1);
    for i = 1:n
        xi = x(:, i)';
        A{i} = [0 0 0 -y(3, i)*xi  y(2, i)*xi;...
            y(3, i)*xi 0 0 0 -y(1, i)*xi];
    end
    
    A = cell2mat(A);
    [~, ~, V] = svd(A);
    h = V(:, end);
    H = zeros(3);
    H(1, :) = h(1:3);
    H(2, :) = h(4:6);
    H(3, :) = h(7:9);
    
    H = (Ty \ H) * Tx;
    
    % H = H / H(3, 3);
end

function [x, T] = normalizePoints(x)
    centroid = mean(x(1:2, :), 2);
    sigma = [norm(x(1, :)); norm(x(2, :))];
    T = [diag(sigma), -(centroid ./ sigma); 0 0 1 ./ norm(x(3, :))];
    x = T * x;
end
