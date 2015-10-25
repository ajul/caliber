% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2465.179991803489000 ; 2507.025131538115600 ];

%-- Principal point:
cc = [ 472.547033363182380 ; 534.168091639922980 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.204027672413085 ; -0.103117518285814 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 49.824776510928181 ; 34.307248084328407 ];

%-- Principal point uncertainty:
cc_error = [ 66.483852987950982 ; 35.905420251441463 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.028250030613272 ; 0.149375740128867 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -1.851325e+000 ; -2.025025e+000 ; 8.030899e-001 ];
Tc_1  = [ -5.503238e+001 ; -9.871634e+001 ; 1.789791e+003 ];
omc_error_1 = [ 1.652742e-002 ; 1.412032e-002 ; 2.576475e-002 ];
Tc_error_1  = [ 4.795475e+001 ; 2.555946e+001 ; 2.605007e+001 ];

%-- Image #2:
omc_2 = [ -1.749974e+000 ; -1.943559e+000 ; 8.974536e-001 ];
Tc_2  = [ 1.963218e+002 ; -1.020639e+002 ; 1.802811e+003 ];
omc_error_2 = [ 1.668956e-002 ; 1.381073e-002 ; 2.383594e-002 ];
Tc_error_2  = [ 5.003504e+001 ; 2.580843e+001 ; 2.516988e+001 ];

%-- Image #3:
omc_3 = [ -1.754912e+000 ; -1.857283e+000 ; 7.354107e-001 ];
Tc_3  = [ 1.652906e+002 ; -3.288265e+002 ; 1.762107e+003 ];
omc_error_3 = [ 1.481770e-002 ; 1.257472e-002 ; 2.464810e-002 ];
Tc_error_3  = [ 4.912800e+001 ; 2.523672e+001 ; 2.643548e+001 ];

%-- Image #4:
omc_4 = [ -1.878415e+000 ; -1.777702e+000 ; 8.757895e-001 ];
Tc_4  = [ 1.729297e+002 ; -4.994360e+001 ; 1.813025e+003 ];
omc_error_4 = [ 1.622007e-002 ; 1.294348e-002 ; 2.472418e-002 ];
Tc_error_4  = [ 5.019667e+001 ; 2.599568e+001 ; 2.461517e+001 ];

%-- Image #5:
omc_5 = [ -1.680454e+000 ; -1.647800e+000 ; 9.962518e-001 ];
Tc_5  = [ 2.705801e+002 ; -7.720608e+001 ; 2.130460e+003 ];
omc_error_5 = [ 1.809004e-002 ; 1.427262e-002 ; 2.204544e-002 ];
Tc_error_5  = [ 5.958513e+001 ; 3.060032e+001 ; 2.828856e+001 ];

%-- Image #6:
omc_6 = [ -1.471498e+000 ; -1.861366e+000 ; 9.360794e-001 ];
Tc_6  = [ 3.035176e+002 ; -3.607862e+002 ; 2.076873e+003 ];
omc_error_6 = [ 1.770469e-002 ; 1.448023e-002 ; 2.154964e-002 ];
Tc_error_6  = [ 5.872215e+001 ; 2.978158e+001 ; 3.069542e+001 ];

%-- Image #7:
omc_7 = [ -1.414191e+000 ; -1.816225e+000 ; 9.819234e-001 ];
Tc_7  = [ 4.674455e+002 ; -3.557480e+002 ; 2.063325e+003 ];
omc_error_7 = [ 1.777876e-002 ; 1.430651e-002 ; 2.022014e-002 ];
Tc_error_7  = [ 5.992278e+001 ; 2.973886e+001 ; 3.096410e+001 ];

%-- Image #8:
omc_8 = [ -1.603821e+000 ; -1.653610e+000 ; 1.100541e+000 ];
Tc_8  = [ 4.396522e+002 ; -1.977153e+000 ; 2.121036e+003 ];
omc_error_8 = [ 1.887635e-002 ; 1.417793e-002 ; 2.043462e-002 ];
Tc_error_8  = [ 6.082522e+001 ; 3.064063e+001 ; 2.781753e+001 ];

%-- Image #9:
omc_9 = [ -1.613447e+000 ; -1.571207e+000 ; 8.224821e-001 ];
Tc_9  = [ 3.581742e+002 ; -2.513910e+002 ; 2.112924e+003 ];
omc_error_9 = [ 1.590324e-002 ; 1.484319e-002 ; 2.216918e-002 ];
Tc_error_9  = [ 6.012354e+001 ; 3.049285e+001 ; 2.908125e+001 ];

%-- Image #10:
omc_10 = [ -1.764963e+000 ; -1.663661e+000 ; 7.231555e-001 ];
Tc_10  = [ -3.535798e+001 ; -1.614397e+002 ; 2.120390e+003 ];
omc_error_10 = [ 1.576736e-002 ; 1.482625e-002 ; 2.465545e-002 ];
Tc_error_10  = [ 5.699331e+001 ; 3.037622e+001 ; 3.000696e+001 ];

%-- Image #11:
omc_11 = [ -1.733413e+000 ; -1.764641e+000 ; 1.018535e+000 ];
Tc_11  = [ 8.192489e+001 ; -2.382181e+001 ; 2.166228e+003 ];
omc_error_11 = [ 1.890280e-002 ; 1.445158e-002 ; 2.288815e-002 ];
Tc_error_11  = [ 5.898291e+001 ; 3.101708e+001 ; 2.941583e+001 ];

%-- Image #12:
omc_12 = [ -1.518009e+000 ; -1.927921e+000 ; 9.755882e-001 ];
Tc_12  = [ 1.982694e+002 ; -3.030170e+002 ; 2.128034e+003 ];
omc_error_12 = [ 1.867856e-002 ; 1.465956e-002 ; 2.228083e-002 ];
Tc_error_12  = [ 5.900513e+001 ; 3.037942e+001 ; 3.102972e+001 ];

