function pp = estimatePixelPitch( resX, resY, diag, diagUnits )
%ESTIMATEPIXELPITCH Summary of this function goes here
%   Detailed explanation goes here
if nargin < 4
    diagUnits = 'in';
end

resDiag = sqrt(resX*resX + resY*resY);
switch (diagUnits)
    case 'mm'
        mult = 1;
    case 'in'
        mult = 25.4;
end

pp = diag * mult / resDiag;

end

