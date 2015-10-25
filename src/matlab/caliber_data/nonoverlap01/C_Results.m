% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2504.632298559472000 ; 2516.020989410626500 ];

%-- Principal point:
cc = [ 544.131916012320740 ; 505.525331867567330 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.208331238543749 ; -0.147712721489392 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 22.348375768450069 ; 15.728112213035653 ];

%-- Principal point uncertainty:
cc_error = [ 22.842139432983302 ; 20.431198056576026 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.010594346197431 ; 0.098035026870937 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ -1.824865e+000 ; -2.004248e+000 ; 8.461986e-001 ];
Tc_1  = [ -5.202676e+000 ; -9.759653e+001 ; 1.817910e+003 ];
omc_error_1 = [ 6.465051e-003 ; 5.097260e-003 ; 1.090213e-002 ];
Tc_error_1  = [ 1.657348e+001 ; 1.471908e+001 ; 1.212531e+001 ];

%-- Image #2:
omc_2 = [ -1.716479e+000 ; -1.914547e+000 ; 9.459639e-001 ];
Tc_2  = [ 2.676426e+002 ; -9.798625e+001 ; 1.821287e+003 ];
omc_error_2 = [ 6.623222e-003 ; 4.815712e-003 ; 9.889383e-003 ];
Tc_error_2  = [ 1.720314e+001 ; 1.481755e+001 ; 1.192788e+001 ];

%-- Image #3:
omc_3 = [ -1.942340e+000 ; -2.098412e+000 ; 7.236266e-001 ];
Tc_3  = [ -3.062021e+002 ; -9.820496e+001 ; 1.769513e+003 ];
omc_error_3 = [ 6.262907e-003 ; 5.331525e-003 ; 1.206436e-002 ];
Tc_error_3  = [ 1.570334e+001 ; 1.441376e+001 ; 1.258154e+001 ];

%-- Image #4:
omc_4 = [ -1.930305e+000 ; -2.002011e+000 ; 6.308833e-001 ];
Tc_4  = [ -2.679210e+002 ; -2.430074e+002 ; 1.755192e+003 ];
omc_error_4 = [ 5.893767e-003 ; 4.790173e-003 ; 1.268709e-002 ];
Tc_error_4  = [ 1.563768e+001 ; 1.428908e+001 ; 1.268555e+001 ];

%-- Image #5:
omc_5 = [ -1.696603e+000 ; -1.843582e+000 ; 8.407938e-001 ];
Tc_5  = [ 2.944264e+002 ; -2.831064e+002 ; 1.787022e+003 ];
omc_error_5 = [ 6.272328e-003 ; 4.423689e-003 ; 1.019842e-002 ];
Tc_error_5  = [ 1.708728e+001 ; 1.456102e+001 ; 1.245199e+001 ];

%-- Image #6:
omc_6 = [ -1.848313e+000 ; -1.747526e+000 ; 1.017958e+000 ];
Tc_6  = [ 2.913376e+002 ; 6.907212e+001 ; 1.835707e+003 ];
omc_error_6 = [ 6.845605e-003 ; 4.593065e-003 ; 9.650734e-003 ];
Tc_error_6  = [ 1.743804e+001 ; 1.499712e+001 ; 1.123286e+001 ];

%-- Image #7:
omc_7 = [ -2.044957e+000 ; -1.907207e+000 ; 8.616972e-001 ];
Tc_7  = [ -1.832944e+002 ; 1.268866e+002 ; 1.813442e+003 ];
omc_error_7 = [ 6.565569e-003 ; 5.205426e-003 ; 1.141077e-002 ];
Tc_error_7  = [ 1.622637e+001 ; 1.481670e+001 ; 1.176437e+001 ];

%-- Image #8:
omc_8 = [ -1.755114e+000 ; -2.163185e+000 ; 7.304236e-001 ];
Tc_8  = [ -1.245883e+002 ; -2.566435e+002 ; 1.775150e+003 ];
omc_error_8 = [ 6.165050e-003 ; 5.127652e-003 ; 1.137189e-002 ];
Tc_error_8  = [ 1.606060e+001 ; 1.429571e+001 ; 1.289452e+001 ];

%-- Image #9:
omc_9 = [ -1.613383e+000 ; -2.046275e+000 ; 8.865110e-001 ];
Tc_9  = [ 2.449842e+002 ; -2.195981e+002 ; 1.800692e+003 ];
omc_error_9 = [ 6.525216e-003 ; 4.932619e-003 ; 9.899307e-003 ];
Tc_error_9  = [ 1.696205e+001 ; 1.455908e+001 ; 1.264956e+001 ];

%-- Image #10:
omc_10 = [ -1.595108e+000 ; -2.109320e+000 ; 1.040611e+000 ];
Tc_10  = [ 2.647663e+002 ; 1.087510e-001 ; 1.827186e+003 ];
omc_error_10 = [ 7.089322e-003 ; 5.317034e-003 ; 8.978695e-003 ];
Tc_error_10  = [ 1.714574e+001 ; 1.489432e+001 ; 1.231444e+001 ];

%-- Image #11:
omc_11 = [ -1.743175e+000 ; -2.261215e+000 ; 8.562247e-001 ];
Tc_11  = [ -1.473266e+002 ; -8.354649e+001 ; 1.798076e+003 ];
omc_error_11 = [ 6.663788e-003 ; 5.610755e-003 ; 1.060880e-002 ];
Tc_error_11  = [ 1.620549e+001 ; 1.453491e+001 ; 1.281124e+001 ];

%-- Image #12:
omc_12 = [ -2.013929e+000 ; -1.799531e+000 ; 9.330306e-001 ];
Tc_12  = [ -8.702658e+000 ; 1.503111e+002 ; 1.835456e+003 ];
omc_error_12 = [ 6.751561e-003 ; 4.947910e-003 ; 1.077997e-002 ];
Tc_error_12  = [ 1.673801e+001 ; 1.496185e+001 ; 1.137731e+001 ];

