function plotRectification( K, kc, resolution, n )
    figure;
    axis equal;
    set(gca,'YDir','reverse')
    hold on;
    
    invK = inv(K);
    
    numPoints = (n + 1) * (n + 1);
    distortedPoints = zeros(2, numPoints);
    currPoint = 1;
    for i = 0:n
        u = i / n;
        for j = 0:n
            v = j / n;
            imagePoint = [u; v] .* reshape(resolution, 2, 1);
            distortedPoint = invK * [imagePoint; 1];
            distortedPoints(:, currPoint) = distortedPoint(1:2);
            
            currPoint = currPoint + 1;
        end
    end
    
    unitPlanePoints = caliber.math.projection.inverseRadialDistortion(kc, distortedPoints);
    scatter(unitPlanePoints(1, :), unitPlanePoints(2, :), '+');
    hold off;
end
