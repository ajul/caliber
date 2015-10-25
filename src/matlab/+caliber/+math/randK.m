function [fnoise, ppnoise, Knoise ] = randK(fnoise, ppnoise)
    import caliber.math.computeK
    fnoise = (rand(2, 1) * 2 - 1) * fnoise;
    ppnoise = (rand(2, 1) * 2 - 1) * ppnoise;
    Knoise = computeK(fnoise, ppnoise);
end

