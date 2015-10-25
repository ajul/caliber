function meanM = meanRigid( Ms )
%MEANTRANSFORM computes the mean of a set of transforms
    import caliber.math.logmVector
    import caliber.math.axisAngle
    
    n = length(Ms);
    rs = zeros(3, n);
    ts = zeros(3, n);
    R1 = Ms{1}(1:3, 1:3);
    rs(:, 1) = [0;0;0];
    ts(:, 1) = Ms{1}(1:3, 4);
    for i = 2:n
        M = Ms{i};
        Ri = M(1:3, 1:3);
        rs(:, i) = real(logmVector(Ri / R1));
        ts(:, i) = M(1:3, 4);
    end
    meanr = mean(rs, 2);
    meant = mean(ts, 2);
    meanR = axisAngle(meanr) * R1;
    meanM = [meanR meant; 0 0 0 1];
end

