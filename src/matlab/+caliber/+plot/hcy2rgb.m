function [ rgb ] = hcy2rgb( hcy )
%HSV2RGB converts a n x 3 array of hcy (hue, chroma, luma) values 
% to a n x 3 array of rgb values
%formulas based on http://en.wikipedia.org/wiki/HSL_and_HSV
H = hcy(:, 1) / 60;
C = hcy(:, 2);
Y = hcy(:, 3);
X = C .* (1 - abs(mod(H, 2) - 1));

region = floor(mod(H, 6));

R = (region == 0 | region == 5) .* C + (region == 1 | region == 4) .* X;
G = (region == 1 | region == 2) .* C + (region == 0 | region == 3) .* X;
B = (region == 3 | region == 4) .* C + (region == 5 | region == 2) .* X;

m = Y - (0.30*R + 0.59*G + 0.11*B);
rgb = [R+m,G+m,B+m];
rgb = min(rgb, 1);
rgb = max(rgb, 0);
end

