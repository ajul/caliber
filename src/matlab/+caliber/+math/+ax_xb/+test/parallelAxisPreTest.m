close all;

ra1 = randn(3, 1);
theta1 = norm(ra1);
ra2 = ra1 * randn;
RA1 = caliber.math.axisAngle(ra1);
RA2 = caliber.math.axisAngle(ra2);

X = caliber.math.randRigid()
rx = caliber.math.logmVector(X);
RX = X(1:3, 1:3);
A1 = [RA1 randn(3, 1); 0 0 0 1]
B1 = X \ A1 * X
A2 = [RA2 randn(3, 1); 0 0 0 1]
B2 = X \ A2 * X

sqrtm(RA1) - sqrtm(RA1)'
2 * sin(theta1 / 2) * logm(RA1) / theta1

[a1, b1] = caliber.math.ax_xbtest.test.extractParallelVectors(A1, B1)
[a2, b2] = caliber.math.ax_xbtest.test.extractParallelVectors(A2, B2)

da = a1 - a2;
db = b1 - b2;

diff1 = RX * b1 - a1 - (RX * b2 - a2)
diff2 = RX * db - da

nda = da / norm(da);
ndb = db / norm(db);
r = cross(ndb, nda);
s = norm(r);
theta = acos(dot(nda, ndb, 1));   % computation could be improved?
r = r * theta / s;

RXest = caliber.math.axisAngle(r)
RX

diff1 = RXest * b1 - a1 - (RXest * b2 - a2)

c = RX * b1 - a1
cest = RXest * b1 - a1

caliber.plot.plotVectors([da db r rx ra1 ra2 c cest], {'da', 'db', 'r (estimated)', 'rx (actual)', 'ra1', 'ra2', 'c', 'cest'});