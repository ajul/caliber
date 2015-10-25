% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1647.237658176335100 ; 1648.799609564037200 ];

%-- Principal point:
cc = [ 669.723801280722800 ; 462.154937344070390 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.208156274385174 ; 0.151817651226192 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 13.964483679691208 ; 10.177610469236559 ];

%-- Principal point uncertainty:
cc_error = [ 12.115459960552066 ; 7.536084187186942 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.006633798628167 ; 0.044417652324612 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 12;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.889781e+000 ; 1.796177e+000 ; 4.144196e-001 ];
Tc_1  = [ -5.241415e+001 ; -7.963424e+001 ; 1.075251e+003 ];
omc_error_1 = [ 5.019624e-003 ; 4.016276e-003 ; 4.923597e-003 ];
Tc_error_1  = [ 8.013507e+000 ; 4.900688e+000 ; 6.877375e+000 ];

%-- Image #2:
omc_2 = [ 1.955124e+000 ; 1.893477e+000 ; 2.842893e-001 ];
Tc_2  = [ 1.171450e+002 ; -7.324397e+001 ; 1.054652e+003 ];
omc_error_2 = [ 5.308706e-003 ; 4.195423e-003 ; 5.176514e-003 ];
Tc_error_2  = [ 7.568210e+000 ; 4.816317e+000 ; 6.840937e+000 ];

%-- Image #3:
omc_3 = [ 1.811786e+000 ; 1.684452e+000 ; 5.501029e-001 ];
Tc_3  = [ -2.432154e+002 ; -8.561399e+001 ; 1.068844e+003 ];
omc_error_3 = [ 4.588691e-003 ; 3.860581e-003 ; 4.951515e-003 ];
Tc_error_3  = [ 8.422759e+000 ; 4.920345e+000 ; 6.999155e+000 ];

%-- Image #4:
omc_4 = [ 1.839620e+000 ; 1.775473e+000 ; 6.416604e-001 ];
Tc_4  = [ -1.863027e+002 ; -1.993035e+002 ; 1.046242e+003 ];
omc_error_4 = [ 5.035957e-003 ; 3.888749e-003 ; 5.091652e-003 ];
Tc_error_4  = [ 8.177620e+000 ; 4.819479e+000 ; 6.966168e+000 ];

%-- Image #5:
omc_5 = [ 1.962934e+000 ; 1.999867e+000 ; 3.747028e-001 ];
Tc_5  = [ 1.645308e+002 ; -1.610088e+002 ; 1.024291e+003 ];
omc_error_5 = [ 5.808172e-003 ; 4.453311e-003 ; 5.010744e-003 ];
Tc_error_5  = [ 7.297238e+000 ; 4.710058e+000 ; 6.863242e+000 ];

%-- Image #6:
omc_6 = [ 2.142915e+000 ; 1.792917e+000 ; 3.039655e-001 ];
Tc_6  = [ 1.177097e+002 ; -2.044429e+002 ; 1.019188e+003 ];
omc_error_6 = [ 5.411939e-003 ; 4.124216e-003 ; 5.184825e-003 ];
Tc_error_6  = [ 7.373069e+000 ; 4.631165e+000 ; 6.986936e+000 ];

%-- Image #7:
omc_7 = [ 2.015316e+000 ; 1.611036e+000 ; 5.101743e-001 ];
Tc_7  = [ -1.790925e+002 ; -1.786894e+002 ; 1.049728e+003 ];
omc_error_7 = [ 4.900304e-003 ; 3.857579e-003 ; 4.672254e-003 ];
Tc_error_7  = [ 8.125459e+000 ; 4.774347e+000 ; 7.144231e+000 ];

%-- Image #8:
omc_8 = [ 1.715810e+000 ; 1.824117e+000 ; 4.580437e-001 ];
Tc_8  = [ -1.400674e+002 ; 3.927086e+000 ; 1.090313e+003 ];
omc_error_8 = [ 4.579869e-003 ; 3.961254e-003 ; 5.098868e-003 ];
Tc_error_8  = [ 8.317118e+000 ; 5.005305e+000 ; 6.847634e+000 ];

%-- Image #9:
omc_9 = [ 1.801279e+000 ; 1.949799e+000 ; 2.728799e-001 ];
Tc_9  = [ 9.065084e+001 ; 3.400859e+001 ; 1.075797e+003 ];
omc_error_9 = [ 5.044769e-003 ; 4.197119e-003 ; 5.182854e-003 ];
Tc_error_9  = [ 7.753760e+000 ; 4.932863e+000 ; 6.792057e+000 ];

%-- Image #10:
omc_10 = [ 1.800726e+000 ; 1.848811e+000 ; 1.345477e-001 ];
Tc_10  = [ 8.662216e+001 ; 1.512085e+002 ; 1.080808e+003 ];
omc_error_10 = [ 4.402550e-003 ; 4.013537e-003 ; 5.545745e-003 ];
Tc_error_10  = [ 7.842400e+000 ; 5.033926e+000 ; 6.834571e+000 ];

%-- Image #11:
omc_11 = [ 1.691840e+000 ; 1.727982e+000 ; 3.429169e-001 ];
Tc_11  = [ -1.758535e+002 ; 1.367243e+002 ; 1.096667e+003 ];
omc_error_11 = [ 4.076826e-003 ; 3.962420e-003 ; 5.073855e-003 ];
Tc_error_11  = [ 8.456955e+000 ; 5.114949e+000 ; 6.875459e+000 ];

%-- Image #12:
omc_12 = [ 2.110170e+000 ; 1.649362e+000 ; 4.513569e-001 ];
Tc_12  = [ -7.706257e+001 ; -2.249559e+002 ; 1.035171e+003 ];
omc_error_12 = [ 5.154821e-003 ; 3.912854e-003 ; 4.769557e-003 ];
Tc_error_12  = [ 7.819790e+000 ; 4.674810e+000 ; 7.126041e+000 ];

