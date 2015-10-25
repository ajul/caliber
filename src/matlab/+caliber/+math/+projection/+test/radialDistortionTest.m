import caliber.opt.plotImagePoints
import caliber.opt.math.projection.*
import caliber.opt.math.projection.test.*

h = 1e-6;
kc = rand(2, 1);
points = rand(2, 4);
drd = zeros(2, 1);
drd(2) = 1;
dPoints = zeros(2, 4);
dPoints(1, 1) = 1;

projectionTest(@radialDistortion, h, kc, drd, points, dPoints)

n = 16;
size = 4;
kc = [-1/256, 1/1024];
unitPlanePoints = (0:n) * (size / n);
unitPlanePoints = ones(n+1, 1) * unitPlanePoints;
unitPlanePoints = [reshape(unitPlanePoints, 1, []); reshape(unitPlanePoints', 1, [])];
distortedPoints = radialDistortion( kc, unitPlanePoints );
plotImagePoints(unitPlanePoints, distortedPoints);