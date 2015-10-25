function [ X ] = solveCoincidentAxis( infoA, infoB ) 
%COINCIDENTSOLVE
    n = infoA.n;
    
    if n < 1
        X = [];
        return;
    end
    
    R = caliber.math.ax_xb.solveRotation1DoF(infoA.axis, infoB.axis);
    
    t = caliber.math.ax_xb.solveTranslation1DoF(R, infoA, infoB);
    
    X = [R t; 0 0 0 1];
end
