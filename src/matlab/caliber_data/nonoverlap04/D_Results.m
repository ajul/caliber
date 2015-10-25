% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 4193.253849778707300 ; 4510.846902947534500 ];

%-- Principal point:
cc = [ 1823.017390058262000 ; 1685.135601405379700 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.138481575819245 ; 0.091350044792769 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 74.640042504229385 ; 66.771584298845781 ];

%-- Principal point uncertainty:
cc_error = [ 92.421756234678000 ; 34.631962455213547 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.012082598607552 ; 0.027999853462062 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -1.759859e+000 ; -1.881723e+000 ; 9.804808e-001 ];
Tc_1  = [ 1.128910e+002 ; 2.316458e+001 ; 1.977654e+003 ];
omc_error_1 = [ 1.269925e-002 ; 1.282167e-002 ; 2.028507e-002 ];
Tc_error_1  = [ 4.406441e+001 ; 1.520108e+001 ; 2.898660e+001 ];

%-- Image #2:
omc_2 = [ -1.618337e+000 ; -1.744712e+000 ; 1.084446e+000 ];
Tc_2  = [ 5.013103e+002 ; 1.328668e+001 ; 1.977540e+003 ];
omc_error_2 = [ 1.287060e-002 ; 1.295375e-002 ; 1.818225e-002 ];
Tc_error_2  = [ 4.614198e+001 ; 1.531432e+001 ; 2.849749e+001 ];

%-- Image #3:
omc_3 = [ -1.663159e+000 ; -1.888973e+000 ; 9.889461e-001 ];
Tc_3  = [ 2.387938e+002 ; -6.274157e+001 ; 1.977360e+003 ];
omc_error_3 = [ 1.262264e-002 ; 1.314479e-002 ; 1.935945e-002 ];
Tc_error_3  = [ 4.464730e+001 ; 1.518580e+001 ; 2.877310e+001 ];

%-- Image #4:
omc_4 = [ -1.506459e+000 ; -1.735759e+000 ; 1.105736e+000 ];
Tc_4  = [ 6.729890e+002 ; -5.910898e+001 ; 1.948915e+003 ];
omc_error_4 = [ 1.272508e-002 ; 1.347762e-002 ; 1.674953e-002 ];
Tc_error_4  = [ 4.661667e+001 ; 1.517698e+001 ; 2.874640e+001 ];

%-- Image #5:
omc_5 = [ -1.547625e+000 ; -1.722872e+000 ; 9.907281e-001 ];
Tc_5  = [ 5.756731e+002 ; -1.993238e+002 ; 1.950867e+003 ];
omc_error_5 = [ 1.145922e-002 ; 1.318615e-002 ; 1.801935e-002 ];
Tc_error_5  = [ 4.619380e+001 ; 1.514447e+001 ; 2.888682e+001 ];

%-- Image #6:
omc_6 = [ -1.813954e+000 ; -1.950779e+000 ; 7.767697e-001 ];
Tc_6  = [ -1.318968e+002 ; -1.694419e+002 ; 1.929074e+003 ];
omc_error_6 = [ 1.102133e-002 ; 1.254752e-002 ; 2.224991e-002 ];
Tc_error_6  = [ 4.205229e+001 ; 1.477743e+001 ; 3.003425e+001 ];

