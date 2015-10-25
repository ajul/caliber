% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2966.121674423946400 ; 2943.070694228140400 ];

%-- Principal point:
cc = [ 722.054263310443730 ; 337.921976469638540 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.171718513021898 ; 41.742955553855261 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 650.814467341100910 ; 641.987636968626700 ];

%-- Principal point uncertainty:
cc_error = [ 37.699789936460476 ; 138.384351612291200 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.860187198361704 ; 61.861411979223661 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -2.443477e+000 ; -1.812199e+000 ; 6.747385e-002 ];
Tc_1  = [ -8.312896e+000 ; 8.804415e+000 ; 1.271439e+002 ];
omc_error_1 = [ 5.648688e-002 ; 3.811142e-002 ; 7.268028e-002 ];
Tc_error_1  = [ 1.602305e+000 ; 5.996012e+000 ; 2.768872e+001 ];

%-- Image #2:
omc_2 = [ -2.070034e+000 ; -2.286872e+000 ; 1.636544e-001 ];
Tc_2  = [ -3.692817e+000 ; 7.425592e+000 ; 1.276519e+002 ];
omc_error_2 = [ 4.594712e-002 ; 5.080518e-002 ; 1.224335e-001 ];
Tc_error_2  = [ 1.619384e+000 ; 6.026225e+000 ; 2.748313e+001 ];

%-- Image #3:
omc_3 = [ 1.578530e+000 ; 2.653106e+000 ; 7.637370e-002 ];
Tc_3  = [ 7.395830e-001 ; 7.830723e+000 ; 1.276135e+002 ];
omc_error_3 = [ 3.864915e-002 ; 5.755942e-002 ; 8.582222e-002 ];
Tc_error_3  = [ 1.622480e+000 ; 6.010962e+000 ; 2.787528e+001 ];

%-- Image #4:
omc_4 = [ -2.846515e+000 ; -1.168845e+000 ; -1.729513e-001 ];
Tc_4  = [ -4.314286e+000 ; 1.118485e+001 ; 1.264765e+002 ];
omc_error_4 = [ 5.352262e-002 ; 2.452902e-002 ; 3.694731e-002 ];
Tc_error_4  = [ 1.611775e+000 ; 5.949549e+000 ; 2.769877e+001 ];

%-- Image #5:
omc_5 = [ -2.187696e+000 ; -1.672617e+000 ; -2.008373e-001 ];
Tc_5  = [ -7.084417e-001 ; 7.692857e+000 ; 1.172896e+002 ];
omc_error_5 = [ 3.276357e-002 ; 1.976592e-002 ; 4.566466e-002 ];
Tc_error_5  = [ 1.491403e+000 ; 5.511375e+000 ; 2.565586e+001 ];

%-- Image #6:
omc_6 = [ 1.799692e+000 ; 2.302240e+000 ; 7.638630e-002 ];
Tc_6  = [ 8.992044e-001 ; 6.578381e+000 ; 1.221641e+002 ];
omc_error_6 = [ 3.323826e-002 ; 3.421683e-002 ; 8.724953e-002 ];
Tc_error_6  = [ 1.555075e+000 ; 5.766793e+000 ; 2.618027e+001 ];

%-- Image #7:
omc_7 = [ -1.974427e+000 ; -2.416095e+000 ; -2.112835e-001 ];
Tc_7  = [ 3.436760e-001 ; 5.874802e+000 ; 1.163333e+002 ];
omc_error_7 = [ 2.758950e-002 ; 3.768763e-002 ; 6.758478e-002 ];
Tc_error_7  = [ 1.480038e+000 ; 5.478606e+000 ; 2.554440e+001 ];

%-- Image #8:
omc_8 = [ 1.844133e+000 ; 2.339829e+000 ; 4.106366e-001 ];
Tc_8  = [ 6.505968e-001 ; 4.620054e+000 ; 1.155804e+002 ];
omc_error_8 = [ 2.472007e-002 ; 2.161686e-002 ; 6.584107e-002 ];
Tc_error_8  = [ 1.469511e+000 ; 5.447439e+000 ; 2.527530e+001 ];

