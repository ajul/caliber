% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2434.626485177513100 ; 2434.358634933152200 ];

%-- Principal point:
cc = [ 723.271004789577770 ; 443.984503831019370 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.251279118867598 ; 0.158735806841465 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 64.632921258581575 ; 64.362894148975741 ];

%-- Principal point uncertainty:
cc_error = [ 54.852284279440546 ; 49.792011677288620 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.028420076067771 ; 0.366392264392931 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.036472e+000 ; 1.926715e+000 ; 1.224029e-001 ];
Tc_1  = [ -1.153574e+002 ; -1.106904e+002 ; 1.222366e+003 ];
omc_error_1 = [ 1.587323e-002 ; 1.528320e-002 ; 1.919231e-002 ];
Tc_error_1  = [ 2.776899e+001 ; 2.497040e+001 ; 3.285307e+001 ];

%-- Image #2:
omc_2 = [ 2.006810e+000 ; 1.870433e+000 ; 3.704098e-002 ];
Tc_2  = [ -1.213040e+002 ; -4.810427e+000 ; 1.239264e+003 ];
omc_error_2 = [ 1.497055e-002 ; 1.470369e-002 ; 1.899070e-002 ];
Tc_error_2  = [ 2.809121e+001 ; 2.539373e+001 ; 3.218045e+001 ];

%-- Image #3:
omc_3 = [ 2.067512e+000 ; 1.964027e+000 ; -1.224822e-001 ];
Tc_3  = [ 7.397142e+001 ; -9.835904e+000 ; 1.236911e+003 ];
omc_error_3 = [ 1.591298e-002 ; 1.627813e-002 ; 2.054291e-002 ];
Tc_error_3  = [ 2.781953e+001 ; 2.529955e+001 ; 3.338025e+001 ];

%-- Image #4:
omc_4 = [ 1.956981e+000 ; 1.797307e+000 ; 1.457281e-001 ];
Tc_4  = [ -2.699591e+002 ; -8.520582e-001 ; 1.220619e+003 ];
omc_error_4 = [ 1.401248e-002 ; 1.349129e-002 ; 1.869545e-002 ];
Tc_error_4  = [ 2.809288e+001 ; 2.525800e+001 ; 3.193706e+001 ];

%-- Image #5:
omc_5 = [ 1.873750e+000 ; 2.004513e+000 ; -1.675118e-002 ];
Tc_5  = [ -4.595704e+001 ; 4.307733e+001 ; 1.248387e+003 ];
omc_error_5 = [ 1.456716e-002 ; 1.522970e-002 ; 1.943887e-002 ];
Tc_error_5  = [ 2.819438e+001 ; 2.558353e+001 ; 3.254549e+001 ];

%-- Image #6:
omc_6 = [ 1.972080e+000 ; 1.866617e+000 ; -8.246788e-002 ];
Tc_6  = [ -6.745365e+001 ; 9.431513e+001 ; 1.250852e+003 ];
omc_error_6 = [ 1.412712e-002 ; 1.448605e-002 ; 1.940190e-002 ];
Tc_error_6  = [ 2.829723e+001 ; 2.574362e+001 ; 3.225107e+001 ];

