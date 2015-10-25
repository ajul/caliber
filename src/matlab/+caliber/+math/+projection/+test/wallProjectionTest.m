n = 10;

worldPoints = [randn(2, n); zeros(1, n)]
M = caliber.math.randRigid()

unitPlanePoints = caliber.math.projection.normalizedProjection(M, worldPoints)

% H = caliber.math.dlt([worldPoints(1:2, :); ones(1, n)], [unitPlanePoints; ones(1, n)])

worldPoints = caliber.math.projection.wallProjection(M, unitPlanePoints)

dUnitPlanePoints = [ones(1, n); zeros(1, n)];
dM = caliber.math.randRigid();
caliber.math.projection.test.derivTest(@caliber.math.projection.wallProjection, M, unitPlanePoints, dM, dUnitPlanePoints);