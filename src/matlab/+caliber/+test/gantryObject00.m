close all;
clear all;

objectAngles = [ones(5,1)*0; ones(5,1)*30; ones(5,1)*60; ones(5,1)*90; ones(5,1)*120];
cameraArmAngles = zeros(25, 2);
cameraArmAngles(1:25, 2) = repmat([-28;-13;2;17;32], 5, 1);

caliber.special.gantryObject('caliber_data/gantryObject00/Calib_results.mat', objectAngles, cameraArmAngles);