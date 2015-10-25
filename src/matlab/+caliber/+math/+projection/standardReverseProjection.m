function [ result ] = standardReverseProjection( K, kc, M, imagePoints, derivType, dValue )
%FULLPROJECTION The projection function and derivatives for the
    import caliber.math.projection.*
    if nargin < 5
        derivType = 0;
    end
    
    switch (derivType)
        case 0
            distortedPoints = cameraIntrinsics( K, imagePoints );
            unitPlanePoints = radialDistortion( kc, distortedPoints );
            result = wallProjection(M, unitPlanePoints);
        case 1
            distortedPoints = cameraIntrinsics( K, imagePoints );
            ddistortedPoints = cameraIntrinsics( K, imagePoints, 1, dValue );
            unitPlanePoints = radialDistortion( kc, distortedPoints );
            dunitPlanePoints = radialDistortion( kc, distortedPoints, 2, ddistortedPoints );
            result = wallProjection(M, unitPlanePoints, 2, dunitPlanePoints);
        case 2
            distortedPoints = cameraIntrinsics( K, imagePoints );
            unitPlanePoints = radialDistortion( kc, distortedPoints );
            dunitPlanePoints = radialDistortion( kc, distortedPoints, 1, dValue );
            result = wallProjection(M, unitPlanePoints, 2, dunitPlanePoints);
        case 3
            distortedPoints = cameraIntrinsics( K, imagePoints );
            unitPlanePoints = radialDistortion( kc, distortedPoints );
            result = wallProjection(M, unitPlanePoints, 1, dValue);
        case 4
            distortedPoints = cameraIntrinsics( K, imagePoints );
            ddistortedPoints = cameraIntrinsics( K, imagePoints, 2, dValue );
            unitPlanePoints = radialDistortion( kc, distortedPoints );
            dunitPlanePoints = radialDistortion( kc, distortedPoints, 2, ddistortedPoints );
            result = wallProjection(M, unitPlanePoints, 2, dunitPlanePoints);
    end
end
