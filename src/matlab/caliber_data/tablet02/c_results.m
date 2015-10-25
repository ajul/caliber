% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 7304.306257184363900 ; 7307.084867170585300 ];

%-- Principal point:
cc = [ 723.947612750067610 ; 113.338052990555770 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.319937102934598 ; 2.578417024693986 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 594.405330253360150 ; 605.979411123149020 ];

%-- Principal point uncertainty:
cc_error = [ 450.509757270359960 ; 512.460436964098110 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.595225599530321 ; 75.148640387901438 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 1.093845e+000 ; 2.417535e+000 ; -3.512740e-001 ];
Tc_1  = [ -3.796794e+000 ; 2.882804e+000 ; 2.128769e+002 ];
omc_error_1 = [ 3.029378e-002 ; 6.494655e-002 ; 8.334169e-002 ];
Tc_error_1  = [ 1.313197e+001 ; 1.492973e+001 ; 1.733208e+001 ];

%-- Image #2:
omc_2 = [ 1.604806e+000 ; 2.071805e+000 ; -1.882084e-001 ];
Tc_2  = [ -6.347083e+000 ; 4.365603e+000 ; 2.115356e+002 ];
omc_error_2 = [ 4.474033e-002 ; 5.787191e-002 ; 7.834196e-002 ];
Tc_error_2  = [ 1.305321e+001 ; 1.483870e+001 ; 1.723803e+001 ];

%-- Image #3:
omc_3 = [ 7.971133e-001 ; 2.679622e+000 ; -5.140186e-001 ];
Tc_3  = [ -3.861133e+000 ; 2.442199e+000 ; 2.121499e+002 ];
omc_error_3 = [ 1.750167e-002 ; 6.898555e-002 ; 9.105866e-002 ];
Tc_error_3  = [ 1.308597e+001 ; 1.487823e+001 ; 1.720612e+001 ];

%-- Image #4:
omc_4 = [ -4.392777e-002 ; 3.102368e+000 ; 2.075914e-002 ];
Tc_4  = [ -2.486583e-001 ; 4.570358e+000 ; 2.091834e+002 ];
omc_error_4 = [ 2.504957e-003 ; 6.829851e-002 ; 1.217280e-001 ];
Tc_error_4  = [ 1.290342e+001 ; 1.466744e+001 ; 1.701097e+001 ];

%-- Image #5:
omc_5 = [ -4.001314e-002 ; 3.050802e+000 ; -6.806235e-001 ];
Tc_5  = [ -2.261619e-001 ; 3.359996e+000 ; 2.119877e+002 ];
omc_error_5 = [ 2.028900e-002 ; 6.685357e-002 ; 1.068853e-001 ];
Tc_error_5  = [ 1.307571e+001 ; 1.486412e+001 ; 1.721233e+001 ];

%-- Image #6:
omc_6 = [ 1.238889e+000 ; 2.613563e+000 ; -5.980383e-001 ];
Tc_6  = [ -8.358719e+000 ; 2.083582e+000 ; 2.054866e+002 ];
omc_error_6 = [ 1.924659e-002 ; 7.250831e-002 ; 9.034796e-002 ];
Tc_error_6  = [ 1.267515e+001 ; 1.441662e+001 ; 1.670273e+001 ];

%-- Image #7:
omc_7 = [ 1.472223e+000 ; 2.401124e+000 ; -2.949312e-001 ];
Tc_7  = [ -9.127676e+000 ; 2.909889e+000 ; 2.041478e+002 ];
omc_error_7 = [ 3.288769e-002 ; 6.303172e-002 ; 8.689759e-002 ];
Tc_error_7  = [ 1.259676e+001 ; 1.432526e+001 ; 1.661445e+001 ];

%-- Image #8:
omc_8 = [ 1.329117e+000 ; 2.066841e+000 ; 7.830997e-002 ];
Tc_8  = [ -9.499623e+000 ; 3.023029e+000 ; 2.047792e+002 ];
omc_error_8 = [ 4.641513e-002 ; 5.385027e-002 ; 7.573937e-002 ];
Tc_error_8  = [ 1.264490e+001 ; 1.437294e+001 ; 1.689844e+001 ];

