function x = randDir()
%RANDDIR Generates a random unit vector.
    z = 2 * rand() - 1;
    theta = rand();
    x = cos(2 * pi * theta) * sqrt(1-z*z);
    y = sin(2 * pi * theta) * sqrt(1-z*z);
    x = [x;y;z];
end
