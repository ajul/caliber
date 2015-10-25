function [X1, X2] = xaxSingle( A, B )
%XAXSINGLE 
    RA = A(1:3, 1:3);
    tA = A(1:3, 4);
    tB = B(1:3, 4);
    RAB = A(1:3, 1:3) * B(1:3, 1:3);
    srAB = caliber.math.logmVector(RAB) * 0.5;
    mag = norm(srAB);
    sRAB1 = caliber.math.axisAngle(srAB);
    sRAB2 = caliber.math.axisAngle(srAB - srAB * pi/mag);
    RX1 = RA \ sRAB1;
    RX2 = RA \ sRAB2;
    tX1 = (RX1 * RA + eye(3)) \ (tB - RX1 * tA);
    tX2 = (RX2 * RA + eye(3)) \ (tB - RX2 * tA);
    X1 = [RX1 tX1; 0 0 0 1];
    X2 = [RX2 tX2; 0 0 0 1];
end

