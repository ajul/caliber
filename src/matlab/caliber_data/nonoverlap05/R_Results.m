% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3621.722201651879900 ; 3604.144340352853300 ];

%-- Principal point:
cc = [ 2083.845460366143000 ; 1413.648730768477900 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.168026075762084 ; 0.181938899461171 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 23.868894133332340 ; 19.629340115336056 ];

%-- Principal point uncertainty:
cc_error = [ 20.506122719546198 ; 14.134007140089652 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.004167267280924 ; 0.024729511942600 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 1.871149e+000 ; 1.769095e+000 ; 4.706599e-001 ];
Tc_1  = [ -1.779327e+002 ; -2.100134e+002 ; 1.128578e+003 ];
omc_error_1 = [ 4.574066e-003 ; 3.503918e-003 ; 2.699036e-003 ];
Tc_error_1  = [ 6.637211e+000 ; 4.426067e+000 ; 6.514591e+000 ];

%-- Image #2:
omc_2 = [ 1.875193e+000 ; 1.704315e+000 ; 3.896846e-001 ];
Tc_2  = [ -1.965665e+002 ; -1.222977e+002 ; 1.148599e+003 ];
omc_error_2 = [ 4.329659e-003 ; 3.483336e-003 ; 2.771625e-003 ];
Tc_error_2  = [ 6.734191e+000 ; 4.493809e+000 ; 6.516086e+000 ];

%-- Image #3:
omc_3 = [ 1.941908e+000 ; 1.808900e+000 ; 2.564063e-001 ];
Tc_3  = [ 8.557299e+000 ; -1.207253e+002 ; 1.148886e+003 ];
omc_error_3 = [ 4.456373e-003 ; 3.710801e-003 ; 2.872554e-003 ];
Tc_error_3  = [ 6.504269e+000 ; 4.470230e+000 ; 6.586295e+000 ];

%-- Image #4:
omc_4 = [ 1.820142e+000 ; 1.621731e+000 ; 4.873441e-001 ];
Tc_4  = [ -3.527836e+002 ; -1.225009e+002 ; 1.125226e+003 ];
omc_error_4 = [ 4.234406e-003 ; 3.314757e-003 ; 2.931636e-003 ];
Tc_error_4  = [ 6.846648e+000 ; 4.451535e+000 ; 6.513140e+000 ];

%-- Image #5:
omc_5 = [ 1.748591e+000 ; 1.810386e+000 ; 3.104990e-001 ];
Tc_5  = [ -1.256973e+002 ; -3.524789e+000 ; 1.172934e+003 ];
omc_error_5 = [ 4.163440e-003 ; 3.640818e-003 ; 2.840109e-003 ];
Tc_error_5  = [ 6.774294e+000 ; 4.607971e+000 ; 6.486990e+000 ];

%-- Image #6:
omc_6 = [ 1.870504e+000 ; 1.689740e+000 ; 2.778580e-001 ];
Tc_6  = [ -1.495907e+002 ; -2.574758e+001 ; 1.167835e+003 ];
omc_error_6 = [ 4.111514e-003 ; 3.569903e-003 ; 2.946534e-003 ];
Tc_error_6  = [ 6.756328e+000 ; 4.579358e+000 ; 6.514299e+000 ];

