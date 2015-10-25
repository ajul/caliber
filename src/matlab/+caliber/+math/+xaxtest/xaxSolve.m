function X = xaxSolve( A1, B1, A2, B2 )
%XAXSOLVE
    A3 = inv(A2) * A1;
    B3 = inv(B2) * B1;
    A4 = B2 * A1;
    B4 = A2 * B1;
    
    X = caliber.math.ax_xb({A3 A4}, {B3, B4});
end

