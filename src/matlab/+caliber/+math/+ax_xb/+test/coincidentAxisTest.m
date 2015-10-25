A = caliber.math.randRigid()
X = caliber.math.randRigid()
B = X \ A * X

[Xsolve, dof] = caliber.math.ax_xb.solve({A}, {B}, 1e-6)

A * Xsolve - Xsolve * B

