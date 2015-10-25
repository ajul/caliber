% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1151.691313847998300 ; 1147.068288243550100 ];

%-- Principal point:
cc = [ 427.372994313580140 ; 376.135459281617220 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.120354214144886 ; -0.342164169201339 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 85.576686791839208 ; 86.694993179392327 ];

%-- Principal point uncertainty:
cc_error = [ 63.726321116482062 ; 57.613054985325704 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.134774532132879 ; 0.379593400541092 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 960;
ny = 720;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 7;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -9.675741e-002 ; 2.948107e+000 ; -2.157625e-001 ];
Tc_1  = [ 1.268437e+001 ; -1.319955e+001 ; 4.411034e+001 ];
omc_error_1 = [ 1.359750e-002 ; 3.634487e-002 ; 5.366381e-002 ];
Tc_error_1  = [ 2.383507e+000 ; 2.200258e+000 ; 3.450855e+000 ];

%-- Image #2:
omc_2 = [ -3.909280e-001 ; 3.054261e+000 ; 3.333648e-002 ];
Tc_2  = [ 1.160808e+001 ; -1.074439e+001 ; 4.296351e+001 ];
omc_error_2 = [ 1.099577e-002 ; 3.357026e-002 ; 6.028598e-002 ];
Tc_error_2  = [ 2.324946e+000 ; 2.162847e+000 ; 3.375267e+000 ];

%-- Image #3:
omc_3 = [ -2.552726e+000 ; 1.018248e+000 ; -5.697393e-002 ];
Tc_3  = [ 1.439885e+001 ; 1.181311e+001 ; 4.490760e+001 ];
omc_error_3 = [ 3.592662e-002 ; 2.863084e-002 ; 5.820254e-002 ];
Tc_error_3  = [ 2.521142e+000 ; 2.151381e+000 ; 3.399360e+000 ];

%-- Image #4:
omc_4 = [ -9.552163e-001 ; -2.955003e+000 ; 7.687270e-002 ];
Tc_4  = [ 6.567427e+000 ; -1.476834e+001 ; 5.013851e+001 ];
omc_error_4 = [ 1.455482e-002 ; 3.460910e-002 ; 8.807222e-002 ];
Tc_error_4  = [ 2.761786e+000 ; 2.506387e+000 ; 3.831170e+000 ];

%-- Image #5:
omc_5 = [ 4.817689e-001 ; 2.753141e+000 ; -1.030093e+000 ];
Tc_5  = [ 1.211288e+001 ; -1.053080e+001 ; 5.527515e+001 ];
omc_error_5 = [ 2.756766e-002 ; 5.947360e-002 ; 5.735370e-002 ];
Tc_error_5  = [ 3.120182e+000 ; 2.719990e+000 ; 3.842204e+000 ];

%-- Image #6:
omc_6 = [ -8.340626e-001 ; 2.333787e+000 ; 1.141660e+000 ];
Tc_6  = [ 1.847961e+001 ; 4.248100e+000 ; 4.879936e+001 ];
omc_error_6 = [ 3.145769e-002 ; 6.055346e-002 ; 6.231944e-002 ];
Tc_error_6  = [ 2.810474e+000 ; 2.408465e+000 ; 3.622408e+000 ];

%-- Image #7:
omc_7 = [ 9.566957e-002 ; 2.427651e+000 ; 7.566446e-001 ];
Tc_7  = [ 4.661549e+000 ; -1.573666e+001 ; 5.583370e+001 ];
omc_error_7 = [ 2.661319e-002 ; 5.956206e-002 ; 6.677891e-002 ];
Tc_error_7  = [ 3.078535e+000 ; 2.886299e+000 ; 4.289276e+000 ];

