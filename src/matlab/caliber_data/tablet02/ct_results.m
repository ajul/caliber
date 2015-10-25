% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 7319.022565000981600 ; 7324.994081235198800 ];

%-- Principal point:
cc = [ 668.966934246553590 ; 501.865113885990810 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.191896645942987 ; -34.420908828216440 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 381.891934857703920 ; 382.335524871432430 ];

%-- Principal point uncertainty:
cc_error = [ 127.795068010020810 ; 118.946632864342080 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.460053116009771 ; 86.800080820801170 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.524795e+000 ; 1.855385e+000 ; 5.209456e-002 ];
Tc_1  = [ -7.659721e+000 ; 2.088605e+000 ; 1.554187e+002 ];
omc_error_1 = [ 1.954914e-002 ; 1.453699e-002 ; 2.735103e-002 ];
Tc_error_1  = [ 2.716736e+000 ; 2.523736e+000 ; 8.101481e+000 ];

%-- Image #2:
omc_2 = [ 2.117045e+000 ; 2.321060e+000 ; 2.371223e-002 ];
Tc_2  = [ -3.038874e+000 ; 6.018409e-001 ; 1.556761e+002 ];
omc_error_2 = [ 1.523961e-002 ; 1.665840e-002 ; 3.159248e-002 ];
Tc_error_2  = [ 2.718637e+000 ; 2.528259e+000 ; 8.136213e+000 ];

%-- Image #3:
omc_3 = [ 1.565580e+000 ; 2.588209e+000 ; 1.008870e-001 ];
Tc_3  = [ 1.371173e+000 ; 9.477604e-001 ; 1.562980e+002 ];
omc_error_3 = [ 6.513335e-003 ; 1.068644e-002 ; 2.728101e-002 ];
Tc_error_3  = [ 2.728343e+000 ; 2.538640e+000 ; 8.086244e+000 ];

%-- Image #4:
omc_4 = [ -2.848292e+000 ; -1.154218e+000 ; -3.445194e-001 ];
Tc_4  = [ -3.445290e+000 ; 4.391563e+000 ; 1.538333e+002 ];
omc_error_4 = [ 1.217912e-002 ; 6.547028e-003 ; 2.762283e-002 ];
Tc_error_4  = [ 2.687135e+000 ; 2.498692e+000 ; 8.018108e+000 ];

%-- Image #5:
omc_5 = [ -2.164623e+000 ; -1.668833e+000 ; -3.290525e-001 ];
Tc_5  = [ 7.881077e-001 ; 1.384676e+000 ; 1.430034e+002 ];
omc_error_5 = [ 1.055900e-002 ; 7.195830e-003 ; 3.017721e-002 ];
Tc_error_5  = [ 2.497509e+000 ; 2.322755e+000 ; 7.402217e+000 ];

%-- Image #6:
omc_6 = [ 1.796987e+000 ; 2.250715e+000 ; 1.640826e-001 ];
Tc_6  = [ 1.972909e+000 ; -4.038604e-003 ; 1.491974e+002 ];
omc_error_6 = [ 6.833780e-003 ; 9.443195e-003 ; 2.910084e-002 ];
Tc_error_6  = [ 2.605133e+000 ; 2.423165e+000 ; 7.690337e+000 ];

%-- Image #7:
omc_7 = [ -1.974615e+000 ; -2.394891e+000 ; -3.255186e-001 ];
Tc_7  = [ 1.853903e+000 ; -3.798710e-001 ; 1.423778e+002 ];
omc_error_7 = [ 4.728986e-003 ; 7.787563e-003 ; 3.187330e-002 ];
Tc_error_7  = [ 2.486044e+000 ; 2.312120e+000 ; 7.416797e+000 ];

%-- Image #8:
omc_8 = [ 1.847581e+000 ; 2.311611e+000 ; 5.205937e-001 ];
Tc_8  = [ 2.169084e+000 ; -1.735847e+000 ; 1.422984e+002 ];
omc_error_8 = [ 8.537017e-003 ; 8.656446e-003 ; 3.000161e-002 ];
Tc_error_8  = [ 2.484151e+000 ; 2.310591e+000 ; 7.437076e+000 ];

