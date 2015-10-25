% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1663.032631436326000 ; 1667.827320033727600 ];

%-- Principal point:
cc = [ 600.404382735859940 ; 445.190069700131180 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.205020267416972 ; 0.131346383874539 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 18.739263995018892 ; 14.794596368826204 ];

%-- Principal point uncertainty:
cc_error = [ 18.251672929785837 ; 14.228352222617437 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.008678223110703 ; 0.028992049291815 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -1.934948e+000 ; -1.954828e+000 ; 9.420726e-001 ];
Tc_1  = [ 1.381742e+001 ; -5.069564e+000 ; 1.285509e+003 ];
omc_error_1 = [ 6.756477e-003 ; 6.449078e-003 ; 1.398907e-002 ];
Tc_error_1  = [ 1.412562e+001 ; 1.095970e+001 ; 1.176577e+001 ];

%-- Image #2:
omc_2 = [ -1.789128e+000 ; -1.851830e+000 ; 1.056164e+000 ];
Tc_2  = [ 2.424060e+002 ; -2.080567e+001 ; 1.266364e+003 ];
omc_error_2 = [ 6.943147e-003 ; 6.249637e-003 ; 1.258082e-002 ];
Tc_error_2  = [ 1.440939e+001 ; 1.086797e+001 ; 1.136735e+001 ];

%-- Image #3:
omc_3 = [ -1.839473e+000 ; -1.984490e+000 ; 9.639236e-001 ];
Tc_3  = [ 9.130559e+001 ; -3.781584e+001 ; 1.279204e+003 ];
omc_error_3 = [ 6.815265e-003 ; 6.475191e-003 ; 1.339876e-002 ];
Tc_error_3  = [ 1.419307e+001 ; 1.089548e+001 ; 1.171156e+001 ];

%-- Image #4:
omc_4 = [ -1.677104e+000 ; -1.865196e+000 ; 1.093541e+000 ];
Tc_4  = [ 3.468505e+002 ; -4.245894e+001 ; 1.241706e+003 ];
omc_error_4 = [ 7.060242e-003 ; 6.388817e-003 ; 1.177340e-002 ];
Tc_error_4  = [ 1.443347e+001 ; 1.072843e+001 ; 1.146744e+001 ];

%-- Image #5:
omc_5 = [ -1.691656e+000 ; -1.868220e+000 ; 9.750158e-001 ];
Tc_5  = [ 2.908682e+002 ; -1.482030e+002 ; 1.233677e+003 ];
omc_error_5 = [ 6.440119e-003 ; 6.084697e-003 ; 1.248063e-002 ];
Tc_error_5  = [ 1.424915e+001 ; 1.058700e+001 ; 1.173426e+001 ];

%-- Image #6:
omc_6 = [ -1.959775e+000 ; -2.036975e+000 ; 7.499566e-001 ];
Tc_6  = [ -1.258588e+002 ; -1.290001e+002 ; 1.254860e+003 ];
omc_error_6 = [ 6.058287e-003 ; 6.267532e-003 ; 1.569927e-002 ];
Tc_error_6  = [ 1.363037e+001 ; 1.066394e+001 ; 1.247455e+001 ];

