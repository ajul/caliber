% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2472.045398890845700 ; 2474.658550623738800 ];

%-- Principal point:
cc = [ 688.583300661733010 ; 482.629219894345340 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.253783276853221 ; 0.225584608087056 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 85.219498687348093 ; 88.296978472360621 ];

%-- Principal point uncertainty:
cc_error = [ 35.310721136102813 ; 47.564107400321525 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.032992422172494 ; 0.308679006872238 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

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
omc_1 = [ 2.153697e+000 ; 1.962538e+000 ; -2.555018e-002 ];
Tc_1  = [ -1.789563e+002 ; -6.221022e+001 ; 1.463056e+003 ];
omc_error_1 = [ 9.224002e-003 ; 9.147571e-003 ; 1.896337e-002 ];
Tc_error_1  = [ 2.100294e+001 ; 2.813954e+001 ; 5.054256e+001 ];

%-- Image #2:
omc_2 = [ 2.224961e+000 ; 2.064872e+000 ; -2.024893e-001 ];
Tc_2  = [ 7.796021e+001 ; -8.207973e+001 ; 1.464157e+003 ];
omc_error_2 = [ 1.120144e-002 ; 1.148790e-002 ; 1.955423e-002 ];
Tc_error_2  = [ 2.093535e+001 ; 2.805822e+001 ; 5.106819e+001 ];

%-- Image #3:
omc_3 = [ 2.111515e+000 ; 2.039740e+000 ; -8.313598e-002 ];
Tc_3  = [ -8.935798e+001 ; -4.403240e+001 ; 1.473299e+003 ];
omc_error_3 = [ 9.562061e-003 ; 9.753040e-003 ; 1.848714e-002 ];
Tc_error_3  = [ 2.108063e+001 ; 2.828216e+001 ; 5.089729e+001 ];

%-- Image #4:
omc_4 = [ 2.182502e+000 ; 2.147254e+000 ; -2.954087e-001 ];
Tc_4  = [ 1.997078e+002 ; -5.127943e+001 ; 1.456359e+003 ];
omc_error_4 = [ 1.079548e-002 ; 1.179355e-002 ; 2.041036e-002 ];
Tc_error_4  = [ 2.086439e+001 ; 2.805136e+001 ; 5.183469e+001 ];

%-- Image #5:
omc_5 = [ 2.177689e+000 ; 2.204759e+000 ; -1.738780e-001 ];
Tc_5  = [ 1.538197e+002 ; -1.579177e+002 ; 1.441678e+003 ];
omc_error_5 = [ 1.228565e-002 ; 1.330146e-002 ; 1.941594e-002 ];
Tc_error_5  = [ 2.066376e+001 ; 2.765762e+001 ; 5.143502e+001 ];

%-- Image #6:
omc_6 = [ 2.064565e+000 ; 2.004198e+000 ; 1.597678e-001 ];
Tc_6  = [ -3.138998e+002 ; -1.583989e+002 ; 1.422718e+003 ];
omc_error_6 = [ 8.390049e-003 ; 7.796521e-003 ; 2.006512e-002 ];
Tc_error_6  = [ 2.084681e+001 ; 2.753844e+001 ; 5.092843e+001 ];

