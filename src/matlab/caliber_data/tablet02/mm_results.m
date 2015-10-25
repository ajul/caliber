% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3401.755240187446800 ; 3375.470947183981500 ];

%-- Principal point:
cc = [ 729.294164010410100 ; 311.605171086221730 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.570540778921706 ; 65.836933211385684 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 387.878881750755740 ; 383.705532488471820 ];

%-- Principal point uncertainty:
cc_error = [ 29.398514111122498 ; 111.008777699664550 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.544481392280044 ; 66.323622110500040 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 16;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.088183e+000 ; 2.485100e+000 ; -3.719671e-001 ];
Tc_1  = [ 5.713681e-001 ; 2.398180e+000 ; 1.991955e+002 ];
omc_error_1 = [ 1.382383e-002 ; 1.786966e-002 ; 4.256977e-002 ];
Tc_error_1  = [ 1.721803e+000 ; 6.550252e+000 ; 2.252460e+001 ];

%-- Image #2:
omc_2 = [ 1.610596e+000 ; 2.131466e+000 ; -2.242186e-001 ];
Tc_2  = [ -2.092766e+000 ; 3.863677e+000 ; 1.977170e+002 ];
omc_error_2 = [ 1.953329e-002 ; 1.750367e-002 ; 3.848204e-002 ];
Tc_error_2  = [ 1.709634e+000 ; 6.502192e+000 ; 2.249259e+001 ];

%-- Image #3:
omc_3 = [ 7.834851e-001 ; 2.755047e+000 ; -5.225903e-001 ];
Tc_3  = [ 4.709310e-001 ; 1.966874e+000 ; 1.991007e+002 ];
omc_error_3 = [ 8.009533e-003 ; 1.912983e-002 ; 4.810350e-002 ];
Tc_error_3  = [ 1.720684e+000 ; 6.547510e+000 ; 2.251269e+001 ];

%-- Image #4:
omc_4 = [ 5.369106e-002 ; -2.999715e+000 ; 5.511098e-002 ];
Tc_4  = [ 3.804464e+000 ; 4.104450e+000 ; 1.943047e+002 ];
omc_error_4 = [ 5.295897e-003 ; 5.484267e-002 ; 6.431184e-002 ];
Tc_error_4  = [ 1.678718e+000 ; 6.387560e+000 ; 2.220627e+001 ];

%-- Image #5:
omc_5 = [ 7.628042e-002 ; -3.016375e+000 ; 6.392368e-001 ];
Tc_5  = [ 4.065957e+000 ; 2.921267e+000 ; 1.987091e+002 ];
omc_error_5 = [ 3.649914e-003 ; 1.541046e-002 ; 5.317197e-002 ];
Tc_error_5  = [ 1.717658e+000 ; 6.536337e+000 ; 2.255983e+001 ];

%-- Image #6:
omc_6 = [ 1.235503e+000 ; 2.690417e+000 ; -6.340510e-001 ];
Tc_6  = [ -4.487524e+000 ; 1.578852e+000 ; 1.931612e+002 ];
omc_error_6 = [ 8.982239e-003 ; 2.520501e-002 ; 4.668621e-002 ];
Tc_error_6  = [ 1.669527e+000 ; 6.353551e+000 ; 2.184779e+001 ];

%-- Image #7:
omc_7 = [ 1.480481e+000 ; 2.471400e+000 ; -3.155232e-001 ];
Tc_7  = [ -5.350204e+000 ; 2.405346e+000 ; 1.918172e+002 ];
omc_error_7 = [ 1.348937e-002 ; 2.092588e-002 ; 5.126084e-002 ];
Tc_error_7  = [ 1.658496e+000 ; 6.310960e+000 ; 2.176350e+001 ];

%-- Image #8:
omc_8 = [ 1.337572e+000 ; 2.129346e+000 ; 4.451430e-002 ];
Tc_8  = [ -5.649675e+000 ; 2.502951e+000 ; 1.913779e+002 ];
omc_error_8 = [ 1.935455e-002 ; 1.232494e-002 ; 3.619380e-002 ];
Tc_error_8  = [ 1.656973e+000 ; 6.296107e+000 ; 2.174181e+001 ];

%-- Image #9:
omc_9 = [ -2.447920e+000 ; -1.815466e+000 ; 7.351858e-002 ];
Tc_9  = [ -8.620479e+000 ; 9.935116e+000 ; 1.454740e+002 ];
omc_error_9 = [ 4.191038e-002 ; 2.833520e-002 ; 6.000539e-002 ];
Tc_error_9  = [ 1.253055e+000 ; 4.801396e+000 ; 1.665991e+001 ];

%-- Image #10:
omc_10 = [ -2.066003e+000 ; -2.281526e+000 ; 1.813237e-001 ];
Tc_10  = [ -3.996289e+000 ; 8.544897e+000 ; 1.458718e+002 ];
omc_error_10 = [ 3.152900e-002 ; 3.475086e-002 ; 8.287021e-002 ];
Tc_error_10  = [ 1.263610e+000 ; 4.816237e+000 ; 1.662292e+001 ];

%-- Image #11:
omc_11 = [ 1.571465e+000 ; 2.641904e+000 ; 6.151139e-002 ];
Tc_11  = [ 4.271574e-001 ; 8.964342e+000 ; 1.460688e+002 ];
omc_error_11 = [ 3.302079e-002 ; 4.896624e-002 ; 6.428991e-002 ];
Tc_error_11  = [ 1.264800e+000 ; 4.816892e+000 ; 1.676892e+001 ];

%-- Image #12:
omc_12 = [ -2.853237e+000 ; -1.171753e+000 ; -1.756826e-001 ];
Tc_12  = [ -4.621763e+000 ; 1.231245e+001 ; 1.447624e+002 ];
omc_error_12 = [ 4.198472e-002 ; 1.925884e-002 ; 2.748636e-002 ];
Tc_error_12  = [ 1.256867e+000 ; 4.766458e+000 ; 1.669979e+001 ];

%-- Image #13:
omc_13 = [ -2.186237e+000 ; -1.673565e+000 ; -2.012283e-001 ];
Tc_13  = [ -9.943126e-001 ; 8.731717e+000 ; 1.342236e+002 ];
omc_error_13 = [ 2.347220e-002 ; 1.504780e-002 ; 3.240584e-002 ];
Tc_error_13  = [ 1.161855e+000 ; 4.413009e+000 ; 1.543171e+001 ];

%-- Image #14:
omc_14 = [ 1.791335e+000 ; 2.291721e+000 ; 8.203016e-002 ];
Tc_14  = [ 5.966398e-001 ; 7.643377e+000 ; 1.395112e+002 ];
omc_error_14 = [ 2.436149e-002 ; 2.380503e-002 ; 5.843473e-002 ];
Tc_error_14  = [ 1.208341e+000 ; 4.604705e+000 ; 1.591741e+001 ];

%-- Image #15:
omc_15 = [ -1.978497e+000 ; -2.421665e+000 ; -2.031966e-001 ];
Tc_15  = [ 5.901893e-002 ; 6.914400e+000 ; 1.332863e+002 ];
omc_error_15 = [ 2.237685e-002 ; 3.049059e-002 ; 5.031594e-002 ];
Tc_error_15  = [ 1.154332e+000 ; 4.391857e+000 ; 1.533108e+001 ];

%-- Image #16:
omc_16 = [ 1.839283e+000 ; 2.334394e+000 ; 4.104670e-001 ];
Tc_16  = [ 3.676145e-001 ; 5.651137e+000 ; 1.323888e+002 ];
omc_error_16 = [ 1.951191e-002 ; 1.662635e-002 ; 4.542727e-002 ];
Tc_error_16  = [ 1.145561e+000 ; 4.363825e+000 ; 1.523899e+001 ];

