function c = gridCoordinates2d( n, alignment )
%GRIDCOORDINATES2D 
    if nargin < 2
        alignment = 'center';
    end
    
    switch (alignment)
        case 'center'
            offset = -(n + 1) / 2;
        case 'top-left'
            offset = -1;
    end
    
    [x, y] = find(ones(n));
    x = reshape(x, 1, []) + offset;
    y = reshape(y, 1, []) + offset;
    z = zeros(1, n*n);
    c = [x;y;z];
end

