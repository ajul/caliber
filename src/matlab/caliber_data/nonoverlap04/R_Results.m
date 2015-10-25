% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3521.097257282760900 ; 3491.202255505173100 ];

%-- Principal point:
cc = [ 2008.650851002714300 ; 1384.173654667753000 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.159597078328530 ; 0.097948967234043 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 58.649938076109628 ; 49.717006204213327 ];

%-- Principal point uncertainty:
cc_error = [ 63.149498489136583 ; 44.964381301789061 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.013905966174578 ; 0.056757579235931 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 4272;
ny = 2848;


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
omc_1 = [ 1.968345e+000 ; 1.748669e+000 ; 2.943756e-001 ];
Tc_1  = [ -7.893571e+001 ; -1.612736e+002 ; 9.772113e+002 ];
omc_error_1 = [ 9.941997e-003 ; 9.115340e-003 ; 1.105505e-002 ];
Tc_error_1  = [ 1.795308e+001 ; 1.240209e+001 ; 1.457570e+001 ];

%-- Image #2:
omc_2 = [ 2.037920e+000 ; 1.868466e+000 ; 1.453729e-001 ];
Tc_2  = [ 1.247249e+002 ; -1.660533e+002 ; 9.597863e+002 ];
omc_error_2 = [ 1.015917e-002 ; 8.843928e-003 ; 8.956364e-003 ];
Tc_error_2  = [ 1.681741e+001 ; 1.216351e+001 ; 1.463437e+001 ];

%-- Image #3:
omc_3 = [ 1.928292e+000 ; 1.817396e+000 ; 2.320158e-001 ];
Tc_3  = [ -8.493701e+000 ; -1.167394e+002 ; 9.892522e+002 ];
omc_error_3 = [ 9.921790e-003 ; 9.153380e-003 ; 1.072068e-002 ];
Tc_error_3  = [ 1.781047e+001 ; 1.258790e+001 ; 1.462579e+001 ];

%-- Image #4:
omc_4 = [ 2.000668e+000 ; 1.946047e+000 ; 5.352243e-002 ];
Tc_4  = [ 2.181976e+002 ; -1.127477e+002 ; 9.525865e+002 ];
omc_error_4 = [ 9.865193e-003 ; 8.869190e-003 ; 8.453358e-003 ];
Tc_error_4  = [ 1.638364e+001 ; 1.218315e+001 ; 1.462548e+001 ];

%-- Image #5:
omc_5 = [ 1.970146e+000 ; 1.995482e+000 ; 1.637133e-001 ];
Tc_5  = [ 1.917149e+002 ; -1.675569e+002 ; 9.437300e+002 ];
omc_error_5 = [ 1.063966e-002 ; 8.708736e-003 ; 8.716761e-003 ];
Tc_error_5  = [ 1.622152e+001 ; 1.209030e+001 ; 1.457556e+001 ];

%-- Image #6:
omc_6 = [ 1.859205e+000 ; 1.768794e+000 ; 4.474368e-001 ];
Tc_6  = [ -1.782368e+002 ; -1.944754e+002 ; 9.653034e+002 ];
omc_error_6 = [ 1.003922e-002 ; 8.803591e-003 ; 1.236529e-002 ];
Tc_error_6  = [ 1.841374e+001 ; 1.241709e+001 ; 1.437393e+001 ];

