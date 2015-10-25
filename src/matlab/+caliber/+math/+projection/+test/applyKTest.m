import caliber.opt.math.projection.*
import caliber.opt.math.projection.test.*

h = 1e-6;
K = rand(3);
points = rand(2, 4);
dK = zeros(3);
dK(1, 1) = 1;
dPoints = zeros(2, 4);
dPoints(1, 1) = 1;

projectionTest(@applyK, h, K, dK, points, dPoints)