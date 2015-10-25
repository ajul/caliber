% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2800.169915328114300 ; 2798.697964737690700 ];

%-- Principal point:
cc = [ 838.752632907541400 ; 657.746287571271410 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.127148861361711 ; 5.757038321127968 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 1061.370702222906200 ; 1053.830097597802700 ];

%-- Principal point uncertainty:
cc_error = [ 175.118584936048880 ; 170.604323764567990 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 1.015691165616250 ; 21.287745391696014 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.220197e+000 ; 2.247886e+000 ; -3.667936e-002 ];
Tc_1  = [ -3.539837e+000 ; -1.285256e+001 ; 1.566197e+002 ];
omc_error_1 = [ 5.821056e-002 ; 6.381355e-002 ; 6.893247e-002 ];
Tc_error_1  = [ 9.775198e+000 ; 9.549775e+000 ; 5.935017e+001 ];

%-- Image #2:
omc_2 = [ 1.908565e+000 ; 2.470884e+000 ; -1.558209e-002 ];
Tc_2  = [ -1.847971e+000 ; -1.335221e+001 ; 1.563160e+002 ];
omc_error_2 = [ 4.859204e-002 ; 6.281061e-002 ; 1.291841e-001 ];
Tc_error_2  = [ 9.765297e+000 ; 9.556665e+000 ; 5.929722e+001 ];

%-- Image #3:
omc_3 = [ -2.954664e+000 ; -8.502427e-001 ; 1.708942e-001 ];
Tc_3  = [ -1.634339e+001 ; -2.975209e+000 ; 1.583401e+002 ];
omc_error_3 = [ 2.030318e-002 ; 7.011566e-003 ; 1.165194e-001 ];
Tc_error_3  = [ 9.882773e+000 ; 9.640422e+000 ; 5.973316e+001 ];

%-- Image #4:
omc_4 = [ -1.140292e+000 ; -2.880078e+000 ; 6.507514e-003 ];
Tc_4  = [ -4.689724e+000 ; -6.854318e+000 ; 1.486566e+002 ];
omc_error_4 = [ 2.660079e-002 ; 6.314442e-002 ; 7.601456e-002 ];
Tc_error_4  = [ 9.287789e+000 ; 9.064881e+000 ; 5.610660e+001 ];

%-- Image #5:
omc_5 = [ 1.515062e+000 ; 2.640320e+000 ; 1.682452e-001 ];
Tc_5  = [ -8.563036e+000 ; -8.607231e+000 ; 1.483192e+002 ];
omc_error_5 = [ 4.164236e-002 ; 7.653239e-002 ; 1.774679e-001 ];
Tc_error_5  = [ 9.251006e+000 ; 9.039430e+000 ; 5.606747e+001 ];

%-- Image #6:
omc_6 = [ -2.417193e+000 ; -1.905292e+000 ; 8.385413e-002 ];
Tc_6  = [ -1.748843e+001 ; -6.740017e+000 ; 1.505451e+002 ];
omc_error_6 = [ 2.681865e-002 ; 2.368297e-002 ; 1.132033e-001 ];
Tc_error_6  = [ 9.382686e+000 ; 9.162945e+000 ; 5.685791e+001 ];

%-- Image #7:
omc_7 = [ -1.789244e+000 ; -2.463900e+000 ; 5.321966e-002 ];
Tc_7  = [ -5.750233e+000 ; -7.210512e+000 ; 1.376260e+002 ];
omc_error_7 = [ 2.598246e-002 ; 3.488470e-002 ; 8.978675e-002 ];
Tc_error_7  = [ 8.595150e+000 ; 8.393803e+000 ; 5.196667e+001 ];

%-- Image #8:
omc_8 = [ -1.719190e+000 ; -2.375705e+000 ; -1.496714e-001 ];
Tc_8  = [ -5.807439e+000 ; -7.245910e+000 ; 1.358367e+002 ];
omc_error_8 = [ 1.896646e-002 ; 3.628324e-002 ; 1.045966e-001 ];
Tc_error_8  = [ 8.498898e+000 ; 8.303543e+000 ; 5.164190e+001 ];

