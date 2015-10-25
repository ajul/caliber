function facing00(synSigma, doLoocv)

import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

deviceFile1 = 'caliber_data/facing00/a_results.mat';
deviceFile2 = 'caliber_data/facing00/d_results.mat';

if nargin < 2
    doLoocv = 0;
end

if nargin < 1
    synSigma = 0;
end

[tree, initializer, optimizer] = caliber.special.facingDevices(deviceFile1, deviceFile2, 1:13, doLoocv);

if synSigma > 0
    synOpt = optimizer.makeSynthetic(synSigma);
    synOpt.loocv();
end