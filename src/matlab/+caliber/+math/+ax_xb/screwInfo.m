function [ info ] = screwInfo( Ms )
%SCREWINFO 

    n = length(Ms);
    
    info = struct();
    info.M = Ms;
    info.axis = zeros(3, n);
    info.theta = zeros(1, n);
    info.o = zeros(3, n);
    info.R = cell(1, n);
    info.t = zeros(3, n);
    info.tmag = zeros(1, n);
    info.n = n;
    
    for i = 1:n
        [info.r(:, i), info.o(:, i), info.tmag(i)] = caliber.math.xf2screw(Ms{i});
        info.theta(i) = norm(info.r(:, i));
        info.axis(:, i) = info.r(:, i) / info.theta(i);
        info.R{i} = Ms{i}(1:3, 1:3);
        info.t(:, i) = Ms{i}(1:3, 4);
    end


end

