% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 628.931839519397610 ; 631.305710537434720 ];

%-- Principal point:
cc = [ 344.150874532069050 ; 236.027731776917510 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.158684381036585 ; -0.486477845830914 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 11.549586244083571 ; 11.590511407003818 ];

%-- Principal point uncertainty:
cc_error = [ 3.897265392072454 ; 5.781572756166786 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.022146614979137 ; 0.079474121081600 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -2.150147e+000 ; -2.199084e+000 ; -1.366940e-001 ];
Tc_1  = [ -5.431994e+000 ; 2.025107e+000 ; 1.711111e+001 ];
omc_error_1 = [ 6.045354e-003 ; 6.183819e-003 ; 1.065844e-002 ];
Tc_error_1  = [ 1.063354e-001 ; 1.522242e-001 ; 3.173580e-001 ];

%-- Image #2:
omc_2 = [ -2.058129e+000 ; -2.093051e+000 ; -3.540596e-001 ];
Tc_2  = [ -5.818445e+000 ; -1.976047e+000 ; 1.562012e+001 ];
omc_error_2 = [ 5.831226e-003 ; 6.362593e-003 ; 1.093790e-002 ];
Tc_error_2  = [ 9.906258e-002 ; 1.438292e-001 ; 2.910768e-001 ];

%-- Image #3:
omc_3 = [ -2.105480e+000 ; -2.026412e+000 ; 2.171365e-001 ];
Tc_3  = [ -2.255491e+000 ; 2.337340e+000 ; 1.996725e+001 ];
omc_error_3 = [ 7.325869e-003 ; 6.405534e-003 ; 1.292715e-002 ];
Tc_error_3  = [ 1.220630e-001 ; 1.806888e-001 ; 3.529096e-001 ];

%-- Image #4:
omc_4 = [ -1.888692e+000 ; -1.792003e+000 ; 2.852253e-001 ];
Tc_4  = [ 2.107089e+000 ; -1.064074e+000 ; 2.019760e+001 ];
omc_error_4 = [ 1.095800e-002 ; 8.618968e-003 ; 1.214518e-002 ];
Tc_error_4  = [ 1.271694e-001 ; 1.836181e-001 ; 3.439176e-001 ];

%-- Image #5:
omc_5 = [ -2.113527e+000 ; -2.243680e+000 ; -5.307040e-001 ];
Tc_5  = [ -4.492221e+000 ; 9.506398e-001 ; 1.863720e+001 ];
omc_error_5 = [ 6.909209e-003 ; 9.260293e-003 ; 1.218030e-002 ];
Tc_error_5  = [ 1.206367e-001 ; 1.701580e-001 ; 3.207802e-001 ];

%-- Image #6:
omc_6 = [ 2.006308e+000 ; 2.218976e+000 ; 6.576180e-001 ];
Tc_6  = [ -6.488249e+000 ; 8.990635e-001 ; 1.851692e+001 ];
omc_error_6 = [ 8.317881e-003 ; 7.678814e-003 ; 1.575119e-002 ];
Tc_error_6  = [ 1.258734e-001 ; 1.694820e-001 ; 3.099223e-001 ];

%-- Image #7:
omc_7 = [ -2.015980e+000 ; -2.017976e+000 ; -4.096786e-001 ];
Tc_7  = [ -5.181424e+000 ; 8.736788e-002 ; 1.239880e+001 ];
omc_error_7 = [ 5.571307e-003 ; 7.741114e-003 ; 6.600730e-003 ];
Tc_error_7  = [ 7.818141e-002 ; 1.121088e-001 ; 2.338420e-001 ];

%-- Image #8:
omc_8 = [ -1.744057e+000 ; -2.173751e+000 ; -3.599737e-001 ];
Tc_8  = [ -5.588670e+000 ; -4.502115e+000 ; 1.885884e+001 ];
omc_error_8 = [ 5.914127e-003 ; 7.597496e-003 ; 1.038072e-002 ];
Tc_error_8  = [ 1.174146e-001 ; 1.763158e-001 ; 3.585119e-001 ];

%-- Image #9:
omc_9 = [ -2.201915e+000 ; -1.771259e+000 ; -3.881603e-001 ];
Tc_9  = [ -6.752322e+000 ; 1.205223e-001 ; 2.035835e+001 ];
omc_error_9 = [ 6.918616e-003 ; 7.184362e-003 ; 8.679095e-003 ];
Tc_error_9  = [ 1.290240e-001 ; 1.843530e-001 ; 3.758254e-001 ];

%-- Image #10:
omc_10 = [ -2.129532e+000 ; -1.725964e+000 ; -6.634670e-001 ];
Tc_10  = [ -8.359963e+000 ; -2.974433e+000 ; 1.795402e+001 ];
omc_error_10 = [ 9.633945e-003 ; 9.385846e-003 ; 9.554815e-003 ];
Tc_error_10  = [ 1.209527e-001 ; 1.617266e-001 ; 3.248265e-001 ];

%-- Image #11:
omc_11 = [ -1.913989e+000 ; -2.277726e+000 ; -4.057758e-001 ];
Tc_11  = [ -6.322650e+000 ; -1.469614e+000 ; 1.870810e+001 ];
omc_error_11 = [ 5.905556e-003 ; 7.309492e-003 ; 1.211756e-002 ];
Tc_error_11  = [ 1.196031e-001 ; 1.714974e-001 ; 3.444464e-001 ];

%-- Image #12:
omc_12 = [ -1.890088e+000 ; -1.873786e+000 ; -2.755889e-001 ];
Tc_12  = [ -2.935111e+000 ; -3.036555e-001 ; 1.116510e+001 ];
omc_error_12 = [ 5.981321e-003 ; 6.971553e-003 ; 5.258524e-003 ];
Tc_error_12  = [ 6.818002e-002 ; 1.019931e-001 ; 2.080636e-001 ];

%-- Image #13:
omc_13 = [ -1.906753e+000 ; -1.984897e+000 ; -4.419568e-001 ];
Tc_13  = [ -4.930083e+000 ; -6.242691e-001 ; 1.131079e+001 ];
omc_error_13 = [ 5.449237e-003 ; 8.100639e-003 ; 6.152319e-003 ];
Tc_error_13  = [ 7.099685e-002 ; 1.030499e-001 ; 2.157724e-001 ];

