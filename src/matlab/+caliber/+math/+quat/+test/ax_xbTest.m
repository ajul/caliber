X = caliber.math.randRigid()

A1 = caliber.math.randRigid()
R1 = A1(1:3, 1:3);
B1 = X \ A1 * X

% A2 = caliber.math.randRigid()
A2 = A1 * [R1 zeros(3, 1); 0 0 0 1]
B2 = X \ A2 * X

Xest1 = caliber.math.ax_xb({A1;A2}, {B1; B2})

[Xest2, c] = caliber.math.quat.ax_xb({A1;A2}, {B1; B2})
