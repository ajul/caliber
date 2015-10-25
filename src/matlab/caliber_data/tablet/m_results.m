% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3493.137125807182700 ; 3491.258849882229200 ];

%-- Principal point:
cc = [ 642.522555257899970 ; 451.774752666818190 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.009007880329515 ; -94.682246868077556 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 130.210126000523300 ; 127.090045240872850 ];

%-- Principal point uncertainty:
cc_error = [ 67.563064096232608 ; 82.106731125724735 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.985876604133948 ; 586.680545521048200 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -2.072426e+000 ; -2.263443e+000 ; 5.412018e-001 ];
Tc_1  = [ -1.188588e+000 ; -3.360684e+000 ; 1.991617e+002 ];
omc_error_1 = [ 1.757177e-002 ; 1.137270e-002 ; 3.128455e-002 ];
Tc_error_1  = [ 3.851638e+000 ; 4.681042e+000 ; 7.315392e+000 ];

%-- Image #2:
omc_2 = [ 1.549644e+000 ; 2.659472e+000 ; -8.098368e-002 ];
Tc_2  = [ 2.843668e-001 ; -4.917570e+000 ; 1.969475e+002 ];
omc_error_2 = [ 9.590451e-003 ; 1.775251e-002 ; 3.980632e-002 ];
Tc_error_2  = [ 3.809145e+000 ; 4.625112e+000 ; 7.318206e+000 ];

%-- Image #3:
omc_3 = [ -2.304858e-001 ; -2.957810e+000 ; 6.201669e-001 ];
Tc_3  = [ 5.568587e+000 ; -6.330590e+000 ; 1.990048e+002 ];
omc_error_3 = [ 8.053801e-003 ; 1.847350e-002 ; 3.118453e-002 ];
Tc_error_3  = [ 3.849746e+000 ; 4.671667e+000 ; 7.385064e+000 ];

%-- Image #4:
omc_4 = [ -1.924985e+000 ; -2.329743e+000 ; 1.811438e-001 ];
Tc_4  = [ -2.262334e+000 ; -3.052246e+000 ; 1.974818e+002 ];
omc_error_4 = [ 1.388207e-002 ; 1.473199e-002 ; 3.822857e-002 ];
Tc_error_4  = [ 3.818291e+000 ; 4.643840e+000 ; 7.240895e+000 ];

%-- Image #5:
omc_5 = [ -1.691912e+000 ; -2.040269e+000 ; 1.155120e+000 ];
Tc_5  = [ 2.533754e-001 ; -3.594931e+000 ; 2.023707e+002 ];
omc_error_5 = [ 2.179421e-002 ; 1.237171e-002 ; 2.902404e-002 ];
Tc_error_5  = [ 3.914367e+000 ; 4.758371e+000 ; 7.326830e+000 ];

%-- Image #6:
omc_6 = [ 1.158934e+000 ; 1.983688e+000 ; 1.020222e-001 ];
Tc_6  = [ 3.026182e+000 ; -6.215797e+000 ; 1.952607e+002 ];
omc_error_6 = [ 1.748679e-002 ; 1.831400e-002 ; 2.272854e-002 ];
Tc_error_6  = [ 3.778123e+000 ; 4.590000e+000 ; 7.168233e+000 ];

%-- Image #7:
omc_7 = [ 1.679009e+000 ; 2.309280e+000 ; -3.584679e-001 ];
Tc_7  = [ 4.629853e-001 ; -4.754619e+000 ; 2.021443e+002 ];
omc_error_7 = [ 1.105004e-002 ; 1.912546e-002 ; 2.619784e-002 ];
Tc_error_7  = [ 3.909851e+000 ; 4.746409e+000 ; 7.528716e+000 ];

%-- Image #8:
omc_8 = [ 1.545148e+000 ; 1.970376e+000 ; 8.730167e-002 ];
Tc_8  = [ -1.913114e+000 ; -5.655876e+000 ; 1.908461e+002 ];
omc_error_8 = [ 1.774484e-002 ; 1.718569e-002 ; 2.384692e-002 ];
Tc_error_8  = [ 3.690708e+000 ; 4.485588e+000 ; 7.026804e+000 ];

