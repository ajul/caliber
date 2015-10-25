function X = mixedSolve( A1, B1, A2, B2 )
%MIXEDSOLVE 
    A = B1 * B2 * A1;
    B = A1 * A2 * B1;
    
    X = caliber.math.ax_xb({A, A2}, {B, B2});
end

