function [ imagePoints ] = randImage( K, kc, Q, worldPoints, imageNoise )
import caliber.math.projection.*
imagePoints = standardProjection(K, kc, Q, worldPoints);
imagePoints = imagePoints + (2 * rand(size(imagePoints)) - 1) * imageNoise;

end

