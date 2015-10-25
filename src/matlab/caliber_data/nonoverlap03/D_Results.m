% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 4354.962940884569400 ; 4601.741022800914800 ];

%-- Principal point:
cc = [ 1832.520707077229000 ; 1658.702334730239500 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.132559557859853 ; 0.129339238810115 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 125.048275119105310 ; 109.788984574762200 ];

%-- Principal point uncertainty:
cc_error = [ 130.764058681617740 ; 59.987334680758345 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.021317857573620 ; 0.080695906878002 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -1.696912e+000 ; -1.912434e+000 ; 9.916785e-001 ];
Tc_1  = [ 2.173366e+002 ; -4.661302e+001 ; 1.997523e+003 ];
omc_error_1 = [ 1.742705e-002 ; 1.891774e-002 ; 2.910082e-002 ];
Tc_error_1  = [ 6.105227e+001 ; 2.603907e+001 ; 4.747331e+001 ];

%-- Image #2:
omc_2 = [ -1.585159e+000 ; -1.804757e+000 ; 1.080682e+000 ];
Tc_2  = [ 5.275391e+002 ; -3.922122e+001 ; 1.989353e+003 ];
omc_error_2 = [ 1.748986e-002 ; 1.907461e-002 ; 2.639598e-002 ];
Tc_error_2  = [ 6.283836e+001 ; 2.613264e+001 ; 4.755586e+001 ];

%-- Image #3:
omc_3 = [ -1.805498e+000 ; -2.015218e+000 ; 8.951746e-001 ];
Tc_3  = [ -8.048368e+001 ; -5.582595e+001 ; 1.963034e+003 ];
omc_error_3 = [ 1.737646e-002 ; 1.886279e-002 ; 3.195679e-002 ];
Tc_error_3  = [ 5.861906e+001 ; 2.553623e+001 ; 4.834087e+001 ];

%-- Image #4:
omc_4 = [ -1.823611e+000 ; -1.964508e+000 ; 8.138363e-001 ];
Tc_4  = [ -9.410816e+001 ; -1.427417e+002 ; 1.956498e+003 ];
omc_error_4 = [ 1.572712e-002 ; 1.835162e-002 ; 3.307708e-002 ];
Tc_error_4  = [ 5.838152e+001 ; 2.542748e+001 ; 4.853828e+001 ];

%-- Image #5:
omc_5 = [ -1.617812e+000 ; -1.787160e+000 ; 9.868100e-001 ];
Tc_5  = [ 4.577500e+002 ; -1.535416e+002 ; 1.986648e+003 ];
omc_error_5 = [ 1.598762e-002 ; 1.865330e-002 ; 2.801756e-002 ];
Tc_error_5  = [ 6.241677e+001 ; 2.603417e+001 ; 4.760918e+001 ];

%-- Image #6:
omc_6 = [ -1.746645e+000 ; -1.834909e+000 ; 1.020554e+000 ];
Tc_6  = [ 2.460415e+002 ; 3.215992e+001 ; 2.006741e+003 ];
omc_error_6 = [ 1.744820e-002 ; 1.827522e-002 ; 2.944459e-002 ];
Tc_error_6  = [ 6.152714e+001 ; 2.623268e+001 ; 4.735504e+001 ];

