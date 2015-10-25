function dRdr = axisAngleDerivative(r, idx)
%ANGLEAXISDERIVATIVE Computes matrices dR/dx, dR/dy, and dR/dz
% for an angle-axis representation 3x1 vector r.
% Does this using the derivative of the 
    % basic information
    theta = norm(r); % rotation magnitude
    if theta < sqrt(eps)/2
        skewSelect = {...
            [0 0 0; 0 0 -1; 0 1 0];...
            [0 0 1; 0 0 0; -1 0 0];...
            [0 -1 0; 1 0 0; 0 0 0];...
        };
    
        if nargin >= 2
            dRdr = computeSmall(idx);
            return
        end
        dRdx = computeSmall(1);
        dRdy = computeSmall(2);
        dRdz = computeSmall(3);
        
        dRdr = {dRdx; dRdy; dRdz};
        return;
    end
    
    rn = r / theta; % unit vector corresponding to the rotation axis
    s = sin(theta/2); % sine of the half angle
    sc = sin(theta) / 2; % sine times cosine of the half angle
    ss = s*s; % sine squared of the half angle
    
    % derivatives with respect to the rotation vector r
    drndr = (eye(3) - rn * rn') / theta; % axis unit vector
    dssdr = sin(theta) * rn / 2; % sin squared of the half angle
    dscdr = cos(theta) * rn / 2; % sine times cosine of the half angle
    
    if nargin >= 2
        dRdr = computeMain(idx);
        return
    end
    dRdx = computeMain(1);
    dRdy = computeMain(2);
    dRdz = computeMain(3);
    
    dRdr = {dRdx; dRdy; dRdz};
    
    function dRdaxis = computeMain(axis)
        dRdaxis = 2 * (-eye(3) * dssdr(axis) + computeSym() + computeSkew());
        
        function symPart = computeSym()
            % symmetric part of the off-diagonals
            rnrn = rn * rn';
            drnrndx = drndr(:, axis) * rn';
            drnrndx = drnrndx + drnrndx';
            symPart = drnrndx * ss + rnrn * dssdr(axis);
        end

        function skewPart = computeSkew()
            % skew-symmetric part of the off-diagonals
            skewVec = drndr(:, axis) * sc + rn .* dscdr(axis);
            skewPart = [...
                0, -skewVec(3), skewVec(2);
                skewVec(3), 0 -skewVec(1);
                -skewVec(2), skewVec(1), 0];
        end
    end

    function dRdaxis = computeSmall(axis)
        dRdaxis = -theta * eye(3) + skewSelect{axis};
        dRdaxis(axis, :) = dRdaxis(axis, :) + r'/2;
        dRdaxis(:, axis) = dRdaxis(:, axis) + r/2;
    end
    
end
