% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3492.872379128244600 ; 3472.604966813590200 ];

%-- Principal point:
cc = [ 1883.454298750721800 ; 1346.275247414107800 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.087126233639970 ; -0.561508364560269 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 799.612385735531690 ; 793.871991791890990 ];

%-- Principal point uncertainty:
cc_error = [ 567.589795361521850 ; 436.078346299720980 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.209413330658940 ; 2.194551992762523 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 1.967001e+000 ; 1.918217e+000 ; 4.767991e-002 ];
Tc_1  = [ -6.023334e+000 ; -9.050046e+001 ; 1.005877e+003 ];
omc_error_1 = [ 1.068570e-001 ; 1.106170e-001 ; 8.565689e-002 ];
Tc_error_1  = [ 1.636129e+002 ; 1.252751e+002 ; 2.308595e+002 ];

%-- Image #2:
omc_2 = [ 1.999268e+000 ; 1.996949e+000 ; -9.918766e-002 ];
Tc_2  = [ 1.617139e+002 ; -8.912017e+001 ; 9.810841e+002 ];
omc_error_2 = [ 1.112495e-001 ; 1.224997e-001 ; 9.212811e-002 ];
Tc_error_2  = [ 1.579117e+002 ; 1.224709e+002 ; 2.295729e+002 ];

%-- Image #3:
omc_3 = [ 1.929347e+000 ; 1.836687e+000 ; 1.495114e-001 ];
Tc_3  = [ -1.718119e+002 ; -9.095270e+001 ; 1.002947e+003 ];
omc_error_3 = [ 1.084853e-001 ; 1.049100e-001 ; 1.015850e-001 ];
Tc_error_3  = [ 1.666267e+002 ; 1.255705e+002 ; 2.292704e+002 ];

%-- Image #4:
omc_4 = [ 1.919023e+000 ; 1.897271e+000 ; 2.319828e-001 ];
Tc_4  = [ -1.579817e+002 ; -1.576685e+002 ; 9.873749e+002 ];
omc_error_4 = [ 1.139513e-001 ; 1.040556e-001 ; 9.698857e-002 ];
Tc_error_4  = [ 1.646509e+002 ; 1.237149e+002 ; 2.284079e+002 ];

%-- Image #5:
omc_5 = [ 1.989987e+000 ; 2.057003e+000 ; 7.937648e-003 ];
Tc_5  = [ 1.452793e+002 ; -1.414178e+002 ; 9.861680e+002 ];
omc_error_5 = [ 1.152624e-001 ; 1.174123e-001 ; 8.250637e-002 ];
Tc_error_5  = [ 1.581904e+002 ; 1.229903e+002 ; 2.351454e+002 ];

%-- Image #6:
omc_6 = [ 2.043308e+000 ; 1.906431e+000 ; 6.454117e-002 ];
Tc_6  = [ 7.790552e+000 ; -1.546918e+002 ; 9.882254e+002 ];
omc_error_6 = [ 1.118465e-001 ; 1.108112e-001 ; 7.912097e-002 ];
Tc_error_6  = [ 1.608043e+002 ; 1.226210e+002 ; 2.297260e+002 ];

