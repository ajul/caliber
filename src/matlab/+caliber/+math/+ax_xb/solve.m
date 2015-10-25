function [ X, dof ] = solve( As, Bs, tolR, tolT )
%SOLVE Summary of this function goes here
%   Detailed explanation goes here
    import caliber.math.ax_xb.checkI
    
    n = numel(As);
    axisTypesA = zeros(1, n);
    axisTypesB = zeros(1, n);
    
    for i = 1:n
        axisTypesA(i) = checkI(As{i}, tolR);
        axisTypesB(i) = checkI(Bs{i}, tolR);
    end
    
    %% cases with at least one well-defined rotation axis
    
    hasAxis = (axisTypesA == 0 & axisTypesB == 0);

    infoA = caliber.math.ax_xb.screwInfo(As(hasAxis));
    infoB = caliber.math.ax_xb.screwInfo(Bs(hasAxis));
    
    X = caliber.math.ax_xb.solveNonparallelAxis(infoA, infoB, tolR);
    if ~isempty(X)
        dof = 0;
        return;
    end
    
    X = caliber.math.ax_xb.solveParallelAxis(infoA, infoB, tolR, tolT);
    if ~isempty(X)
        dof = 1;
        return;
    end
    
    X = caliber.math.ax_xb.solveCoincidentAxis(infoA, infoB);
    if ~isempty(X)
        dof = 2;
        return;
    end
    
    %% cases with no well-defined axis
    nearI = (axisTypesA == 1 & axisTypesB == 1);
    
    ta = caliber.math.ax_xb.extractTranslations(As(nearI));
    tb = caliber.math.ax_xb.extractTranslations(Bs(nearI));
    
    n = size(ta, 2);
    nonzeroIndices = true(1, n);
    
    % normalize and select only nonzero
    for i = 1:n
        a = ta(:, i);
        b = tb(:, i);
        na = norm(a);
        nb = norm(b);
        
        if na < tolT || nb < tolT
            nonzeroIndices(i) = 0;
        else
            ta(:, i) = a / na;
            tb(:, i) = b / nb;
        end
    end
    
    ta = ta(:, nonzeroIndices);
    tb = tb(:, nonzeroIndices);
    
    X = caliber.math.ax_xb.solveNonparallelTranslation(ta, tb, tolR);
    if ~isempty(X)
        dof = 3;
        return;
    end
    
    X = caliber.math.ax_xb.solveParallelTranslation(ta, tb);
    if ~isempty(X)
        dof = 4;
        return;
    end
    
    %% cases with no usable information
    
    X = eye(4);
    dof = 6;
end
