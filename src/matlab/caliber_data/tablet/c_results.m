% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 7141.530992954186300 ; 7140.910404925461100 ];

%-- Principal point:
cc = [ 497.249674011112750 ; 419.786338132586880 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.652950408834852 ; -367.105987436682990 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 237.895597962614200 ; 235.083974910562460 ];

%-- Principal point uncertainty:
cc_error = [ 62.720122565861949 ; 70.743477231896520 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 1.544839993952699 ; 1151.349232582031800 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.103659e+000 ; 2.255420e+000 ; -4.658654e-001 ];
Tc_1  = [ -3.836470e+000 ; -3.678473e+000 ; 2.023613e+002 ];
omc_error_1 = [ 6.436991e-003 ; 8.529835e-003 ; 1.516124e-002 ];
Tc_error_1  = [ 1.776648e+000 ; 2.001646e+000 ; 6.654617e+000 ];

%-- Image #2:
omc_2 = [ 1.537649e+000 ; 2.599211e+000 ; -3.364178e-002 ];
Tc_2  = [ -2.237196e+000 ; -5.239021e+000 ; 2.001371e+002 ];
omc_error_2 = [ 6.301293e-003 ; 1.034566e-002 ; 3.171403e-002 ];
Tc_error_2  = [ 1.757309e+000 ; 1.979851e+000 ; 6.591362e+000 ];

%-- Image #3:
omc_3 = [ -2.718700e-001 ; -3.019724e+000 ; 6.214452e-001 ];
Tc_3  = [ 2.881441e+000 ; -6.709430e+000 ; 2.026620e+002 ];
omc_error_3 = [ 3.527446e-003 ; 8.647223e-003 ; 1.442724e-002 ];
Tc_error_3  = [ 1.779247e+000 ; 2.000616e+000 ; 6.689092e+000 ];

%-- Image #4:
omc_4 = [ -1.969818e+000 ; -2.357998e+000 ; 1.108372e-001 ];
Tc_4  = [ -4.801379e+000 ; -3.346848e+000 ; 2.005408e+002 ];
omc_error_4 = [ 1.360713e-002 ; 1.647164e-002 ; 2.841196e-002 ];
Tc_error_4  = [ 1.760868e+000 ; 1.985894e+000 ; 6.594484e+000 ];

%-- Image #5:
omc_5 = [ -1.761477e+000 ; -2.069090e+000 ; 1.108376e+000 ];
Tc_5  = [ -2.623313e+000 ; -3.918077e+000 ; 2.056951e+002 ];
omc_error_5 = [ 8.441432e-003 ; 6.482096e-003 ; 1.382661e-002 ];
Tc_error_5  = [ 1.805905e+000 ; 2.035825e+000 ; 6.680850e+000 ];

%-- Image #6:
omc_6 = [ 1.152334e+000 ; 1.918689e+000 ; 1.351029e-001 ];
Tc_6  = [ 5.863698e-001 ; -6.564082e+000 ; 1.989469e+002 ];
omc_error_6 = [ 7.169605e-003 ; 7.603429e-003 ; 1.065068e-002 ];
Tc_error_6  = [ 1.746866e+000 ; 1.969131e+000 ; 6.526459e+000 ];

%-- Image #7:
omc_7 = [ 1.677101e+000 ; 2.251877e+000 ; -2.999927e-001 ];
Tc_7  = [ -2.411203e+000 ; -5.074904e+000 ; 2.053939e+002 ];
omc_error_7 = [ 4.743345e-003 ; 7.300136e-003 ; 1.429238e-002 ];
Tc_error_7  = [ 1.803298e+000 ; 2.029509e+000 ; 6.782042e+000 ];

%-- Image #8:
omc_8 = [ 1.533226e+000 ; 1.909547e+000 ; 1.335368e-001 ];
Tc_8  = [ -4.030544e+000 ; -5.936321e+000 ; 1.937572e+002 ];
omc_error_8 = [ 7.268290e-003 ; 7.036339e-003 ; 1.199896e-002 ];
Tc_error_8  = [ 1.701562e+000 ; 1.917730e+000 ; 6.369610e+000 ];

