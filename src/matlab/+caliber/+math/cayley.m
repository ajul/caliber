function result = cayley(r, idx)
%CAYLEY Cayley transform
    if nargin < 2
        x = r(1);
        y = r(2);
        z = r(3);
        n2 = x*x + y*y + z*z;
        skewPart = 2 * [...
            0, -z, y;
            z, 0, -x;
            -y, x, 0];
        result = (eye(3) * (1 - n2) + 2 * (r * r') + skewPart) / (1 + n2);
    else
        x = r(1);
        y = r(2);
        z = r(3);
        n2 = x*x + y*y + z*z;

        skewPart = 2 * [...
            0, -z, y;
            z, 0, -x;
            -y, x, 0];

        skewSelect = {...
            [0 0 0; 0 0 -1; 0 1 0];...
            [0 0 1; 0 0 0; -1 0 0];...
            [0 -1 0; 1 0 0; 0 0 0];...
        };

        numerator = eye(3) * (1 - n2) + 2 * (r * r') + skewPart;

        result = computeMain(idx);
        return
    end
    
    function dRdaxis = computeMain(axis)
        denominator = 1 + n2;
        ddenomiantor = 2 * r(axis);
        dnumerator = (eye(3) * -r(axis) + skewSelect{axis});
        dnumerator(:, axis) = dnumerator(:, axis) + r;
        dnumerator(axis, :) = dnumerator(axis, :) + r';
        dnumerator = 2 * dnumerator;
        dRdaxis = (denominator * dnumerator - numerator * ddenomiantor) /...
            (denominator * denominator);
    end
end

