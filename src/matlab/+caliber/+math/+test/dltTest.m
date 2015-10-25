scale = 100;
noise = 0;

x = randn(3, 10) * scale;
H = randn(3);
H(3, 3) = 1
y = H * x;

x = x + randn(size(x)) * noise;
y = y + randn(size(y)) * noise;

H = caliber.math.dlt(x, y)