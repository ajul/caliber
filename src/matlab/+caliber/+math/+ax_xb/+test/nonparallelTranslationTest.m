X = caliber.math.randRigid()
A1 = [eye(3) randn(3, 1); 0 0 0 1]
B1 = X \ A1 * X

A2 = [eye(3) randn(3, 1); 0 0 0 1]
B2 = X \ A2 * X

[Xsolve, dof] = caliber.math.ax_xb.solve({A1, A2}, {B1, B2}, 1e-3)

A1 * Xsolve - Xsolve * B1
A2 * Xsolve - Xsolve * B2
