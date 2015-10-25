% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3508.920545573162600 ; 3506.356316385560100 ];

%-- Principal point:
cc = [ 728.771893824804010 ; 460.348272694156040 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.457459632184321 ; 2.823059933331996 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 33.236537819948950 ; 32.127474039270702 ];

%-- Principal point uncertainty:
cc_error = [ 36.273185368471317 ; 35.218835024033368 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.091460537180099 ; 7.915616442868444 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 1.997052e+000 ; 2.169376e+000 ; 1.750289e-001 ];
Tc_1  = [ -6.049710e+000 ; -1.881191e+000 ; 1.146880e+002 ];
omc_error_1 = [ 7.539377e-003 ; 7.257994e-003 ; 1.635008e-002 ];
Tc_error_1  = [ 1.186271e+000 ; 1.153235e+000 ; 1.057111e+000 ];

%-- Image #2:
omc_2 = [ -1.901677e+000 ; -2.100731e+000 ; 5.113620e-001 ];
Tc_2  = [ -7.210179e+000 ; -1.952627e+000 ; 1.168714e+002 ];
omc_error_2 = [ 9.539828e-003 ; 7.268726e-003 ; 1.449358e-002 ];
Tc_error_2  = [ 1.209008e+000 ; 1.175874e+000 ; 1.064191e+000 ];

%-- Image #3:
omc_3 = [ 1.689336e+000 ; 1.818242e+000 ; 7.053415e-001 ];
Tc_3  = [ -4.077687e+000 ; -1.709476e+000 ; 1.136303e+002 ];
omc_error_3 = [ 9.448968e-003 ; 6.965133e-003 ; 1.240142e-002 ];
Tc_error_3  = [ 1.174789e+000 ; 1.141956e+000 ; 1.062909e+000 ];

%-- Image #4:
omc_4 = [ 1.863546e+000 ; 1.936098e+000 ; 5.221162e-003 ];
Tc_4  = [ -6.010956e+000 ; -2.133888e+000 ; 1.153707e+002 ];
omc_error_4 = [ 7.223790e-003 ; 7.722510e-003 ; 1.407831e-002 ];
Tc_error_4  = [ 1.193121e+000 ; 1.160102e+000 ; 1.072764e+000 ];

%-- Image #5:
omc_5 = [ 1.986837e+000 ; 2.185164e+000 ; 3.433588e-001 ];
Tc_5  = [ -5.811594e+000 ; -1.208480e+000 ; 1.142198e+002 ];
omc_error_5 = [ 8.404926e-003 ; 7.123492e-003 ; 1.473720e-002 ];
Tc_error_5  = [ 1.180977e+000 ; 1.148456e+000 ; 1.061869e+000 ];

%-- Image #6:
omc_6 = [ 1.012496e+000 ; 2.632234e+000 ; 1.264745e-001 ];
Tc_6  = [ -2.887758e+000 ; -2.663535e+000 ; 1.153967e+002 ];
omc_error_6 = [ 4.735878e-003 ; 9.737954e-003 ; 1.386479e-002 ];
Tc_error_6  = [ 1.192899e+000 ; 1.159559e+000 ; 1.060288e+000 ];

%-- Image #7:
omc_7 = [ 1.104225e+000 ; 2.321529e+000 ; -5.027971e-002 ];
Tc_7  = [ -3.389764e+000 ; -3.311003e+000 ; 1.164074e+002 ];
omc_error_7 = [ 5.300288e-003 ; 9.498827e-003 ; 1.305682e-002 ];
Tc_error_7  = [ 1.203529e+000 ; 1.169814e+000 ; 1.067194e+000 ];

%-- Image #8:
omc_8 = [ 2.227704e+000 ; 1.935480e+000 ; -3.166119e-002 ];
Tc_8  = [ -3.041346e+000 ; -2.589444e+000 ; 1.162046e+002 ];
omc_error_8 = [ 8.387937e-003 ; 7.439683e-003 ; 1.921183e-002 ];
Tc_error_8  = [ 1.201425e+000 ; 1.167815e+000 ; 1.080162e+000 ];

%-- Image #9:
omc_9 = [ -2.227307e+000 ; -1.803147e+000 ; 5.066534e-001 ];
Tc_9  = [ -4.115327e+000 ; -1.994013e+000 ; 1.179512e+002 ];
omc_error_9 = [ 1.021281e-002 ; 5.700378e-003 ; 1.406347e-002 ];
Tc_error_9  = [ 1.219401e+000 ; 1.185182e+000 ; 1.069241e+000 ];

%-- Image #10:
omc_10 = [ 2.195080e+000 ; 1.893792e+000 ; -7.042461e-001 ];
Tc_10  = [ -3.692948e+000 ; -2.916257e+000 ; 1.184522e+002 ];
omc_error_10 = [ 6.816310e-003 ; 9.858384e-003 ; 1.470001e-002 ];
Tc_error_10  = [ 1.224925e+000 ; 1.190852e+000 ; 1.092665e+000 ];

%-- Image #11:
omc_11 = [ -1.609850e+000 ; -2.223331e+000 ; -2.536884e-001 ];
Tc_11  = [ -9.988411e+000 ; -1.706897e+000 ; 1.149597e+002 ];
omc_error_11 = [ 6.640949e-003 ; 9.694970e-003 ; 1.411085e-002 ];
Tc_error_11  = [ 1.189061e+000 ; 1.158214e+000 ; 1.095740e+000 ];

%-- Image #12:
omc_12 = [ 1.253675e+000 ; 2.657421e+000 ; 5.873597e-001 ];
Tc_12  = [ -4.844030e+000 ; -2.433701e+000 ; 1.134307e+002 ];
omc_error_12 = [ 7.170929e-003 ; 8.481198e-003 ; 1.402801e-002 ];
Tc_error_12  = [ 1.172292e+000 ; 1.140968e+000 ; 1.079221e+000 ];

