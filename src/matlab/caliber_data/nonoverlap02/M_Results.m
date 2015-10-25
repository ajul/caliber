% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1640.949038440510800 ; 1640.812592040619200 ];

%-- Principal point:
cc = [ 658.782678214839730 ; 459.762941766087810 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.205350860183417 ; 0.135005347255894 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 6.909441619773406 ; 6.966092290448843 ];

%-- Principal point uncertainty:
cc_error = [ 2.916009222990591 ; 2.018454822995698 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.002403864209361 ; 0.011676721498822 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 12;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.963448e+000 ; 1.922666e+000 ; 3.340461e-001 ];
Tc_1  = [ -1.294154e+002 ; -7.168685e+001 ; 1.093612e+003 ];
omc_error_1 = [ 1.147040e-003 ; 1.077456e-003 ; 2.137947e-003 ];
Tc_error_1  = [ 1.953520e+000 ; 1.347822e+000 ; 4.637563e+000 ];

%-- Image #2:
omc_2 = [ 2.021635e+000 ; 2.009861e+000 ; 2.091709e-001 ];
Tc_2  = [ 3.019690e+001 ; -6.602304e+001 ; 1.085725e+003 ];
omc_error_2 = [ 1.212257e-003 ; 1.199346e-003 ; 2.360303e-003 ];
Tc_error_2  = [ 1.931337e+000 ; 1.334104e+000 ; 4.619641e+000 ];

%-- Image #3:
omc_3 = [ 2.004736e+000 ; 2.135639e+000 ; 3.564655e-001 ];
Tc_3  = [ 5.485935e+001 ; -1.963842e+002 ; 1.051417e+003 ];
omc_error_3 = [ 1.368443e-003 ; 1.301944e-003 ; 2.226327e-003 ];
Tc_error_3  = [ 1.879283e+000 ; 1.300779e+000 ; 4.550924e+000 ];

%-- Image #4:
omc_4 = [ 2.171445e+000 ; 1.975140e+000 ; 3.187903e-001 ];
Tc_4  = [ 2.273941e+001 ; -2.270576e+002 ; 1.043801e+003 ];
omc_error_4 = [ 1.391338e-003 ; 1.224468e-003 ; 2.224944e-003 ];
Tc_error_4  = [ 1.870963e+000 ; 1.294456e+000 ; 4.500009e+000 ];

%-- Image #5:
omc_5 = [ 2.243613e+000 ; 2.145405e+000 ; 9.792339e-002 ];
Tc_5  = [ -1.605311e+002 ; -1.689930e+002 ; 7.866887e+002 ];
omc_error_5 = [ 9.516155e-004 ; 1.106731e-003 ; 2.311240e-003 ];
Tc_error_5  = [ 1.416732e+000 ; 9.759412e-001 ; 3.299715e+000 ];

%-- Image #6:
omc_6 = [ 1.963206e+000 ; 2.268124e+000 ; -2.326818e-004 ];
Tc_6  = [ -1.360530e+002 ; -5.989163e+001 ; 8.218570e+002 ];
omc_error_6 = [ 1.041153e-003 ; 1.309975e-003 ; 2.248692e-003 ];
Tc_error_6  = [ 1.467059e+000 ; 1.013596e+000 ; 3.412618e+000 ];

%-- Image #7:
omc_7 = [ 1.984878e+000 ; 2.311900e+000 ; -8.521282e-002 ];
Tc_7  = [ -6.730196e+001 ; -4.995721e+001 ; 8.233147e+002 ];
omc_error_7 = [ 1.042149e-003 ; 1.275275e-003 ; 2.266596e-003 ];
Tc_error_7  = [ 1.461944e+000 ; 1.011099e+000 ; 3.420745e+000 ];

%-- Image #8:
omc_8 = [ 2.251475e+000 ; 2.140838e+000 ; -4.390856e-002 ];
Tc_8  = [ -9.905660e+001 ; -1.095878e+002 ; 8.065507e+002 ];
omc_error_8 = [ 1.029004e-003 ; 1.120771e-003 ; 2.172187e-003 ];
Tc_error_8  = [ 1.436444e+000 ; 9.909780e-001 ; 3.347283e+000 ];

%-- Image #9:
omc_9 = [ -2.072667e+000 ; -2.239685e+000 ; -2.059666e-001 ];
Tc_9  = [ -1.225246e+002 ; -1.072275e+002 ; 8.115524e+002 ];
omc_error_9 = [ 9.364763e-004 ; 1.045082e-003 ; 2.659200e-003 ];
Tc_error_9  = [ 1.450219e+000 ; 1.002997e+000 ; 3.377311e+000 ];

%-- Image #10:
omc_10 = [ 2.135603e+000 ; 2.217279e+000 ; 4.045500e-001 ];
Tc_10  = [ -2.919278e+002 ; -1.145199e+002 ; 7.925797e+002 ];
omc_error_10 = [ 9.105590e-004 ; 9.796425e-004 ; 3.073070e-003 ];
Tc_error_10  = [ 1.441223e+000 ; 1.001740e+000 ; 3.327816e+000 ];

%-- Image #11:
omc_11 = [ 2.188206e+000 ; 2.030574e+000 ; 1.238961e-001 ];
Tc_11  = [ -2.800834e+002 ; -1.620558e+002 ; 8.084996e+002 ];
omc_error_11 = [ 1.030862e-003 ; 1.249438e-003 ; 2.115468e-003 ];
Tc_error_11  = [ 1.471233e+000 ; 1.013985e+000 ; 3.403108e+000 ];

%-- Image #12:
omc_12 = [ 1.961379e+000 ; 2.165445e+000 ; 3.256195e-003 ];
Tc_12  = [ -2.178462e+002 ; -7.755113e+001 ; 8.431993e+002 ];
omc_error_12 = [ 9.657905e-004 ; 1.289311e-003 ; 1.962892e-003 ];
Tc_error_12  = [ 1.511996e+000 ; 1.046264e+000 ; 3.480317e+000 ];

