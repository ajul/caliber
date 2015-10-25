% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2439.327040720532800 ; 2441.103655183724200 ];

%-- Principal point:
cc = [ 662.299094408538620 ; 473.995675841330520 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.252576696502840 ; 0.286188672299628 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 138.269754379319920 ; 140.632549864149270 ];

%-- Principal point uncertainty:
cc_error = [ 86.945079312771668 ; 77.179808321192198 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.064081719711006 ; 0.799217222505059 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


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
omc_1 = [ 2.071650e+000 ; 1.981207e+000 ; 7.824613e-003 ];
Tc_1  = [ -9.793858e+001 ; -1.850941e+001 ; 1.465821e+003 ];
omc_error_1 = [ 2.133799e-002 ; 2.170234e-002 ; 3.219192e-002 ];
Tc_error_1  = [ 5.242428e+001 ; 4.635907e+001 ; 8.295149e+001 ];

%-- Image #2:
omc_2 = [ 2.131726e+000 ; 2.063263e+000 ; -1.459933e-001 ];
Tc_2  = [ 1.152656e+002 ; -2.259081e+001 ; 1.462380e+003 ];
omc_error_2 = [ 2.353628e-002 ; 2.482331e-002 ; 3.468866e-002 ];
Tc_error_2  = [ 5.206093e+001 ; 4.625988e+001 ; 8.512862e+001 ];

%-- Image #3:
omc_3 = [ 2.010191e+000 ; 1.901529e+000 ; 1.416360e-001 ];
Tc_3  = [ -3.008302e+002 ; -1.381169e+001 ; 1.441378e+003 ];
omc_error_3 = [ 1.928159e-002 ; 1.888390e-002 ; 3.174872e-002 ];
Tc_error_3  = [ 5.238144e+001 ; 4.602304e+001 ; 8.191779e+001 ];

%-- Image #4:
omc_4 = [ 2.028496e+000 ; 1.945980e+000 ; 2.138616e-001 ];
Tc_4  = [ -2.945495e+002 ; -1.167591e+002 ; 1.424792e+003 ];
omc_error_4 = [ 1.961389e-002 ; 1.878597e-002 ; 3.266881e-002 ];
Tc_error_4  = [ 5.194727e+001 ; 4.539334e+001 ; 8.267041e+001 ];

%-- Image #5:
omc_5 = [ 2.131995e+000 ; 2.105813e+000 ; -4.465436e-002 ];
Tc_5  = [ 8.194816e+001 ; -1.165718e+002 ; 1.448935e+003 ];
omc_error_5 = [ 2.570166e-002 ; 2.634437e-002 ; 3.347787e-002 ];
Tc_error_5  = [ 5.163365e+001 ; 4.575036e+001 ; 8.501970e+001 ];

%-- Image #6:
omc_6 = [ 2.156119e+000 ; 1.946597e+000 ; 1.008233e-002 ];
Tc_6  = [ -8.333031e+001 ; -6.479781e+001 ; 1.459055e+003 ];
omc_error_6 = [ 2.278866e-002 ; 2.247200e-002 ; 3.236980e-002 ];
Tc_error_6  = [ 5.214807e+001 ; 4.607222e+001 ; 8.300563e+001 ];

