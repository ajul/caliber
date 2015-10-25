function [ X ] = solveNonparallelAxis( infoA, infoB, tolR ) 
%UNIQUESOLUTION Solves A_iX = XB_i for X, in the least squares sense.
% As and Bs are cell vectors of length n, containing matrices
% Returns [] on failure.
% Copied from original treeinit and converted to MATLAB syntax.
% Method is from F.C. Park & B.J. Martin, Robot Sensor Calibration: Solving
% AX = XB on the Euclidean Group, IEEE Tr. Robotics & Automation 10:5 1994.
    n = infoA.n;
    
    if n < 2
        X = [];
        return
    end
    
    R = caliber.math.ax_xb.solveRotation0DoF( infoA.r, infoB.r, tolR );
    
    if isempty(R)
        X = [];
        return;
    end
    
    % If rotation is zero or NaN, discard.
    if ~any(any(R)) || any(any(isnan(R)))
        X = [];
        return
    end
    
    t = caliber.math.ax_xb.solveTranslation0DoF(R, infoA, infoB);
    
    % If NaNs were computed, discard answer.
    if any(isnan(t))
        X = [];
        return
    end

    % Finally, assemble R and t into a matrix and return it.
    X = [R t; 0 0 0 1];
end


