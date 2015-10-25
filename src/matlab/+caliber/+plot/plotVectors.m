function h = plotVectors( v, labels )
%PLOTVECTORS Summary of this function goes here
%   Detailed explanation goes here

n = size(v, 2);
x = [zeros(1, n); v(1, :)];
y = [zeros(1, n); v(2, :)];
z = [zeros(1, n); v(3, :)];

h = figure;
hold on;
axis equal;
grid on;
xlabel('x');
ylabel('y');
zlabel('z');

line(x, y, z);

if nargin >= 2
    for i = 1:n
        text(v(1,:), v(2,:), v(3,:), labels, 'VerticalAlignment', 'Bottom', 'FontSize', 8);
    end
end

hold off;

end

