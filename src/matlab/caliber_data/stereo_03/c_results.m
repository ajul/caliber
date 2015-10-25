% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 7072.355422519616700 ; 7067.144298576061400 ];

%-- Principal point:
cc = [ 696.282864541847970 ; 483.001135302832040 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.044881142418254 ; -13.302398103057353 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 82.678436456337394 ; 78.356600971848039 ];

%-- Principal point uncertainty:
cc_error = [ 48.384882621579045 ; 40.534938884015503 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.169369871223260 ; 28.152864584742009 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 1.976705e+000 ; 2.118034e+000 ; 2.482272e-001 ];
Tc_1  = [ -3.137847e+000 ; -2.859748e+000 ; 1.136484e+002 ];
omc_error_1 = [ 5.899421e-003 ; 5.442393e-003 ; 9.640691e-003 ];
Tc_error_1  = [ 7.787840e-001 ; 6.517153e-001 ; 1.261229e+000 ];

%-- Image #2:
omc_2 = [ -1.951053e+000 ; -2.129538e+000 ; 4.385870e-001 ];
Tc_2  = [ -4.446612e+000 ; -2.936283e+000 ; 1.157590e+002 ];
omc_error_2 = [ 6.303425e-003 ; 5.829126e-003 ; 9.987928e-003 ];
Tc_error_2  = [ 7.932617e-001 ; 6.638028e-001 ; 1.269988e+000 ];

%-- Image #3:
omc_3 = [ 1.658776e+000 ; 1.758503e+000 ; 7.590338e-001 ];
Tc_3  = [ -1.097589e+000 ; -2.704857e+000 ; 1.127708e+002 ];
omc_error_3 = [ 6.049280e-003 ; 4.582481e-003 ; 7.044069e-003 ];
Tc_error_3  = [ 7.719710e-001 ; 6.466759e-001 ; 1.273716e+000 ];

%-- Image #4:
omc_4 = [ 1.854148e+000 ; 1.880778e+000 ; 7.329114e-002 ];
Tc_4  = [ -3.147138e+000 ; -3.124011e+000 ; 1.143231e+002 ];
omc_error_4 = [ 4.754851e-003 ; 4.994048e-003 ; 8.197475e-003 ];
Tc_error_4  = [ 7.828672e-001 ; 6.551927e-001 ; 1.284350e+000 ];

%-- Image #5:
omc_5 = [ 1.960344e+000 ; 2.133248e+000 ; 4.142376e-001 ];
Tc_5  = [ -2.862309e+000 ; -2.189136e+000 ; 1.132189e+002 ];
omc_error_5 = [ 6.121376e-003 ; 5.213576e-003 ; 8.536088e-003 ];
Tc_error_5  = [ 7.757157e-001 ; 6.492780e-001 ; 1.266561e+000 ];

%-- Image #6:
omc_6 = [ 1.007131e+000 ; 2.564494e+000 ; 1.659789e-001 ];
Tc_6  = [ -4.484191e-002 ; -3.688263e+000 ; 1.145855e+002 ];
omc_error_6 = [ 3.512178e-003 ; 6.814886e-003 ; 7.832455e-003 ];
Tc_error_6  = [ 7.838302e-001 ; 6.570892e-001 ; 1.273214e+000 ];

%-- Image #7:
omc_7 = [ 1.105966e+000 ; 2.255354e+000 ; -6.603798e-003 ];
Tc_7  = [ -6.187345e-001 ; -4.339255e+000 ; 1.155182e+002 ];
omc_error_7 = [ 3.622873e-003 ; 6.215433e-003 ; 7.136367e-003 ];
Tc_error_7  = [ 7.904580e-001 ; 6.621235e-001 ; 1.282446e+000 ];

%-- Image #8:
omc_8 = [ 2.213772e+000 ; 1.889970e+000 ; 4.931598e-002 ];
Tc_8  = [ -2.464714e-001 ; -3.617133e+000 ; 1.153417e+002 ];
omc_error_8 = [ 4.899665e-003 ; 4.264729e-003 ; 1.171905e-002 ];
Tc_error_8  = [ 7.892363e-001 ; 6.608121e-001 ; 1.290331e+000 ];

%-- Image #9:
omc_9 = [ -2.274844e+000 ; -1.821825e+000 ; 4.226636e-001 ];
Tc_9  = [ -1.436116e+000 ; -3.024016e+000 ; 1.170606e+002 ];
omc_error_9 = [ 7.208593e-003 ; 5.026884e-003 ; 1.213966e-002 ];
Tc_error_9  = [ 8.016601e-001 ; 6.712014e-001 ; 1.280970e+000 ];

%-- Image #10:
omc_10 = [ 2.207475e+000 ; 1.856502e+000 ; -6.127086e-001 ];
Tc_10  = [ -1.052636e+000 ; -3.958496e+000 ; 1.175876e+002 ];
omc_error_10 = [ 4.548653e-003 ; 6.022926e-003 ; 9.124841e-003 ];
Tc_error_10  = [ 8.047001e-001 ; 6.733076e-001 ; 1.331322e+000 ];

%-- Image #11:
omc_11 = [ -1.632079e+000 ; -2.262200e+000 ; -3.247818e-001 ];
Tc_11  = [ -7.082161e+000 ; -2.649095e+000 ; 1.137543e+002 ];
omc_error_11 = [ 3.376237e-003 ; 5.740723e-003 ; 1.144463e-002 ];
Tc_error_11  = [ 7.790047e-001 ; 6.521805e-001 ; 1.329164e+000 ];

%-- Image #12:
omc_12 = [ 1.226210e+000 ; 2.592117e+000 ; 6.285883e-001 ];
Tc_12  = [ -1.857161e+000 ; -3.420679e+000 ; 1.125445e+002 ];
omc_error_12 = [ 4.686478e-003 ; 5.741387e-003 ; 9.231142e-003 ];
Tc_error_12  = [ 7.704658e-001 ; 6.449156e-001 ; 1.296726e+000 ];

