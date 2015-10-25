function [ X ] = solveParallelAxis( infoA, infoB, tolR, tolT ) 
%PARALLELSOLVE Summary of this function goes here
%   Detailed explanation goes here

    n = infoA.n;
    
    if n < 2
        X = [];
        return;
    end
    
    nn = n * (n - 1) / 2;
    framesA = cell(1, nn);
    framesB = cell(1, nn);
    
    idx = 1;
    for i = 1:n
        for j = (i+1):n
            frameA = computeFrame2(infoA.axis(:, i), infoA.o(:, i), infoA.o(:, j), tolT);
            frameB = computeFrame2(infoB.axis(:, i), infoB.o(:, i), infoB.o(:, j), tolT);
            if numel(frameA) == numel(frameB)
                framesA{idx} = frameA;
                framesB{idx} = frameB;
            end
            idx = idx + 1;
        end
    end
    
    R = caliber.math.ax_xb.solveRotation0DoF( cell2mat(framesA), cell2mat(framesB), tolR );
    
    if isempty(R)
        X = [];
        return;
    end
    
    if ~any(any(R)) || any(any(isnan(R)))
        X = [];
        return
    end
    
    t = caliber.math.ax_xb.solveTranslation1DoF(R, infoA, infoB);
    
    % If NaNs were computed, discard answer.
    if any(isnan(t))
        X = [];
        return
    end

    % Finally, assemble R and t into a matrix and return it.
    X = [R t; 0 0 0 1];
end

function F = computeFrame2(axis1, o1, o2, tolT)
    v1 = axis1;
    
    diff = o2 - o1;
    diff = diff - axis1 * dot(diff, axis1);
    diffNorm = norm(diff);
    if diffNorm < tolT
        F = [];
        return;
    end
    
    v2 = diff / diffNorm;
    F = [v1 v2];
end

function F = computeFrame3(axis1, o1, o2, tolT)
    v1 = axis1;
    
    diff = o2 - o1;
    diff = diff - axis1 * dot(diff, axis1);
    diffNorm = norm(diff);
    if diffNorm < tolT
        F = [];
        return;
    end
    
    v2 = diff / diffNorm;
    v3 = cross(v1, v2);
    F = [v1 v2 v3];
end
