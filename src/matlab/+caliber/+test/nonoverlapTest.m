import containers.Map
import caliber.math.projection.*
import caliber.math.*
import caliber.plot.*

f1 = 'caliber_data/stereo_03/m_results.mat';
f2 = 'caliber_data/stereo_03/c_results.mat';

initOpt = caliber.nonoverlap(f1, f2, 1:12);
