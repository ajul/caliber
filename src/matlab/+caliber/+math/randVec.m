function x = randVec(maxMagnitude)
%RANDVEC Produces a random vector within the ball of radius maxMagnitude.
    if nargin < 1
        maxMagnitude = 1;
    end
    x = 2 * rand(3, 1) - ones(3, 1);
    lenx = norm(x);
    while lenx > 1
        x = 2 * rand(3, 1) - ones(3, 1);
        lenx = norm(x);
    end
    x = x * maxMagnitude;
end
