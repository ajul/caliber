import caliber.opt.randRigid
import caliber.opt.math.projection.*
import caliber.opt.math.projection.test.*

h = 1e-6;
M = rand(4);
points = rand(3, 4);
dM = zeros(4);
dM(1, 1) = 1;
dPoints = zeros(3, 4);
dPoints(1, 1) = 1;

projectionTest(@normalizedProjection, h, M, dM, points, dPoints)
