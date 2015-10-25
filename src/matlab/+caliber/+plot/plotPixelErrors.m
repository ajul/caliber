function plotPixelErrors( data )
%PLOTPIXELERRORS Summary of this function goes here
%   Detailed explanation goes here
    figure;
    hold on;
    axis equal;
    set(gca,'YDir','reverse');
    xlabel('x');
    ylabel('y');
    n = numel(data);
    
    for i=1:n
        points = reshape(data{i}, 2, []);
        h = i * 360 / n;
        rgb = caliber.plot.hcy2rgb([h, 1, 0.11]);
        s = sprintf('%d', i);
        caliber.plot.scatterChar(points(1, :), points(2, :), s, rgb);
    end

    hold off;
end

