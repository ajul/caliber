% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2468.938327019387100 ; 2469.168969583159700 ];

%-- Principal point:
cc = [ 639.604985851308020 ; 482.887874343220060 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.259106550679286 ; 0.191938219499183 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 9.142838028009214 ; 9.245084255587003 ];

%-- Principal point uncertainty:
cc_error = [ 4.840698231950707 ; 5.439921316271492 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.004755093000621 ; 0.053187281670218 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.085517e+000 ; 2.062400e+000 ; -1.345057e-002 ];
Tc_1  = [ -1.129859e+002 ; -7.689227e+001 ; 1.230357e+003 ];
omc_error_1 = [ 1.331391e-003 ; 1.354826e-003 ; 2.540299e-003 ];
Tc_error_1  = [ 2.420389e+000 ; 2.708503e+000 ; 4.572985e+000 ];

%-- Image #2:
omc_2 = [ 2.168835e+000 ; 2.161325e+000 ; -1.990313e-001 ];
Tc_2  = [ 1.259916e+002 ; -8.904838e+001 ; 1.249514e+003 ];
omc_error_2 = [ 1.536556e-003 ; 1.584765e-003 ; 2.797898e-003 ];
Tc_error_2  = [ 2.457021e+000 ; 2.752397e+000 ; 4.756936e+000 ];

%-- Image #3:
omc_3 = [ 2.243140e+000 ; 2.162641e+000 ; -1.285900e-001 ];
Tc_3  = [ 1.175362e+002 ; -1.797319e+002 ; 1.230946e+003 ];
omc_error_3 = [ 1.717997e-003 ; 1.733046e-003 ; 2.747733e-003 ];
Tc_error_3  = [ 2.429753e+000 ; 2.711156e+000 ; 4.761955e+000 ];

%-- Image #4:
omc_4 = [ 2.125617e+000 ; 1.997992e+000 ; 1.465925e-001 ];
Tc_4  = [ -2.388945e+002 ; -1.569878e+002 ; 1.185523e+003 ];
omc_error_4 = [ 1.286904e-003 ; 1.302793e-003 ; 2.596456e-003 ];
Tc_error_4  = [ 2.362722e+000 ; 2.626855e+000 ; 4.561344e+000 ];

%-- Image #5:
omc_5 = [ 1.918660e+000 ; 2.025518e+000 ; -2.306724e-002 ];
Tc_5  = [ -2.230289e+002 ; 5.240689e+001 ; 1.220284e+003 ];
omc_error_5 = [ 1.212950e-003 ; 1.254945e-003 ; 2.383479e-003 ];
Tc_error_5  = [ 2.418947e+000 ; 2.716290e+000 ; 4.509390e+000 ];

%-- Image #6:
omc_6 = [ 2.288222e+000 ; 1.752459e+000 ; 3.495179e-002 ];
Tc_6  = [ -2.660580e+002 ; -6.251698e+000 ; 1.207593e+003 ];
omc_error_6 = [ 1.294980e-003 ; 1.161428e-003 ; 2.550319e-003 ];
Tc_error_6  = [ 2.391163e+000 ; 2.690372e+000 ; 4.502996e+000 ];

%-- Image #7:
omc_7 = [ 2.451119e+000 ; 1.770171e+000 ; 6.772176e-002 ];
Tc_7  = [ -1.923013e+002 ; -1.547628e+002 ; 1.202359e+003 ];
omc_error_7 = [ 1.538588e-003 ; 1.294760e-003 ; 2.888258e-003 ];
Tc_error_7  = [ 2.376778e+000 ; 2.650675e+000 ; 4.561752e+000 ];

%-- Image #8:
omc_8 = [ 2.491913e+000 ; 1.887998e+000 ; -1.431149e-001 ];
Tc_8  = [ 4.602397e+001 ; -1.666961e+002 ; 1.234786e+003 ];
omc_error_8 = [ 1.831747e-003 ; 1.528043e-003 ; 2.836677e-003 ];
Tc_error_8  = [ 2.434227e+000 ; 2.709356e+000 ; 4.680962e+000 ];

%-- Image #9:
omc_9 = [ 2.304834e+000 ; 1.889877e+000 ; -2.863025e-001 ];
Tc_9  = [ 6.109519e+001 ; 5.168430e+001 ; 1.267152e+003 ];
omc_error_9 = [ 1.447661e-003 ; 1.251239e-003 ; 2.757541e-003 ];
Tc_error_9  = [ 2.487803e+000 ; 2.797650e+000 ; 4.705885e+000 ];

%-- Image #10:
omc_10 = [ 1.527434e+000 ; 2.620697e+000 ; 1.181069e-002 ];
Tc_10  = [ 1.690595e+002 ; -1.782173e+002 ; 1.222989e+003 ];
omc_error_10 = [ 1.317655e-003 ; 1.969956e-003 ; 2.928584e-003 ];
Tc_error_10  = [ 2.406237e+000 ; 2.708380e+000 ; 4.843486e+000 ];

%-- Image #11:
omc_11 = [ 1.340917e+000 ; 2.507208e+000 ; 1.409122e-001 ];
Tc_11  = [ -7.860192e+001 ; -1.614478e+002 ; 1.209640e+003 ];
omc_error_11 = [ 1.000271e-003 ; 1.527135e-003 ; 2.854750e-003 ];
Tc_error_11  = [ 2.390016e+000 ; 2.667661e+000 ; 4.619113e+000 ];

%-- Image #12:
omc_12 = [ 1.294317e+000 ; 2.518962e+000 ; 6.436397e-002 ];
Tc_12  = [ -5.509743e+001 ; -8.953800e+001 ; 1.227568e+003 ];
omc_error_12 = [ 9.865141e-004 ; 1.520863e-003 ; 2.818348e-003 ];
Tc_error_12  = [ 2.414125e+000 ; 2.704563e+000 ; 4.608569e+000 ];

