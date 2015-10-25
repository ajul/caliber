% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1682.687912746950100 ; 1684.120915216175300 ];

%-- Principal point:
cc = [ 608.027253515827620 ; 433.562778779128340 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.192249878292694 ; 0.039658238514804 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 18.801697852693280 ; 17.420189919893510 ];

%-- Principal point uncertainty:
cc_error = [ 17.302570428637903 ; 16.034605561339706 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.010179176360099 ; 0.089806117371514 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 6;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.008992e+000 ; -2.058039e+000 ; 7.400308e-001 ];
Tc_1  = [ -6.417365e+000 ; -1.198996e+002 ; 1.278959e+003 ];
omc_error_1 = [ 5.897455e-003 ; 4.021304e-003 ; 1.469760e-002 ];
Tc_error_1  = [ 1.315814e+001 ; 1.211354e+001 ; 1.384357e+001 ];

%-- Image #2:
omc_2 = [ -2.020873e+000 ; -2.097811e+000 ; 8.400372e-001 ];
Tc_2  = [ 5.977121e-001 ; -1.468875e+001 ; 1.297269e+003 ];
omc_error_2 = [ 6.524431e-003 ; 4.347479e-003 ; 1.411223e-002 ];
Tc_error_2  = [ 1.333395e+001 ; 1.233480e+001 ; 1.366539e+001 ];

%-- Image #3:
omc_3 = [ -1.894456e+000 ; -2.011563e+000 ; 9.583739e-001 ];
Tc_3  = [ 2.040705e+002 ; -1.765413e+001 ; 1.285237e+003 ];
omc_error_3 = [ 6.757323e-003 ; 4.436936e-003 ; 1.283836e-002 ];
Tc_error_3  = [ 1.355448e+001 ; 1.227831e+001 ; 1.329868e+001 ];

%-- Image #4:
omc_4 = [ -2.116900e+000 ; -2.161438e+000 ; 7.407237e-001 ];
Tc_4  = [ -1.553860e+002 ; -1.297671e+001 ; 1.285250e+003 ];
omc_error_4 = [ 6.282038e-003 ; 4.337784e-003 ; 1.508334e-002 ];
Tc_error_4  = [ 1.305633e+001 ; 1.225506e+001 ; 1.417102e+001 ];

%-- Image #5:
omc_5 = [ -1.849365e+000 ; -2.215536e+000 ; 8.342339e-001 ];
Tc_5  = [ 8.540347e+001 ; -7.610442e+001 ; 1.285556e+003 ];
omc_error_5 = [ 6.514605e-003 ; 4.492652e-003 ; 1.351421e-002 ];
Tc_error_5  = [ 1.333009e+001 ; 1.217625e+001 ; 1.371120e+001 ];

%-- Image #6:
omc_6 = [ -1.970404e+000 ; -2.132565e+000 ; 9.545359e-001 ];
Tc_6  = [ 6.336313e+001 ; 6.650283e+001 ; 1.304921e+003 ];
omc_error_6 = [ 7.124086e-003 ; 4.630259e-003 ; 1.324837e-002 ];
Tc_error_6  = [ 1.349756e+001 ; 1.248929e+001 ; 1.344920e+001 ];

