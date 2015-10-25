function plotOnImage( imageData, circles, pluses )
%PLOTONIMAGE 
    figure;
    axis equal;
    set(gca,'YDir','reverse')
    hold on;
    image(imageData);
%     lineX = [circles(1, :); pluses(1, :)];
%     lineY = [circles(2, :); pluses(2, :)];
%     line(lineX, lineY, 'Color', 'k');
    scatter(circles(1, :), circles(2, :), 'b', 'o');
    scatter(pluses(1, :), pluses(2, :), 'r', '+');
    %hold off;
end

