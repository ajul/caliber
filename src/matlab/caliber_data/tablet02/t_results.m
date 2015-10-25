% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1201.848817084698300 ; 1199.502313924284900 ];

%-- Principal point:
cc = [ 472.563883008714470 ; 350.778489774138280 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.078171882383752 ; -0.407332402646829 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 34.752836774727989 ; 38.094941244078591 ];

%-- Principal point uncertainty:
cc_error = [ 35.522636469315898 ; 14.593156885504293 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.048455323885364 ; 0.208331086311998 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 960;
ny = 720;


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
omc_1 = [ -1.324080e+000 ; 2.354194e+000 ; 2.524643e-001 ];
Tc_1  = [ 1.467363e+001 ; 1.136143e+001 ; 5.585908e+001 ];
omc_error_1 = [ 7.597532e-003 ; 2.384671e-002 ; 1.279300e-002 ];
Tc_error_1  = [ 1.604139e+000 ; 6.949387e-001 ; 1.702184e+000 ];

%-- Image #2:
omc_2 = [ -1.922689e-001 ; 2.680784e+000 ; 3.908815e-001 ];
Tc_2  = [ 1.495863e+001 ; -3.896036e+000 ; 5.384236e+001 ];
omc_error_2 = [ 5.449407e-003 ; 2.119463e-002 ; 1.783300e-002 ];
Tc_error_2  = [ 1.520958e+000 ; 6.527232e-001 ; 1.659343e+000 ];

%-- Image #3:
omc_3 = [ -7.345095e-001 ; 2.725874e+000 ; -2.971741e-001 ];
Tc_3  = [ 1.830117e+001 ; -1.362381e+000 ; 5.445076e+001 ];
omc_error_3 = [ 9.354424e-003 ; 1.582039e-002 ; 1.119784e-002 ];
Tc_error_3  = [ 1.500316e+000 ; 6.579292e-001 ; 1.732239e+000 ];

%-- Image #4:
omc_4 = [ -2.872073e+000 ; 1.124177e+000 ; -3.345774e-001 ];
Tc_4  = [ -2.251992e-001 ; 1.364357e+001 ; 5.349168e+001 ];
omc_error_4 = [ 1.077469e-002 ; 5.181318e-003 ; 2.961236e-002 ];
Tc_error_4  = [ 1.577590e+000 ; 6.596511e-001 ; 1.726370e+000 ];

%-- Image #5:
omc_5 = [ -1.896797e+000 ; 1.438637e+000 ; -5.870919e-001 ];
Tc_5  = [ -1.139243e+001 ; -7.861127e+000 ; 6.453402e+001 ];
omc_error_5 = [ 1.928349e-002 ; 1.663118e-002 ; 2.370758e-002 ];
Tc_error_5  = [ 1.957890e+000 ; 7.955864e-001 ; 1.976617e+000 ];

%-- Image #6:
omc_6 = [ -7.423905e-001 ; 2.825368e+000 ; -5.616888e-001 ];
Tc_6  = [ 2.132837e+001 ; 3.154947e+000 ; 5.454189e+001 ];
omc_error_6 = [ 1.288240e-002 ; 1.779145e-002 ; 1.984254e-002 ];
Tc_error_6  = [ 1.544465e+000 ; 6.701640e-001 ; 1.665194e+000 ];

%-- Image #7:
omc_7 = [ -4.053285e-001 ; 2.663906e+000 ; -1.459376e-001 ];
Tc_7  = [ 4.395058e+000 ; -1.798932e+000 ; 6.092893e+001 ];
omc_error_7 = [ 6.219143e-003 ; 1.807486e-002 ; 1.504619e-002 ];
Tc_error_7  = [ 1.770590e+000 ; 7.396912e-001 ; 1.918154e+000 ];

%-- Image #8:
omc_8 = [ -3.746331e-001 ; 2.610647e+000 ; 1.791482e-001 ];
Tc_8  = [ 4.671651e+000 ; 1.056673e+001 ; 6.128779e+001 ];
omc_error_8 = [ 4.488343e-003 ; 1.912346e-002 ; 1.546616e-002 ];
Tc_error_8  = [ 1.775635e+000 ; 7.532957e-001 ; 1.973733e+000 ];

