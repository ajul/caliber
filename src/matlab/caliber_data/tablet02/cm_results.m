% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 7158.043558537415300 ; 7162.337300312836300 ];

%-- Principal point:
cc = [ 596.089648226657120 ; 413.902801878551430 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.033882442007376 ; -1.407118697393286 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 269.568022840338530 ; 270.975137296727210 ];

%-- Principal point uncertainty:
cc_error = [ 108.332908099595190 ; 99.942625996544507 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.273247314679572 ; 29.432113362656175 ; 0.000000000000000 ; 0.000000000000000 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 16;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 0 ; 0 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.112814e+000 ; 2.450136e+000 ; -3.144781e-001 ];
Tc_1  = [ -7.025450e-002 ; -5.873098e+000 ; 2.086097e+002 ];
omc_error_1 = [ 6.030082e-003 ; 1.422815e-002 ; 1.905951e-002 ];
Tc_error_1  = [ 3.157151e+000 ; 2.910796e+000 ; 7.817132e+000 ];

%-- Image #2:
omc_2 = [ 1.632744e+000 ; 2.101591e+000 ; -1.618586e-001 ];
Tc_2  = [ -2.643132e+000 ; -4.337916e+000 ; 2.073694e+002 ];
omc_error_2 = [ 8.920264e-003 ; 1.272693e-002 ; 1.920843e-002 ];
Tc_error_2  = [ 3.138848e+000 ; 2.893602e+000 ; 7.807109e+000 ];

%-- Image #3:
omc_3 = [ 8.072202e-001 ; 2.714128e+000 ; -4.700314e-001 ];
Tc_3  = [ -1.470314e-001 ; -6.283384e+000 ; 2.078849e+002 ];
omc_error_3 = [ 3.766783e-003 ; 1.504652e-002 ; 2.009633e-002 ];
Tc_error_3  = [ 3.146013e+000 ; 2.900865e+000 ; 7.782494e+000 ];

%-- Image #4:
omc_4 = [ -4.286166e-002 ; 3.121822e+000 ; 9.017267e-002 ];
Tc_4  = [ 3.413428e+000 ; -4.033807e+000 ; 2.049525e+002 ];
omc_error_4 = [ 9.059209e-004 ; 2.143117e-002 ; 4.177773e-002 ];
Tc_error_4  = [ 3.101620e+000 ; 2.859925e+000 ; 7.739280e+000 ];

%-- Image #5:
omc_5 = [ 4.580989e-002 ; -3.078485e+000 ; 6.211923e-001 ];
Tc_5  = [ 3.484525e+000 ; -5.357944e+000 ; 2.076926e+002 ];
omc_error_5 = [ 4.685588e-003 ; 1.477897e-002 ; 2.219157e-002 ];
Tc_error_5  = [ 3.143074e+000 ; 2.897985e+000 ; 7.801081e+000 ];

%-- Image #6:
omc_6 = [ 1.250307e+000 ; 2.652990e+000 ; -5.595479e-001 ];
Tc_6  = [ -4.760596e+000 ; -6.373102e+000 ; 2.014852e+002 ];
omc_error_6 = [ 4.007323e-003 ; 1.511448e-002 ; 2.072161e-002 ];
Tc_error_6  = [ 3.049616e+000 ; 2.811473e+000 ; 7.526535e+000 ];

%-- Image #7:
omc_7 = [ 1.492414e+000 ; 2.434437e+000 ; -2.604411e-001 ];
Tc_7  = [ -5.552129e+000 ; -5.492139e+000 ; 2.001686e+002 ];
omc_error_7 = [ 6.890671e-003 ; 1.372947e-002 ; 2.072282e-002 ];
Tc_error_7  = [ 3.030194e+000 ; 2.793679e+000 ; 7.496780e+000 ];

%-- Image #8:
omc_8 = [ 1.358374e+000 ; 2.090016e+000 ; 1.104319e-001 ];
Tc_8  = [ -5.912560e+000 ; -5.405282e+000 ; 2.007815e+002 ];
omc_error_8 = [ 9.332271e-003 ; 1.247674e-002 ; 1.834704e-002 ];
Tc_error_8  = [ 3.040774e+000 ; 2.802215e+000 ; 7.564562e+000 ];

%-- Image #9:
omc_9 = [ 2.524148e+000 ; 1.854961e+000 ; 4.396377e-002 ];
Tc_9  = [ -6.110574e+000 ; 3.954534e+000 ; 1.519095e+002 ];
omc_error_9 = [ 1.779740e-002 ; 1.299936e-002 ; 2.427454e-002 ];
Tc_error_9  = [ 2.300793e+000 ; 2.120113e+000 ; 5.699072e+000 ];

%-- Image #10:
omc_10 = [ 2.112116e+000 ; 2.315688e+000 ; 9.784678e-003 ];
Tc_10  = [ -1.488645e+000 ; 2.471831e+000 ; 1.522410e+002 ];
omc_error_10 = [ 1.597358e-002 ; 1.697124e-002 ; 3.132076e-002 ];
Tc_error_10  = [ 2.304317e+000 ; 2.124499e+000 ; 5.738729e+000 ];

%-- Image #11:
omc_11 = [ 1.565962e+000 ; 2.591154e+000 ; 7.990708e-002 ];
Tc_11  = [ 2.927261e+000 ; 2.825244e+000 ; 1.528445e+002 ];
omc_error_11 = [ 7.830211e-003 ; 1.139879e-002 ; 2.098988e-002 ];
Tc_error_11  = [ 2.311733e+000 ; 2.134400e+000 ; 5.756260e+000 ];

%-- Image #12:
omc_12 = [ -2.857268e+000 ; -1.158593e+000 ; -3.255261e-001 ];
Tc_12  = [ -1.913353e+000 ; 6.239213e+000 ; 1.504019e+002 ];
omc_error_12 = [ 1.140175e-002 ; 7.037551e-003 ; 2.034159e-002 ];
Tc_error_12  = [ 2.277481e+000 ; 2.099830e+000 ; 5.666612e+000 ];

%-- Image #13:
omc_13 = [ -2.172374e+000 ; -1.670012e+000 ; -3.075044e-001 ];
Tc_13  = [ 2.212436e+000 ; 3.103290e+000 ; 1.398755e+002 ];
omc_error_13 = [ 9.193251e-003 ; 9.756313e-003 ; 2.120889e-002 ];
Tc_error_13  = [ 2.119084e+000 ; 1.951152e+000 ; 5.195423e+000 ];

%-- Image #14:
omc_14 = [ 1.795874e+000 ; 2.254244e+000 ; 1.417045e-001 ];
Tc_14  = [ 3.459262e+000 ; 1.788540e+000 ; 1.459319e+002 ];
omc_error_14 = [ 9.537384e-003 ; 1.054062e-002 ; 2.009722e-002 ];
Tc_error_14  = [ 2.207993e+000 ; 2.037526e+000 ; 5.472093e+000 ];

%-- Image #15:
omc_15 = [ -1.976828e+000 ; -2.397223e+000 ; -3.015086e-001 ];
Tc_15  = [ 3.271426e+000 ; 1.330131e+000 ; 1.392320e+002 ];
omc_error_15 = [ 5.490022e-003 ; 1.022197e-002 ; 2.166515e-002 ];
Tc_error_15  = [ 2.107414e+000 ; 1.943360e+000 ; 5.243829e+000 ];

%-- Image #16:
omc_16 = [ 1.848947e+000 ; 2.316009e+000 ; 4.973674e-001 ];
Tc_16  = [ 3.585522e+000 ; -2.717963e-002 ; 1.391423e+002 ];
omc_error_16 = [ 1.087711e-002 ; 8.335322e-003 ; 2.042406e-002 ];
Tc_error_16  = [ 2.104687e+000 ; 1.942278e+000 ; 5.280968e+000 ];

