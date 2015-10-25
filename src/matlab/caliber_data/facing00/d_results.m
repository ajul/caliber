% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 678.003732889905110 ; 696.383830629734460 ];

%-- Principal point:
cc = [ 315.744782619480590 ; 245.056792935264010 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.078063621203553 ; -0.250234895369646 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 6.000180077012685 ; 6.168020867425805 ];

%-- Principal point uncertainty:
cc_error = [ 1.454942232305870 ; 2.102314945881513 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.011258254472931 ; 0.047598789942810 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 13;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.194874e+000 ; -2.231247e+000 ; 2.414668e-002 ];
Tc_1  = [ -3.776562e+000 ; -3.631699e-001 ; 1.708605e+001 ];
omc_error_1 = [ 3.944389e-003 ; 4.013324e-003 ; 9.069553e-003 ];
Tc_error_1  = [ 3.654111e-002 ; 5.112434e-002 ; 1.537069e-001 ];

%-- Image #2:
omc_2 = [ -2.090982e+000 ; -2.117504e+000 ; -1.593181e-001 ];
Tc_2  = [ -3.835916e+000 ; 6.033201e-001 ; 1.629541e+001 ];
omc_error_2 = [ 2.819123e-003 ; 3.024002e-003 ; 4.648895e-003 ];
Tc_error_2  = [ 3.494080e-002 ; 4.892049e-002 ; 1.468842e-001 ];

%-- Image #3:
omc_3 = [ 2.118360e+000 ; 2.002770e+000 ; 2.083936e-001 ];
Tc_3  = [ -5.867829e+000 ; 6.829974e-001 ; 1.736835e+001 ];
omc_error_3 = [ 6.186699e-003 ; 6.128213e-003 ; 1.110670e-002 ];
Tc_error_3  = [ 3.923669e-002 ; 5.356792e-002 ; 1.540933e-001 ];

%-- Image #4:
omc_4 = [ 2.046435e+000 ; 1.887527e+000 ; 6.551101e-001 ];
Tc_4  = [ -6.241159e+000 ; 6.844222e-001 ; 1.625308e+001 ];
omc_error_4 = [ 4.227304e-003 ; 3.194696e-003 ; 7.301502e-003 ];
Tc_error_4  = [ 3.618661e-002 ; 4.963157e-002 ; 1.492453e-001 ];

%-- Image #5:
omc_5 = [ -1.965983e+000 ; -2.100953e+000 ; 8.832411e-002 ];
Tc_5  = [ 1.673155e+000 ; -2.630054e+000 ; 1.967312e+001 ];
omc_error_5 = [ 5.267733e-003 ; 6.146494e-003 ; 1.149385e-002 ];
Tc_error_5  = [ 4.455767e-002 ; 5.946002e-002 ; 1.760379e-001 ];

%-- Image #6:
omc_6 = [ -1.851042e+000 ; -2.070872e+000 ; 2.130895e-001 ];
Tc_6  = [ 2.539973e+000 ; -3.011566e+000 ; 2.061777e+001 ];
omc_error_6 = [ 5.080748e-003 ; 5.932761e-003 ; 1.035245e-002 ];
Tc_error_6  = [ 4.644847e-002 ; 6.122487e-002 ; 1.754367e-001 ];

%-- Image #7:
omc_7 = [ -2.070860e+000 ; -2.065955e+000 ; -2.748630e-001 ];
Tc_7  = [ -3.532641e+000 ; -1.440595e+000 ; 1.212989e+001 ];
omc_error_7 = [ 2.375938e-003 ; 2.569172e-003 ; 3.946964e-003 ];
Tc_error_7  = [ 2.619330e-002 ; 3.701968e-002 ; 1.111841e-001 ];

%-- Image #8:
omc_8 = [ -1.855944e+000 ; -2.292632e+000 ; -4.033244e-001 ];
Tc_8  = [ -5.514502e+000 ; -2.204580e+000 ; 1.860924e+001 ];
omc_error_8 = [ 2.868980e-003 ; 3.387492e-003 ; 5.873098e-003 ];
Tc_error_8  = [ 4.093868e-002 ; 5.683679e-002 ; 1.737961e-001 ];

%-- Image #9:
omc_9 = [ -2.276728e+000 ; -1.825760e+000 ; -3.066464e-001 ];
Tc_9  = [ -5.852756e+000 ; -2.165201e+000 ; 1.967239e+001 ];
omc_error_9 = [ 4.100631e-003 ; 3.023806e-003 ; 6.834266e-003 ];
Tc_error_9  = [ 4.299475e-002 ; 5.993918e-002 ; 1.818629e-001 ];

%-- Image #10:
omc_10 = [ -2.102766e+000 ; -1.709582e+000 ; -3.357819e-001 ];
Tc_10  = [ -4.748875e+000 ; -1.944041e+000 ; 1.946552e+001 ];
omc_error_10 = [ 3.031731e-003 ; 2.752887e-003 ; 4.408331e-003 ];
Tc_error_10  = [ 4.208394e-002 ; 5.929160e-002 ; 1.785276e-001 ];

%-- Image #11:
omc_11 = [ -1.906186e+000 ; -2.263903e+000 ; -1.106102e-001 ];
Tc_11  = [ -3.136664e+000 ; -2.253658e+000 ; 1.942510e+001 ];
omc_error_11 = [ 3.488350e-003 ; 3.915192e-003 ; 7.717638e-003 ];
Tc_error_11  = [ 4.167059e-002 ; 5.918635e-002 ; 1.747525e-001 ];

%-- Image #12:
omc_12 = [ -2.114869e+000 ; -2.070144e+000 ; -5.935823e-001 ];
Tc_12  = [ -3.443625e+000 ; -1.162517e+000 ; 9.199422e+000 ];
omc_error_12 = [ 2.227947e-003 ; 3.018912e-003 ; 3.754692e-003 ];
Tc_error_12  = [ 2.017423e-002 ; 2.774126e-002 ; 8.753204e-002 ];

%-- Image #13:
omc_13 = [ -2.000314e+000 ; -2.069029e+000 ; -4.194773e-001 ];
Tc_13  = [ -3.800081e+000 ; -1.667597e+000 ; 1.061450e+001 ];
omc_error_13 = [ 2.180874e-003 ; 2.721060e-003 ; 3.469122e-003 ];
Tc_error_13  = [ 2.310703e-002 ; 3.247452e-002 ; 1.002626e-001 ];

