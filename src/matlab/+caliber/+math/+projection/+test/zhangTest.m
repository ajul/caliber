import caliber.math.*

numImages = 4;
numPoints = 10;

planePoints = randn(2, numPoints) * 10;
worldPoints = [planePoints; zeros(1, numPoints)];

Ms = cell(1, numImages);
K = [600 0 320; 0 600 240; 0 0 1];

planePointsn = cell(1, numImages);
imagePoints = cell(1, numImages);
for i = 1:numImages
    Ms{i} = randRigid() + [zeros(3) [0;0;100]; 0 0 0 0];
    planePointsn{i} = planePoints;
    imagePoints{i} = caliber.math.projection.standardProjection(K, [], Ms{i}, worldPoints);
end

[solvedK, solvedM] = caliber.math.projection.zhang(planePointsn, imagePoints);

