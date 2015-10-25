% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3608.145103072427000 ; 3618.636667604731400 ];

%-- Principal point:
cc = [ 612.274681351001850 ; 444.169626660176620 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.225897408287408 ; -95.630618675302699 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 350.211225357844170 ; 350.546398104675230 ];

%-- Principal point uncertainty:
cc_error = [ 173.160742806774980 ; 139.954850229330190 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 1.613275840385869 ; 507.986941804640200 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 8;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.106561e+000 ; 2.530329e+000 ; -3.755969e-001 ];
Tc_1  = [ 7.447740e+000 ; -5.386915e+000 ; 2.120199e+002 ];
omc_error_1 = [ 1.668575e-002 ; 5.162240e-002 ; 4.415791e-002 ];
Tc_error_1  = [ 1.017338e+001 ; 8.195862e+000 ; 2.046307e+001 ];

%-- Image #2:
omc_2 = [ 1.637988e+000 ; 2.169626e+000 ; -2.411525e-001 ];
Tc_2  = [ 4.730008e+000 ; -3.876600e+000 ; 2.106729e+002 ];
omc_error_2 = [ 2.708270e-002 ; 4.541811e-002 ; 4.451991e-002 ];
Tc_error_2  = [ 1.010811e+001 ; 8.143444e+000 ; 2.039369e+001 ];

%-- Image #3:
omc_3 = [ 7.890212e-001 ; 2.796778e+000 ; -5.237700e-001 ];
Tc_3  = [ 7.324665e+000 ; -5.795979e+000 ; 2.113464e+002 ];
omc_error_3 = [ 7.336712e-003 ; 5.426720e-002 ; 4.759192e-002 ];
Tc_error_3  = [ 1.014298e+001 ; 8.168078e+000 ; 2.042595e+001 ];

%-- Image #4:
omc_4 = [ 5.989564e-002 ; -3.084497e+000 ; 5.447821e-002 ];
Tc_4  = [ 1.060934e+001 ; -3.529349e+000 ; 2.085763e+002 ];
omc_error_4 = [ 3.562482e-003 ; 7.133626e-002 ; 1.515474e-001 ];
Tc_error_4  = [ 1.000857e+001 ; 8.066248e+000 ; 2.016622e+001 ];

%-- Image #5:
omc_5 = [ 8.722735e-002 ; -2.993109e+000 ; 6.115880e-001 ];
Tc_5  = [ 1.090416e+001 ; -4.833674e+000 ; 2.107931e+002 ];
omc_error_5 = [ 1.473690e-002 ; 4.287378e-002 ; 6.385702e-002 ];
Tc_error_5  = [ 1.011573e+001 ; 8.149994e+000 ; 2.037035e+001 ];

%-- Image #6:
omc_6 = [ 1.236305e+000 ; 2.724041e+000 ; -6.359873e-001 ];
Tc_6  = [ 2.159287e+000 ; -5.948638e+000 ; 2.050180e+002 ];
omc_error_6 = [ 9.007017e-003 ; 5.442586e-002 ; 4.805442e-002 ];
Tc_error_6  = [ 9.838598e+000 ; 7.925065e+000 ; 1.975448e+001 ];

%-- Image #7:
omc_7 = [ 1.494242e+000 ; 2.504032e+000 ; -3.430397e-001 ];
Tc_7  = [ 1.251366e+000 ; -5.079969e+000 ; 2.037106e+002 ];
omc_error_7 = [ 1.968886e-002 ; 4.873778e-002 ; 4.754645e-002 ];
Tc_error_7  = [ 9.775546e+000 ; 7.873429e+000 ; 1.972580e+001 ];

%-- Image #8:
omc_8 = [ 1.374455e+000 ; 2.173202e+000 ; 4.431287e-002 ];
Tc_8  = [ 9.430601e-001 ; -5.003946e+000 ; 2.047565e+002 ];
omc_error_8 = [ 3.048757e-002 ; 4.390962e-002 ; 3.989144e-002 ];
Tc_error_8  = [ 9.825497e+000 ; 7.916354e+000 ; 1.987065e+001 ];

