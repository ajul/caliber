function [ K, Ms ] = zhang( planePoints, imagePoints )
%ZHANG Summary of this function goes here
%   Detailed explanation goes here
    numImages = numel(planePoints);
    
    V = cell(numel(planePoints), 1);
    H = cell(1, numel(planePoints));
    for i = 1:numImages
        numPoints = size(planePoints{i}, 2);
        hPlanePoints = [planePoints{i}; ones(1, numPoints)];
        hImagePoints = [imagePoints{i}; ones(1, numPoints)];
        H{i} = caliber.math.dlt(hPlanePoints, hImagePoints);
        V{i} = [computev(H{i}, 1, 2); ...
            computev(H{i}, 1, 1) - computev(H{i}, 2, 2)];
    end
    
    V = cell2mat(V);
    [~, ~, V] = svd(V);
    b = V(:, end);
    pp2 = (b(2) * b(4) - b(1) * b(5)) / (b(1) * b(3) - b(2) * b(2));
    lambda = b(6) - (b(4) * b(4) + pp2 * (b(2) * b(4) - b(1) * b(5))) / b(1);
    f1 = sqrt(lambda / b(1));
    f2 = sqrt(lambda * b(1) / (b(1) * b(3) - b(2) * b(2)));
    skew = -b(2) * f1 * f1 * f2 / lambda;
    pp1 = skew * pp2 / f1 - b(4) * f1 * f1 / lambda;
    
    K = [f1 skew pp1; 0 f2 pp2; 0 0 1]
        
    Ms = cell(size(planePoints));
    
    for i = 1:numImages
        % fixme
        r1 = K \ H{i}(:, 1);
        lambda = 1 / norm(r1); % not the same lambda as before
        r1 = lambda * r1;
        r2 = K \ H{i}(:, 2);
        r2 = lambda * r2;
        r3 = cross(r1, r2);
        R = [r1 r2 r3];
        t = lambda * (K \ H{i}(:, 3));
        Ms{i} = [R t; 0 0 0 1];
    end
    
end

function v = computev(H, i, j)
    HH = H(:, i) * H(:, j)';
    v = [HH(1,1),...
        HH(1,2) + HH(2,1), ...
        HH(2,2),...
        HH(3,1) + HH(1,3), ...
        HH(3,2) + HH(2,3), ...
        HH(3,3)];
end

