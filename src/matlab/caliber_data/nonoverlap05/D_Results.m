% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 4498.338292424490600 ; 4498.543746115609800 ];

%-- Principal point:
cc = [ 2360.182568552833300 ; 1570.997465307097400 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.113613879998468 ; 0.123037543204521 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 53.162863012403243 ; 51.878833054285501 ];

%-- Principal point uncertainty:
cc_error = [ 17.184514870900291 ; 23.400837458192299 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.004060449071024 ; 0.021324786480258 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 4752;
ny = 3168;


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
omc_1 = [ 2.229230e+000 ; 2.155657e+000 ; -3.991397e-001 ];
Tc_1  = [ -1.807217e+002 ; -2.104879e+001 ; 1.085968e+003 ];
omc_error_1 = [ 8.430046e-004 ; 1.711528e-003 ; 7.643552e-003 ];
Tc_error_1  = [ 4.112028e+000 ; 5.658255e+000 ; 1.296332e+001 ];

%-- Image #2:
omc_2 = [ 2.129101e+000 ; 2.168915e+000 ; -4.606279e-001 ];
Tc_2  = [ -1.716309e+002 ; 4.215256e+001 ; 1.095669e+003 ];
omc_error_2 = [ 9.074632e-004 ; 1.744024e-003 ; 7.238143e-003 ];
Tc_error_2  = [ 4.162355e+000 ; 5.735239e+000 ; 1.299594e+001 ];

%-- Image #3:
omc_3 = [ -2.117314e+000 ; -2.178741e+000 ; 6.299195e-001 ];
Tc_3  = [ 1.822968e+001 ; 4.676461e+001 ; 1.124554e+003 ];
omc_error_3 = [ 2.189618e-003 ; 1.478464e-003 ; 6.989207e-003 ];
Tc_error_3  = [ 4.296069e+000 ; 5.860411e+000 ; 1.298228e+001 ];

%-- Image #4:
omc_4 = [ 2.090711e+000 ; 2.113996e+000 ; -3.247448e-001 ];
Tc_4  = [ -3.129159e+002 ; 3.712610e+001 ; 1.053821e+003 ];
omc_error_4 = [ 1.204206e-003 ; 1.549900e-003 ; 7.161417e-003 ];
Tc_error_4  = [ 4.011657e+000 ; 5.555066e+000 ; 1.290744e+001 ];

%-- Image #5:
omc_5 = [ -2.046432e+000 ; -2.331762e+000 ; 4.216017e-001 ];
Tc_5  = [ -9.181186e+001 ; -8.720108e+001 ; 1.089742e+003 ];
omc_error_5 = [ 1.585074e-003 ; 1.453202e-003 ; 7.535126e-003 ];
Tc_error_5  = [ 4.146695e+000 ; 5.638146e+000 ; 1.292755e+001 ];

%-- Image #6:
omc_6 = [ 2.040517e+000 ; 2.223274e+000 ; -5.464458e-001 ];
Tc_6  = [ -1.109410e+002 ; 7.710273e+001 ; 1.110203e+003 ];
omc_error_6 = [ 9.180602e-004 ; 1.934835e-003 ; 7.008458e-003 ];
Tc_error_6  = [ 4.230254e+000 ; 5.818128e+000 ; 1.299726e+001 ];

