% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 7323.776101512819000 ; 7328.181388569851200 ];

%-- Principal point:
cc = [ 396.941734091106580 ; 518.063447974513000 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.422815443217044 ; -68.825258716768971 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 3073.670228026350700 ; 3079.054918744225700 ];

%-- Principal point uncertainty:
cc_error = [ 386.348703509014850 ; 171.752388952611510 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.946356976309445 ; 159.299847871101120 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.223778e+000 ; 2.223583e+000 ; -2.879831e-002 ];
Tc_1  = [ 1.084077e+001 ; -4.474067e+000 ; 2.035638e+002 ];
omc_error_1 = [ 4.247520e-002 ; 4.337071e-002 ; 1.117299e-001 ];
Tc_error_1  = [ 1.075506e+001 ; 4.766923e+000 ; 8.567613e+001 ];

%-- Image #2:
omc_2 = [ -1.849033e+000 ; -2.364638e+000 ; 8.493872e-002 ];
Tc_2  = [ 1.255187e+001 ; -5.014146e+000 ; 2.038963e+002 ];
omc_error_2 = [ 2.647684e-002 ; 3.552797e-002 ; 6.034198e-002 ];
Tc_error_2  = [ 1.077073e+001 ; 4.775374e+000 ; 8.585093e+001 ];

%-- Image #3:
omc_3 = [ -2.993389e+000 ; -8.346105e-001 ; 1.507131e-001 ];
Tc_3  = [ -1.831149e+000 ; 5.630946e+000 ; 2.049812e+002 ];
omc_error_3 = [ 3.054622e-002 ; 7.294716e-003 ; 7.756879e-002 ];
Tc_error_3  = [ 1.080648e+001 ; 4.807625e+000 ; 8.608213e+001 ];

%-- Image #4:
omc_4 = [ -1.172424e+000 ; -2.902106e+000 ; 3.012868e-002 ];
Tc_4  = [ 9.722801e+000 ; 1.117776e+000 ; 1.937452e+002 ];
omc_error_4 = [ 2.992619e-002 ; 7.854081e-002 ; 1.054219e-001 ];
Tc_error_4  = [ 1.022712e+001 ; 4.537999e+000 ; 8.148060e+001 ];

%-- Image #5:
omc_5 = [ -1.574511e+000 ; -2.710534e+000 ; 5.974409e-004 ];
Tc_5  = [ 5.802615e+000 ; -6.031593e-001 ; 1.935444e+002 ];
omc_error_5 = [ 3.594227e-002 ; 6.479522e-002 ; 9.298460e-002 ];
Tc_error_5  = [ 1.021592e+001 ; 4.534469e+000 ; 8.139736e+001 ];

%-- Image #6:
omc_6 = [ -2.441734e+000 ; -1.895660e+000 ; 1.986970e-002 ];
Tc_6  = [ -3.047212e+000 ; 1.457651e+000 ; 1.943806e+002 ];
omc_error_6 = [ 2.269913e-002 ; 1.773005e-002 ; 6.759099e-002 ];
Tc_error_6  = [ 1.024764e+001 ; 4.555987e+000 ; 8.164986e+001 ];

%-- Image #7:
omc_7 = [ -1.818397e+000 ; -2.463978e+000 ; 1.153959e-001 ];
Tc_7  = [ 8.609418e+000 ; 1.866499e-001 ; 1.792665e+002 ];
omc_error_7 = [ 3.371124e-002 ; 4.627639e-002 ; 8.151203e-002 ];
Tc_error_7  = [ 9.465797e+000 ; 4.199201e+000 ; 7.538110e+001 ];

%-- Image #8:
omc_8 = [ -1.749691e+000 ; -2.376391e+000 ; -8.028089e-002 ];
Tc_8  = [ 8.540982e+000 ; 5.642420e-002 ; 1.769646e+002 ];
omc_error_8 = [ 2.243508e-002 ; 3.907435e-002 ; 4.911074e-002 ];
Tc_error_8  = [ 9.344993e+000 ; 4.144897e+000 ; 7.463689e+001 ];

