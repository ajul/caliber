function nonoverlap00(synSigma, doLoocv)

import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

close all;

if nargin < 2
    doLoocv = 0;
end

if nargin < 1
    synSigma = 0;
end

f1 = 'data/nonoverlap05/D_Results.mat';
f2 = 'data/nonoverlap05/M_Results.mat';
f3 = 'data/nonoverlap05/C_Results.mat';
f4 = 'data/nonoverlap05/R_Results.mat';

[tree, initializer, optimizer] = caliber.special.nonoverlap({f1, f2, f3, f4}, 1:6, doLoocv);
if synSigma > 0
    synOpt = optimizer.makeSynthetic(synSigma);
    synOpt.loocv();
end