function result = axisAngle(r, idx)
%axisAngle: axis-angle representation
%r: 3-vector
%idx: if supplied, returns the 
    if nargin < 2
        theta = norm(r);
        if theta < sqrt(eps)
            x = r(1);
            y = r(2);
            z = r(3);
            result = (1 - theta*theta/2) * eye(3) + r * r' + ...
                [0 -z y; x 0 -z; -y x 0];
            return
        end
        x = r(1) / theta;
        y = r(2) / theta;
        z = r(3) / theta;
        s = sin(theta/2);
        c = cos(theta/2);
        result = [2*(x*x-1)*s*s+1, 2*s*(x*y*s-z*c), 2*s*(x*z*s+y*c);...
            2*s*(x*y*s+z*c), 2*(y*y-1)*s*s+1, 2*s*(y*z*s-x*c);...
            2*s*(x*z*s-y*c), 2*s*(y*z*s+x*c), 2*(z*z-1)*s*s+1];
        return
    else
        theta = norm(r); % rotation magnitude
        if theta < sqrt(eps)/2
            skewSelect = {...
                [0 0 0; 0 0 -1; 0 1 0];...
                [0 0 1; 0 0 0; -1 0 0];...
                [0 -1 0; 1 0 0; 0 0 0];...
            };

            result = computeSmall(idx);
            return
        end

        rn = r / theta; % unit vector corresponding to the rotation axis
        s = sin(theta/2); % sine of the half angle
        sc = sin(theta) / 2; % sine times cosine of the half angle
        ss = s*s; % sine squared of the half angle

        % derivatives with respect to the rotation vector r
        drndr = (eye(3) - rn * rn') / theta; % axis unit vector
        dssdr = sin(theta) * rn / 2; % sin squared of the half angle
        dscdr = cos(theta) * rn / 2; % sine times cosine of the half angle
        
        result = computeMain(idx);
    end
    
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
