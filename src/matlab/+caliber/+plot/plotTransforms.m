function h = plotTransforms( transforms, labels, frameSize )
%PLOTTRANSFORMS Plots transformation matrices.
%transforms: cell array of transform matrices
%labels: cell array of label strings; must have same number of elements as
%transforms
%frameSize: (optional) length of frames

transforms = reshape(transforms, [], 1);
labels = reshape(labels, [], 1);

n = length(transforms);
x = zeros(3, n);
y = zeros(3, n);
z = zeros(3, n);
t = zeros(3, n);

for i = 1:n
    transform = transforms{i};
    
    t(:, i) = transform(1:3, 4);
end

if nargin < 3
    frameSize = max(max(t, [], 2) - min(t, [], 2))  / 8;
    if frameSize < eps
        frameSize = 1;
    end
end

for i = 1:n
    transform = transforms{i};
    
    x(:, i) = transform(1:3, 1) * frameSize + t(:, i);
    y(:, i) = transform(1:3, 2) * frameSize + t(:, i);
    z(:, i) = transform(1:3, 3) * frameSize + t(:, i);
end

h = figure;
hold on;
axis equal;
grid on;
xlabel('x');
ylabel('y');
zlabel('z');

line([t(1, :); x(1, :)], [t(2, :); x(2, :)], [t(3, :); x(3, :)], 'Color', 'r');
line([t(1, :); y(1, :)], [t(2, :); y(2, :)], [t(3, :); y(3, :)], 'Color', 'g');
line([t(1, :); z(1, :)], [t(2, :); z(2, :)], [t(3, :); z(3, :)], 'Color', 'b');
scatter3(t(1,:), t(2,:), t(3,:), 36, 'k', 'o');

text(t(1,:), t(2,:), t(3,:), labels, 'VerticalAlignment', 'Bottom', 'FontSize', 8);

hold off;

end

