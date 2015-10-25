% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1372.739782899998100 ; 1375.105046531663400 ];

%-- Principal point:
cc = [ 599.571803467747600 ; 513.848179069306520 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.802295609333538 ; 31.003967346165933 ; -0.000000000000000 ; -0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 12.287842032445321 ; 8.408669671713396 ];

%-- Principal point uncertainty:
cc_error = [ 7.625790875456533 ; 7.976616840159029 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.167738766695479 ; 15.262460300076720 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1300;
ny = 1030;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 43;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ NaN ; NaN ; NaN ];
Tc_1  = [ NaN ; NaN ; NaN ];
omc_error_1 = [ NaN ; NaN ; NaN ];
Tc_error_1  = [ NaN ; NaN ; NaN ];

%-- Image #2:
omc_2 = [ NaN ; NaN ; NaN ];
Tc_2  = [ NaN ; NaN ; NaN ];
omc_error_2 = [ NaN ; NaN ; NaN ];
Tc_error_2  = [ NaN ; NaN ; NaN ];

%-- Image #3:
omc_3 = [ NaN ; NaN ; NaN ];
Tc_3  = [ NaN ; NaN ; NaN ];
omc_error_3 = [ NaN ; NaN ; NaN ];
Tc_error_3  = [ NaN ; NaN ; NaN ];

%-- Image #4:
omc_4 = [ NaN ; NaN ; NaN ];
Tc_4  = [ NaN ; NaN ; NaN ];
omc_error_4 = [ NaN ; NaN ; NaN ];
Tc_error_4  = [ NaN ; NaN ; NaN ];

%-- Image #5:
omc_5 = [ NaN ; NaN ; NaN ];
Tc_5  = [ NaN ; NaN ; NaN ];
omc_error_5 = [ NaN ; NaN ; NaN ];
Tc_error_5  = [ NaN ; NaN ; NaN ];

%-- Image #6:
omc_6 = [ NaN ; NaN ; NaN ];
Tc_6  = [ NaN ; NaN ; NaN ];
omc_error_6 = [ NaN ; NaN ; NaN ];
Tc_error_6  = [ NaN ; NaN ; NaN ];

%-- Image #7:
omc_7 = [ 1.772066e+000 ; -1.449532e+000 ; -1.038633e+000 ];
Tc_7  = [ -5.259263e-001 ; 4.214419e+000 ; 4.864187e+001 ];
omc_error_7 = [ 6.057171e-003 ; 4.123249e-003 ; 7.233370e-003 ];
Tc_error_7  = [ 2.707091e-001 ; 2.825300e-001 ; 3.030519e-001 ];

%-- Image #8:
omc_8 = [ 1.772035e+000 ; -1.449531e+000 ; -1.038670e+000 ];
Tc_8  = [ -5.256660e-001 ; 4.215522e+000 ; 4.863965e+001 ];
omc_error_8 = [ 6.057180e-003 ; 4.123236e-003 ; 7.233271e-003 ];
Tc_error_8  = [ 2.706972e-001 ; 2.825169e-001 ; 3.030394e-001 ];

%-- Image #9:
omc_9 = [ 1.771995e+000 ; -1.449526e+000 ; -1.038636e+000 ];
Tc_9  = [ -5.255048e-001 ; 4.216069e+000 ; 4.863837e+001 ];
omc_error_9 = [ 6.057106e-003 ; 4.123223e-003 ; 7.233168e-003 ];
Tc_error_9  = [ 2.706903e-001 ; 2.825094e-001 ; 3.030332e-001 ];

%-- Image #10:
omc_10 = [ 2.137046e+000 ; -1.756325e+000 ; -5.895669e-001 ];
Tc_10  = [ 8.186203e-001 ; 4.223594e+000 ; 4.872223e+001 ];
omc_error_10 = [ 6.969088e-003 ; 4.642410e-003 ; 1.028306e-002 ];
Tc_error_10  = [ 2.714803e-001 ; 2.830104e-001 ; 2.931107e-001 ];

%-- Image #11:
omc_11 = [ 2.137077e+000 ; -1.756364e+000 ; -5.895284e-001 ];
Tc_11  = [ 8.186103e-001 ; 4.224199e+000 ; 4.872418e+001 ];
omc_error_11 = [ 6.969432e-003 ; 4.642682e-003 ; 1.028348e-002 ];
Tc_error_11  = [ 2.714913e-001 ; 2.830217e-001 ; 2.931215e-001 ];

%-- Image #12:
omc_12 = [ NaN ; NaN ; NaN ];
Tc_12  = [ NaN ; NaN ; NaN ];
omc_error_12 = [ NaN ; NaN ; NaN ];
Tc_error_12  = [ NaN ; NaN ; NaN ];

%-- Image #13:
omc_13 = [ NaN ; NaN ; NaN ];
Tc_13  = [ NaN ; NaN ; NaN ];
omc_error_13 = [ NaN ; NaN ; NaN ];
Tc_error_13  = [ NaN ; NaN ; NaN ];

%-- Image #14:
omc_14 = [ NaN ; NaN ; NaN ];
Tc_14  = [ NaN ; NaN ; NaN ];
omc_error_14 = [ NaN ; NaN ; NaN ];
Tc_error_14  = [ NaN ; NaN ; NaN ];

%-- Image #15:
omc_15 = [ NaN ; NaN ; NaN ];
Tc_15  = [ NaN ; NaN ; NaN ];
omc_error_15 = [ NaN ; NaN ; NaN ];
Tc_error_15  = [ NaN ; NaN ; NaN ];

%-- Image #16:
omc_16 = [ NaN ; NaN ; NaN ];
Tc_16  = [ NaN ; NaN ; NaN ];
omc_error_16 = [ NaN ; NaN ; NaN ];
Tc_error_16  = [ NaN ; NaN ; NaN ];

%-- Image #17:
omc_17 = [ NaN ; NaN ; NaN ];
Tc_17  = [ NaN ; NaN ; NaN ];
omc_error_17 = [ NaN ; NaN ; NaN ];
Tc_error_17  = [ NaN ; NaN ; NaN ];

%-- Image #18:
omc_18 = [ -1.340619e+000 ; 1.732815e+000 ; -7.697319e-001 ];
Tc_18  = [ 3.333036e+000 ; 2.854480e+000 ; 5.351223e+001 ];
omc_error_18 = [ 5.277181e-003 ; 5.147328e-003 ; 6.886949e-003 ];
Tc_error_18  = [ 2.995212e-001 ; 3.113442e-001 ; 3.043294e-001 ];

%-- Image #19:
omc_19 = [ -1.340638e+000 ; 1.732837e+000 ; -7.697191e-001 ];
Tc_19  = [ 3.333098e+000 ; 2.854917e+000 ; 5.351293e+001 ];
omc_error_19 = [ 5.277176e-003 ; 5.147371e-003 ; 6.887053e-003 ];
Tc_error_19  = [ 2.995252e-001 ; 3.113482e-001 ; 3.043345e-001 ];

%-- Image #20:
omc_20 = [ -1.340648e+000 ; 1.732815e+000 ; -7.697947e-001 ];
Tc_20  = [ 3.332995e+000 ; 2.855291e+000 ; 5.351362e+001 ];
omc_error_20 = [ 5.277249e-003 ; 5.147364e-003 ; 6.886951e-003 ];
Tc_error_20  = [ 2.995290e-001 ; 3.113521e-001 ; 3.043389e-001 ];

%-- Image #21:
omc_21 = [ -1.647537e+000 ; 2.119336e+000 ; -4.271668e-001 ];
Tc_21  = [ 4.063296e+000 ; 2.895605e+000 ; 5.153323e+001 ];
omc_error_21 = [ 5.749950e-003 ; 6.498781e-003 ; 1.007973e-002 ];
Tc_error_21  = [ 2.885705e-001 ; 2.998455e-001 ; 3.115999e-001 ];

%-- Image #22:
omc_22 = [ -1.647568e+000 ; 2.119317e+000 ; -4.272510e-001 ];
Tc_22  = [ 4.063229e+000 ; 2.896287e+000 ; 5.153235e+001 ];
omc_error_22 = [ 5.750091e-003 ; 6.498760e-003 ; 1.007916e-002 ];
Tc_error_22  = [ 2.885657e-001 ; 2.998403e-001 ; 3.115941e-001 ];

%-- Image #23:
omc_23 = [ -6.956288e-001 ; 2.535060e+000 ; -1.753259e-001 ];
Tc_23  = [ 5.158051e+000 ; -7.440354e-001 ; 5.214529e+001 ];
omc_error_23 = [ 3.268970e-003 ; 8.569658e-003 ; 8.548890e-003 ];
Tc_error_23  = [ 2.923194e-001 ; 3.036923e-001 ; 3.157513e-001 ];

%-- Image #24:
omc_24 = [ -5.527405e-001 ; 2.034480e+000 ; -3.173907e-001 ];
Tc_24  = [ 3.956943e+000 ; -7.851766e-001 ; 5.461067e+001 ];
omc_error_24 = [ 3.951228e-003 ; 6.135102e-003 ; 6.424510e-003 ];
Tc_error_24  = [ 3.059311e-001 ; 3.178721e-001 ; 3.086824e-001 ];

%-- Image #25:
omc_25 = [ -5.527550e-001 ; 2.034489e+000 ; -3.173996e-001 ];
Tc_25  = [ 3.957038e+000 ; -7.851641e-001 ; 5.461145e+001 ];
omc_error_25 = [ 3.951229e-003 ; 6.135121e-003 ; 6.424564e-003 ];
Tc_error_25  = [ 3.059355e-001 ; 3.178766e-001 ; 3.086873e-001 ];

%-- Image #26:
omc_26 = [ NaN ; NaN ; NaN ];
Tc_26  = [ NaN ; NaN ; NaN ];
omc_error_26 = [ NaN ; NaN ; NaN ];
Tc_error_26  = [ NaN ; NaN ; NaN ];

%-- Image #27:
omc_27 = [ NaN ; NaN ; NaN ];
Tc_27  = [ NaN ; NaN ; NaN ];
omc_error_27 = [ NaN ; NaN ; NaN ];
Tc_error_27  = [ NaN ; NaN ; NaN ];

%-- Image #28:
omc_28 = [ NaN ; NaN ; NaN ];
Tc_28  = [ NaN ; NaN ; NaN ];
omc_error_28 = [ NaN ; NaN ; NaN ];
Tc_error_28  = [ NaN ; NaN ; NaN ];

%-- Image #29:
omc_29 = [ NaN ; NaN ; NaN ];
Tc_29  = [ NaN ; NaN ; NaN ];
omc_error_29 = [ NaN ; NaN ; NaN ];
Tc_error_29  = [ NaN ; NaN ; NaN ];

%-- Image #30:
omc_30 = [ 2.790552e+000 ; -8.479927e-001 ; -7.511940e-001 ];
Tc_30  = [ -2.510996e+000 ; 4.244598e+000 ; 5.070782e+001 ];
omc_error_30 = [ 7.482189e-003 ; 1.981413e-003 ; 1.213562e-002 ];
Tc_error_30  = [ 2.820172e-001 ; 2.949691e-001 ; 3.066541e-001 ];

%-- Image #31:
omc_31 = [ 2.402079e+000 ; -7.244980e-001 ; -1.395306e+000 ];
Tc_31  = [ -2.444984e+000 ; 4.206205e+000 ; 5.204016e+001 ];
omc_error_31 = [ 6.768314e-003 ; 3.653593e-003 ; 8.072292e-003 ];
Tc_error_31  = [ 2.895005e-001 ; 3.026410e-001 ; 3.100724e-001 ];

%-- Image #32:
omc_32 = [ 2.402064e+000 ; -7.244800e-001 ; -1.395317e+000 ];
Tc_32  = [ -2.445160e+000 ; 4.205783e+000 ; 5.204094e+001 ];
omc_error_32 = [ 6.768301e-003 ; 3.653680e-003 ; 8.072205e-003 ];
Tc_error_32  = [ 2.895047e-001 ; 3.026456e-001 ; 3.100768e-001 ];

%-- Image #33:
omc_33 = [ NaN ; NaN ; NaN ];
Tc_33  = [ NaN ; NaN ; NaN ];
omc_error_33 = [ NaN ; NaN ; NaN ];
Tc_error_33  = [ NaN ; NaN ; NaN ];

%-- Image #34:
omc_34 = [ NaN ; NaN ; NaN ];
Tc_34  = [ NaN ; NaN ; NaN ];
omc_error_34 = [ NaN ; NaN ; NaN ];
Tc_error_34  = [ NaN ; NaN ; NaN ];

%-- Image #35:
omc_35 = [ NaN ; NaN ; NaN ];
Tc_35  = [ NaN ; NaN ; NaN ];
omc_error_35 = [ NaN ; NaN ; NaN ];
Tc_error_35  = [ NaN ; NaN ; NaN ];

%-- Image #36:
omc_36 = [ NaN ; NaN ; NaN ];
Tc_36  = [ NaN ; NaN ; NaN ];
omc_error_36 = [ NaN ; NaN ; NaN ];
Tc_error_36  = [ NaN ; NaN ; NaN ];

%-- Image #37:
omc_37 = [ NaN ; NaN ; NaN ];
Tc_37  = [ NaN ; NaN ; NaN ];
omc_error_37 = [ NaN ; NaN ; NaN ];
Tc_error_37  = [ NaN ; NaN ; NaN ];

%-- Image #38:
omc_38 = [ NaN ; NaN ; NaN ];
Tc_38  = [ NaN ; NaN ; NaN ];
omc_error_38 = [ NaN ; NaN ; NaN ];
Tc_error_38  = [ NaN ; NaN ; NaN ];

%-- Image #39:
omc_39 = [ NaN ; NaN ; NaN ];
Tc_39  = [ NaN ; NaN ; NaN ];
omc_error_39 = [ NaN ; NaN ; NaN ];
Tc_error_39  = [ NaN ; NaN ; NaN ];

%-- Image #40:
omc_40 = [ -2.723535e+000 ; -1.121539e-002 ; -1.562469e+000 ];
Tc_40  = [ -6.473725e-001 ; 2.383170e+000 ; 4.675617e+001 ];
omc_error_40 = [ 6.358700e-003 ; 4.644935e-003 ; 9.086526e-003 ];
Tc_error_40  = [ 2.597114e-001 ; 2.715823e-001 ; 2.937087e-001 ];

%-- Image #41:
omc_41 = [ -3.028382e+000 ; -1.944097e-002 ; -7.969463e-001 ];
Tc_41  = [ -2.828373e+000 ; 2.387852e+000 ; 4.765350e+001 ];
omc_error_41 = [ 6.527732e-003 ; 2.417630e-003 ; 1.412582e-002 ];
Tc_error_41  = [ 2.647773e-001 ; 2.770254e-001 ; 2.868461e-001 ];

%-- Image #42:
omc_42 = [ -3.007168e+000 ; -3.225230e-002 ; 8.017938e-001 ];
Tc_42  = [ -4.544926e+000 ; 2.316443e+000 ; 5.184814e+001 ];
omc_error_42 = [ 6.682925e-003 ; 2.503233e-003 ; 1.297530e-002 ];
Tc_error_42  = [ 2.883923e-001 ; 3.017636e-001 ; 3.153969e-001 ];

%-- Image #43:
omc_43 = [ -2.690656e+000 ; -3.561957e-002 ; 1.556121e+000 ];
Tc_43  = [ -3.624212e+000 ; 2.257647e+000 ; 5.403010e+001 ];
omc_error_43 = [ 6.732256e-003 ; 4.614451e-003 ; 8.424092e-003 ];
Tc_error_43  = [ 3.006381e-001 ; 3.143652e-001 ; 3.111970e-001 ];

