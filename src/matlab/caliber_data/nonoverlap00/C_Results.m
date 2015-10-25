% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1638.156259895228900 ; 1636.326910640676000 ];

%-- Principal point:
cc = [ 673.842182324846820 ; 441.220908826685100 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.208985134520772 ; 0.146459627355969 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 29.556589335817272 ; 29.388512384235465 ];

%-- Principal point uncertainty:
cc_error = [ 11.099790800589938 ; 17.832791581015062 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.008626587309464 ; 0.046040883894677 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.019519e+000 ; 2.004104e+000 ; -7.779560e-002 ];
Tc_1  = [ -1.241360e+002 ; -2.061248e+001 ; 9.637947e+002 ];
omc_error_1 = [ 7.044957e-003 ; 6.569867e-003 ; 8.413887e-003 ];
Tc_error_1  = [ 6.549135e+000 ; 1.051654e+001 ; 1.731942e+001 ];

%-- Image #2:
omc_2 = [ 2.075595e+000 ; 2.103893e+000 ; -2.778118e-001 ];
Tc_2  = [ 5.983397e+001 ; -8.523729e+000 ; 9.967420e+002 ];
omc_error_2 = [ 7.183194e-003 ; 7.435559e-003 ; 8.356664e-003 ];
Tc_error_2  = [ 6.754579e+000 ; 1.084741e+001 ; 1.802326e+001 ];

%-- Image #3:
omc_3 = [ 2.026788e+000 ; 2.064148e+000 ; -3.533687e-001 ];
Tc_3  = [ 6.047274e+001 ; 7.073752e+001 ; 1.005048e+003 ];
omc_error_3 = [ 6.965530e-003 ; 7.244648e-003 ; 8.395800e-003 ];
Tc_error_3  = [ 6.825737e+000 ; 1.098835e+001 ; 1.794420e+001 ];

%-- Image #4:
omc_4 = [ 1.929317e+000 ; 1.925140e+000 ; -6.438900e-002 ];
Tc_4  = [ -2.122123e+002 ; 5.624421e+001 ; 9.457313e+002 ];
omc_error_4 = [ 6.677917e-003 ; 6.070122e-003 ; 8.945970e-003 ];
Tc_error_4  = [ 6.476405e+000 ; 1.044385e+001 ; 1.693650e+001 ];

%-- Image #5:
omc_5 = [ 2.072663e+000 ; 1.984680e+000 ; 1.458513e-001 ];
Tc_5  = [ -2.161065e+002 ; -1.422683e+002 ; 9.061532e+002 ];
omc_error_5 = [ 7.326009e-003 ; 6.216403e-003 ; 8.923200e-003 ];
Tc_error_5  = [ 6.289828e+000 ; 9.954563e+000 ; 1.720894e+001 ];

%-- Image #6:
omc_6 = [ 1.701257e+000 ; 2.122854e+000 ; -5.255188e-002 ];
Tc_6  = [ -1.615200e+002 ; 1.416138e+001 ; 9.563141e+002 ];
omc_error_6 = [ 6.218257e-003 ; 6.440533e-003 ; 9.344970e-003 ];
Tc_error_6  = [ 6.532665e+000 ; 1.049389e+001 ; 1.719408e+001 ];

%-- Image #7:
omc_7 = [ 1.643131e+000 ; 2.107746e+000 ; -2.555961e-001 ];
Tc_7  = [ -9.589161e+001 ; 1.558767e+002 ; 9.815109e+002 ];
omc_error_7 = [ 5.869002e-003 ; 6.710305e-003 ; 9.289300e-003 ];
Tc_error_7  = [ 6.699533e+000 ; 1.085601e+001 ; 1.736992e+001 ];

%-- Image #8:
omc_8 = [ 1.730918e+000 ; 2.209587e+000 ; -4.058501e-001 ];
Tc_8  = [ 8.380747e+001 ; 1.495437e+002 ; 1.008446e+003 ];
omc_error_8 = [ 6.515467e-003 ; 7.887034e-003 ; 9.232281e-003 ];
Tc_error_8  = [ 6.890616e+000 ; 1.111471e+001 ; 1.805174e+001 ];

%-- Image #9:
omc_9 = [ 1.832495e+000 ; 2.299890e+000 ; -2.110606e-001 ];
Tc_9  = [ 8.265416e+001 ; -4.381661e+001 ; 9.918242e+002 ];
omc_error_9 = [ 6.890335e-003 ; 8.041108e-003 ; 8.536182e-003 ];
Tc_error_9  = [ 6.714962e+000 ; 1.079476e+001 ; 1.823873e+001 ];

%-- Image #10:
omc_10 = [ 2.625661e+000 ; 1.546343e+000 ; -1.028031e-001 ];
Tc_10  = [ -1.393835e+002 ; -4.788144e+001 ; 9.588685e+002 ];
omc_error_10 = [ 7.529839e-003 ; 5.219470e-003 ; 9.616028e-003 ];
Tc_error_10  = [ 6.498109e+000 ; 1.045460e+001 ; 1.722804e+001 ];

%-- Image #11:
omc_11 = [ 2.620124e+000 ; 1.421130e+000 ; 1.841662e-001 ];
Tc_11  = [ -3.420765e+002 ; -6.823159e+001 ; 8.750632e+002 ];
omc_error_11 = [ 6.693861e-003 ; 4.111678e-003 ; 8.435783e-003 ];
Tc_error_11  = [ 6.203537e+000 ; 9.770229e+000 ; 1.678099e+001 ];

%-- Image #12:
omc_12 = [ 2.676447e+000 ; 1.443045e+000 ; 2.230423e-001 ];
Tc_12  = [ -3.297893e+002 ; -1.268155e+002 ; 8.656536e+002 ];
omc_error_12 = [ 6.573905e-003 ; 4.124228e-003 ; 9.108135e-003 ];
Tc_error_12  = [ 6.140172e+000 ; 9.649873e+000 ; 1.681322e+001 ];

