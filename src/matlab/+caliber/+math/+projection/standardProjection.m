function [ imagePoints ] = standardProjection( K, kc, M, worldPoints, derivType, dValue )
%FULLPROJECTION The projection function and derivatives for the
%conventional camera.
% K: intrinsic matrix
% kc: radial distortion coefficients
% M: extrinsic matrix
% worldPoints: the worldspace points to project
% derivType, dValue (optional):
%   If derivType is given and greater than 0, the output is not the
%   projection itself, but its derivative with respect to a parameter
%   that is affecting the derivTypeth argument according to dValue.
%   For example, suppose derivType = 2 (i.e. kc, radial distortion).
%   Then dValue should be d(kc)/d(x), and standardProjection computes
%   d(imagePoints)/d(x) = d(imagePoints)/d(kc) * d(kc)/d(x).
% 
% The subroutines of standardProjection are normalizedProjection,
% radialDistortion, and applyK. All of these follow the same derivType
% convention as above, except they only have two arguments before
% derivType, the first being some parameter (M, kc, and K respectively),
% and the second being the result of the previous projection stage.
% The results are composed by standardProjection according to the chain rule.
    import caliber.math.projection.*
    if nargin < 5
        derivType = 0;
    end
    
    switch (derivType)
        case 0
            unitPlanePoints = normalizedProjection( M, worldPoints );
            distortedPoints = radialDistortion( kc, unitPlanePoints );
            imagePoints = cameraIntrinsics( K, distortedPoints );
        case 1
            unitPlanePoints = normalizedProjection( M, worldPoints );
            distortedPoints = radialDistortion( kc, unitPlanePoints );
            imagePoints = cameraIntrinsics( K, distortedPoints, 1, dValue );
        case 2
            unitPlanePoints = normalizedProjection( M, worldPoints );
            distortedPoints = radialDistortion( kc, unitPlanePoints );
            ddistortedPoints = radialDistortion( kc, unitPlanePoints, 1, dValue );
            imagePoints = cameraIntrinsics( K, distortedPoints, 2, ddistortedPoints );
        case 3
            unitPlanePoints = normalizedProjection( M, worldPoints );
            dunitPlanePoints = normalizedProjection( M, worldPoints, 1, dValue );
            distortedPoints = radialDistortion( kc, unitPlanePoints );
            ddistortedPoints = radialDistortion( kc, unitPlanePoints, 2, dunitPlanePoints );
            imagePoints = cameraIntrinsics( K, distortedPoints, 2, ddistortedPoints );
        case 4
            unitPlanePoints = normalizedProjection( M, worldPoints );
            dunitPlanePoints = normalizedProjection( M, worldPoints, 2, dValue );
            distortedPoints = radialDistortion( kc, unitPlanePoints );
            ddistortedPoints = radialDistortion( kc, unitPlanePoints, 2, dunitPlanePoints );
            imagePoints = cameraIntrinsics( K, distortedPoints, 2, ddistortedPoints );
    end
end
