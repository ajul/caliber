% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1666.498198587890600 ; 1669.948634361557400 ];

%-- Principal point:
cc = [ 606.801450556389910 ; 443.833715824390200 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.205791041852331 ; 0.152884139068326 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 19.352496153267662 ; 14.882814637998822 ];

%-- Principal point uncertainty:
cc_error = [ 17.435374282649690 ; 15.781075162406680 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.010694064235571 ; 0.061238326362775 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -1.844951e+000 ; -2.006839e+000 ; 9.654436e-001 ];
Tc_1  = [ 7.362221e+001 ; -2.625103e+001 ; 1.282927e+003 ];
omc_error_1 = [ 6.884430e-003 ; 6.285363e-003 ; 1.333986e-002 ];
Tc_error_1  = [ 1.354718e+001 ; 1.210590e+001 ; 1.194791e+001 ];

%-- Image #2:
omc_2 = [ -1.726945e+000 ; -1.919229e+000 ; 1.064330e+000 ];
Tc_2  = [ 2.615921e+002 ; -2.691854e+001 ; 1.262749e+003 ];
omc_error_2 = [ 7.168596e-003 ; 6.182286e-003 ; 1.221495e-002 ];
Tc_error_2  = [ 1.378273e+001 ; 1.201152e+001 ; 1.178537e+001 ];

%-- Image #3:
omc_3 = [ -1.955891e+000 ; -2.087750e+000 ; 8.632453e-001 ];
Tc_3  = [ -1.075117e+002 ; -2.578023e+001 ; 1.276667e+003 ];
omc_error_3 = [ 6.677398e-003 ; 6.493831e-003 ; 1.456577e-002 ];
Tc_error_3  = [ 1.320448e+001 ; 1.205433e+001 ; 1.241997e+001 ];

%-- Image #4:
omc_4 = [ -1.948410e+000 ; -2.055382e+000 ; 7.809554e-001 ];
Tc_4  = [ -1.135623e+002 ; -1.063131e+002 ; 1.262562e+003 ];
omc_error_4 = [ 6.197695e-003 ; 6.166824e-003 ; 1.530052e-002 ];
Tc_error_4  = [ 1.305934e+001 ; 1.188198e+001 ; 1.252893e+001 ];

%-- Image #5:
omc_5 = [ -1.736846e+000 ; -1.917192e+000 ; 9.651686e-001 ];
Tc_5  = [ 2.206317e+002 ; -1.160315e+002 ; 1.253984e+003 ];
omc_error_5 = [ 6.666940e-003 ; 5.925655e-003 ; 1.281555e-002 ];
Tc_error_5  = [ 1.362365e+001 ; 1.186251e+001 ; 1.199217e+001 ];

%-- Image #6:
omc_6 = [ -1.888475e+000 ; -1.921708e+000 ; 9.799567e-001 ];
Tc_6  = [ 8.782873e+001 ; -9.043182e+000 ; 1.285297e+003 ];
omc_error_6 = [ 6.847794e-003 ; 6.098893e-003 ; 1.346814e-002 ];
Tc_error_6  = [ 1.360693e+001 ; 1.214701e+001 ; 1.176589e+001 ];

